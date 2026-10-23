import importlib.util
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest

SCRIPT = Path(__file__).resolve().parents[1] / "skills" / "tailwind-4-docs" / "scripts" / "sync_tailwind_docs.py"
spec = importlib.util.spec_from_file_location("tailwind_sync", SCRIPT)
sync = importlib.util.module_from_spec(spec)
spec.loader.exec_module(sync)


class TailwindSyncTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="tailwind sync ")
        self.addCleanup(self.temp.cleanup)
        self.base = Path(self.temp.name)
        self.clone = self.base / "existing clone"
        self.clone.mkdir()
        self.git("init", "-b", "main")
        self.git("config", "user.name", "Fixture")
        self.git("config", "user.email", "fixture@example.invalid")
        docs = self.clone / "src" / "docs"
        docs.mkdir(parents=True)
        (docs / "example.mdx").write_text("fixture docs")
        index = self.clone / "src" / "app" / "(docs)" / "docs"
        index.mkdir(parents=True)
        (index / "index.tsx").write_text("fixture index")
        self.git("add", ".")
        self.git("commit", "-m", "fixture")

    def git(self, *args):
        return subprocess.run(["git", *args], cwd=self.clone, capture_output=True, text=True, check=True).stdout.strip()

    def test_license_required_before_any_download(self):
        result = subprocess.run([sys.executable, str(SCRIPT), "--repo-url", "invalid://no-network"], capture_output=True, text=True)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("--accept-docs-license", result.stderr)

    def test_dirty_clone_is_never_reset(self):
        target = self.clone / "src" / "docs" / "example.mdx"
        target.write_text("precious uncommitted work")
        with self.assertRaises(SystemExit):
            sync.verify_local_repo(self.clone, "main")
        self.assertEqual(target.read_text(), "precious uncommitted work")

    def test_wrong_ref_is_rejected_without_checkout(self):
        self.git("branch", "old")
        (self.clone / "next").write_text("second commit")
        self.git("add", ".")
        self.git("commit", "-m", "next")
        before = self.git("rev-parse", "HEAD")
        with self.assertRaises(SystemExit):
            sync.verify_local_repo(self.clone, "old")
        self.assertEqual(self.git("rev-parse", "HEAD"), before)
        self.assertEqual(self.git("branch", "--show-current"), "main")

    def test_sync_copies_to_isolated_skill_and_keeps_source_unchanged(self):
        local_script = self.base / "skill" / "scripts" / SCRIPT.name
        local_script.parent.mkdir(parents=True)
        (local_script.parent.parent / "references").mkdir()
        shutil.copy2(SCRIPT, local_script)
        before = self.git("rev-parse", "HEAD")
        result = subprocess.run([sys.executable, str(local_script), "--accept-docs-license", "--local-repo", str(self.clone)], capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        refs = local_script.parent.parent / "references"
        self.assertEqual((refs / "docs" / "example.mdx").read_text(), "fixture docs")
        self.assertIn(before, (refs / "docs-source.txt").read_text())
        self.assertEqual(self.git("status", "--porcelain"), "")
        self.assertEqual(self.git("rev-parse", "HEAD"), before)


if __name__ == "__main__":
    unittest.main()
