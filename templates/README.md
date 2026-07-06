# Template Index

What `bootstrap.sh` does with each file. "Copy" means written once and never
touched again. "Append" means merged into a file the target repo already
has (and skipped if that file doesn't exist yet — see
[../METHODOLOGY.md](../METHODOLOGY.md#part-7--practical-recommendation-by-team-size)).

| File                             | Tier            | Destination                          | Mode   | Gitignored? |
| --------------------------------- | --------------- | ------------------------------------- | ------ | ----------- |
| `agent-persona-attribution.md.tpl`| solo            | `[persona-file]` (default `CLAUDE.md`)| append | no          |
| `commit_template.md`              | solo            | `.github/commit_template.md`          | copy   | no          |
| `README-acknowledgement.md.tpl`   | solo            | `README.md`                           | append | no          |
| `../.markdownlint.json`           | solo            | `.markdownlint.json`                  | copy   | no          |
| `.markdownlint.json`              | solo            | `.github/.markdownlint.json`          | copy   | no          |
| `pull_request_template.md`        | small-team      | `.github/pull_request_template.md`    | copy   | no          |
| `CONTRIBUTING.md.tpl`             | small-team      | `CONTRIBUTING.md`                     | copy   | no          |
| `HUMAN.md.tpl`                    | small-team      | `docs/team/HUMAN.md`                  | copy   | **yes**     |
| *(README pointer)*                | small-team      | `README.md` ("## Team & Process")     | append | no          |
| `AI-POLICY.md.tpl`                | growing-startup | `AI-POLICY.md`                        | copy   | no          |
| `team-state.md.tpl`               | growing-startup | `docs/team/team-state.md`             | copy   | **yes**     |
| `sessions-readme.md.tpl`          | growing-startup | `.claude/sessions/README.md`          | copy   | no          |
| *(README pointer)*                | growing-startup | `README.md` ("## Team & Process")     | append | no          |
| `COMPLIANCE-CHECKLIST.md.tpl`     | enterprise      | `COMPLIANCE-CHECKLIST.md`             | copy   | no          |
| `ai-attribution-workflow.yml.tpl` | enterprise      | `.github/workflows/ai-attribution.yml`| copy   | no          |

`HUMAN.md` and `team-state.md` are gitignored on purpose: they tend to
accumulate PII (your name, availability pattern, calibration history) and
are instance-specific, not something to publish or reuse verbatim across
projects. Every other file here is meant to be committed.

Placeholders filled by `bootstrap.sh --model-id=... --human-name=... --persona-file=...`:
`[model-id]`, `[Name]`, `[Your Name]`, `[persona-file]` (default `CLAUDE.md`,
e.g. `AGENTS.md`, `.cursorrules` — whatever your tool's convention is). A
few templates (`team-state.md.tpl`, `pull_request_template.md`) also
contain bracketed prose like `[date]` or `[feature]` that's meant for you
to fill in by hand later — those are per-instance content, not something a
bootstrap script can guess.
