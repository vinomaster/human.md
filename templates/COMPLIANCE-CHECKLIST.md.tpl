# AI Attribution Compliance Checklist

For teams in regulated industries or approaching audits.

- [ ] [persona-file] defines agent persona and constraints
- [ ] HUMAN.md defines human role and review commitments
- [ ] team-state.md exists and is updated regularly
- [ ] AI-POLICY.md is committed to the repository root
- [ ] PR template includes team attribution block
- [ ] Commit messages carry AI origin trailers
- [ ] AI does not appear as git author or co-author
- [ ] Enable signed commits: `git config --global commit.gpgsign true`
- [ ] Session logs retained in `.claude/sessions/` for significant features
- [ ] AI tool versions documented at time of each release
- [ ] Calibration log reviewed before major releases
- [ ] git-ai or equivalent tooling configured (enterprise / regulated)
