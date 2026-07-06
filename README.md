# human.md

*The personhood half of your CLAUDE.md.*

A human role file for your AI coding agent — plus the templates and policy
that go with it.

## Challenge

AI agents are increasingly contributing to code, articles, research papers, and other work products. While established standards exist for acknowledging human contributions, we still lack a consistent way to restore trust in who—or what—should be credited for the resources we rely on. Rather than asking the binary question, “Was AI involved?”, we need clearer answers to: Who directed the work? Who reviewed it? What level of trust should apply? This repository provides a methodology and a simple set of tools for ensuring contributions follow a consistent attribution pattern.

Every agentic coding tool ships a persona file for the agent — it's just called something different depending on where you work:

| Tool                 | Agent Persona File               |
| -------------------- | --------------------------------- |
| Claude Code           | `CLAUDE.md`                       |
| GitHub Copilot        | `.github/copilot-instructions.md` |
| Cursor                | `.cursorrules`                    |
| Cline                 | `.clinerules`                     |
| Windsurf              | `.windsurfrules`                  |
| Cross-tool standard   | `AGENTS.md`                       |

Whatever your tool calls it, nothing defines the human's role, decision authority, or review commitment. That's a team with one job description and one undefined member.

## Solution

Attribution is not merely a record of provenance—who wrote what. In an environment where agents can generate code, text, analysis, and decisions, attribution must also establish accountability: who directed the work, who reviewed it, what constraints governed it, and what level of trust can reasonably be assigned to it. Agent contributions that lack human attestation should be treated as lower-trust artifacts, because no accountable person has accepted responsibility for their accuracy, intent, legality, or fitness for use. For that reason, only humans should appear as commit authors or co-authors. AI agents, assistants, and tools may contribute to the work, but they cannot bear legal, ethical, or professional responsibility for it. The human who reviews, accepts, and commits the contribution is the accountable author of record.

This repo provides a small set of markdown templates — plus a script that drops them into any repo — that fill in the other half: a **human role** file, a living record of how the pairing is actually going, and an attribution policy that tracks who directed, reviewed, and is accountable for what. No new tools, no new process to learn — just files your team already knows how to read.

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

Tiers are cumulative.

**Before you run it, or if you're customizing a tier:**
[templates/README.md](./templates/README.md) is the full index — every file, which tier unlocks it, exactly where it lands, and whether it's
gitignored.

## Why

The full reasoning — the asymmetry problem, the "lifeline" concept for tracking how a human-agent collaboration (pairing) matures, and the attribution policy this is all in service of — is in [METHODOLOGY.md](./METHODOLOGY.md). Read that if you want the why; this file is just the how.

## Acknowledgement

This project is developed with AI assistance using Claude Code. All
AI-generated code is reviewed by a human before merging.

## Team & Process

- See [CONTRIBUTING.md](./CONTRIBUTING.md) to understand the collaborative team structure.
- See [AI-POLICY.md](./AI-POLICY.md) for the full attribution and accountability policy.
