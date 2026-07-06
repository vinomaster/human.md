# AI Attribution and Accountability Policy

> *Disclaimer: The files in `docs/team/` describe team structure and
> persona working agreements. For PII compliance, these files are
> `.gitignored`.*

## Team Composition

**Human — Dan Gisolfi, Project Architect**
Decision authority, review responsibility, roadmap ownership.
Full persona: `docs/team/HUMAN.md`

**Agent — Claude (claude-sonnet-5), Implementation Lead**
Execution, research, documentation within defined boundaries.
Full persona: `CLAUDE.md`
Current trust levels: `docs/team/team-state.md`

## Tools in Use

- Claude Code (Anthropic) — primary agentic coding assistant
- Claude claude.ai — architecture and documentation drafting

## Attribution Philosophy

Attribution records origin, accountability, review depth, trust context,
and active constraints — not just whether AI was involved.

## Our Practice

- All agent-generated code requires human review before merge
- Commit messages carry AI origin trailers where substantial
- AI does not appear as a git author or co-author
- Security-sensitive code (auth, payments, RLS) requires human authorship
  regardless of agent capability
- Trust levels in `docs/team/team-state.md` determine review depth

## What We Do Not Do

- Ship agent output without reading and understanding it
- Use AI for secrets, credentials, or environment config
- Attribute IP ownership to AI tools
- Approve PRs we do not understand

## Accountability Matrix

| Scenario                                       | Accountable Party  | Attribution Note                          |
| ------------------------------------------------ | -------------------- | -------------------------------------------- |
| Agent generates correct code, human approves   | Human               | Standard AI-origin trailer                |
| Agent generates incorrect code, human approves | Human               | Human review failure — no agent blame     |
| Agent violates a constraint                    | Process gap         | Flag in calibration log, fix in CLAUDE.md |
| Human skips review under time pressure         | Human               | Noted in team-state.md                    |
| Ambiguous scope, agent assumes wrong           | Shared              | Roadmap or CLAUDE.md needs updating       |
