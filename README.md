# human.md

*The personhood half of your CLAUDE.md.*

A human role file for your AI coding agent — plus the templates and policy
that go with it.

Every agentic coding tool ships a persona file for the agent — it's just
called something different depending on where you work:

| Tool                 | Agent Persona File               |
| -------------------- | --------------------------------- |
| Claude Code           | `CLAUDE.md`                       |
| GitHub Copilot        | `.github/copilot-instructions.md` |
| Cursor                | `.cursorrules`                    |
| Cline                 | `.clinerules`                     |
| Windsurf              | `.windsurfrules`                  |
| Cross-tool standard   | `AGENTS.md`                       |

Whatever your tool calls it, nothing defines the human's role, decision authority, or review commitment. That's a team with one job description and one undefined member.

This is a small set of markdown templates — plus a script that drops them into any repo — that fill in the other half: a human role file, a living record of how the pairing is actually going, and an attribution policy that
tracks who directed, reviewed, and is accountable for what. No new tools, no new process to learn — just files your team already knows how to read.

## Quickstart

Clone and run:

```bash
git clone https://github.com/vinomaster/human.md.git
./human.md/bootstrap.sh /path/to/your/repo
```

Or pipe it directly:

```bash
curl -fsSL https://raw.githubusercontent.com/vinomaster/human.md/master/bootstrap.sh \
  | bash -s -- /path/to/your/repo
```

Either way, it scaffolds the `small-team` tier by default: a PR template, CONTRIBUTING.md, and `docs/team/HUMAN.md`. Existing files are never overwritten — re-running it later, or after upgrading tiers, is always safe.

```bash
./bootstrap.sh /path/to/your/repo --tier=growing-startup \
  --persona-file=AGENTS.md --model-id=claude-sonnet-5 --human-name="Jane Doe"
```

`--persona-file` defaults to `CLAUDE.md` but takes whatever your tool uses —
`AGENTS.md`, `.cursorrules`, `.windsurfrules`, anything. See
`bootstrap.sh --help` for the full tier list and options.

## What you get

| Tier              | Adds                                                         |
| ----------------- | -------------------------------------------------------------|
| `solo`             | Commit template, persona-file attribution note, README note  |
| `small-team`       | + PR template, CONTRIBUTING.md, `docs/team/HUMAN.md` (default)|
| `growing-startup`  | + AI-POLICY.md, `docs/team/team-state.md`, session-log convention |
| `enterprise`       | + compliance checklist, example CI attribution workflow      |

Tiers are cumulative. See [templates/README.md](./templates/README.md) for
exactly what each file is and where it lands.

## Why

The full reasoning — the asymmetry problem, the "lifeline" concept for tracking how a human-agent pairing matures, and the attribution policy this
is all in service of — is in [METHODOLOGY.md](./METHODOLOGY.md). Read that if you want the why; this file is just the how.
