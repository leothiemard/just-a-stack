# Maintenance

This repository is a portable personal skill collection. Keep project-specific instructions and company workflows in their separate installation or project repository. Do not copy histories, credentials, internal URLs or machine configuration here.

Read a skill and its callers before editing it. Keep descriptions precise, use references for substantial conditional guidance, and preserve authorization boundaries. Avoid hardcoded checkout paths; accept project context from the caller.

`skills.json` is the installation allowlist. Update it when adding or removing a skill. Record third-party origins and retain license notices. Do not track the optional Tailwind documentation cache.

For script changes, run `python3 -m unittest discover -s tests -v`. The installer must remain read-only by default, preflight conflicts, preserve replaced content and leave unrelated skills alone. Validate edited skills with the active skill-authoring validator. Review the staged file list before pushing.
