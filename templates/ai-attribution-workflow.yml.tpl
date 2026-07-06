# Illustrative only — requires the git-ai CLI (or an equivalent tool) to
# be installed and configured. Adapt or remove before relying on this in CI.
name: AI Attribution Check

on:
  pull_request:

jobs:
  verify-attribution:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Verify AI Code Attribution
        run: git-ai verify --require-human-review
      - name: Generate AI Usage Report
        run: git-ai report --format=json > ai-usage.json
