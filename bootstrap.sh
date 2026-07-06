#!/usr/bin/env bash
# Bootstrap the AI attribution methodology into a target repo, tiered to
# match the "Practical Recommendation by Team Size" table in METHODOLOGY.md.
#
# Works two ways:
#   1. Cloned:   git clone https://github.com/vinomaster/human.md.git && ./bootstrap.sh <target-repo-dir>
#   2. Piped:    curl -fsSL https://raw.githubusercontent.com/vinomaster/human.md/master/bootstrap.sh | bash -s -- <target-repo-dir>
# In piped mode there's no local templates/ directory next to this script, so
# it fetches a copy of this repo into a temp dir first (see TEMPLATES_DIR below).
set -euo pipefail

REPO_ARCHIVE_URL="${ATTRIBUTION_SOURCE_URL:-https://github.com/vinomaster/human.md/archive/refs/heads/master.tar.gz}"

SCRIPT_SOURCE="${BASH_SOURCE[0]:-}"
if [[ -n "$SCRIPT_SOURCE" && -f "$SCRIPT_SOURCE" ]]; then
  SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_SOURCE")" && pwd)"
else
  SCRIPT_DIR=""
fi

if [[ -n "$SCRIPT_DIR" && -d "$SCRIPT_DIR/templates" ]]; then
  TEMPLATES_DIR="$SCRIPT_DIR/templates"
else
  FETCH_DIR="$(mktemp -d)"
  trap 'rm -rf "$FETCH_DIR"' EXIT
  echo "No local templates/ found (likely running via curl | bash) — fetching from $REPO_ARCHIVE_URL ..." >&2
  curl -fsSL "$REPO_ARCHIVE_URL" | tar xz -C "$FETCH_DIR" --strip-components=1
  SCRIPT_DIR="$FETCH_DIR"
  TEMPLATES_DIR="$SCRIPT_DIR/templates"
fi

TIERS=(solo small-team growing-startup enterprise)
DEFAULT_TIER="small-team"

usage() {
  cat <<EOF
Usage: bootstrap.sh <target-repo-dir> [--tier=<tier>] [options]

Tiers (cumulative — each includes everything in the tiers before it):
  solo              README note + persona-file attribution + commit template
  small-team        + PR template + CONTRIBUTING.md + docs/team/HUMAN.md  (default)
  growing-startup   + AI-POLICY.md + docs/team/team-state.md + session-log convention
  enterprise        + compliance checklist + example CI attribution workflow

Options:
  --tier=<tier>          defaults to '$DEFAULT_TIER' if omitted
  --persona-file=<name>  e.g. AGENTS.md, .cursorrules (default: CLAUDE.md)
  --model-id=<id>        e.g. claude-sonnet-5 (default: leaves [model-id] placeholder)
  --human-name=<name>    e.g. "Jane Doe" (default: leaves [Name] placeholder)

Existing files are never overwritten — the script skips and reports them.
The persona file and README.md merges are skipped (with a note) if those
files don't exist yet; create them first, then re-run.
EOF
}

TIER="$DEFAULT_TIER"
PERSONA_FILE="CLAUDE.md"
MODEL_ID="[model-id]"
HUMAN_NAME="[Name]"
TARGET=""

for arg in "$@"; do
  case "$arg" in
    --tier=*) TIER="${arg#*=}" ;;
    --persona-file=*) PERSONA_FILE="${arg#*=}" ;;
    --model-id=*) MODEL_ID="${arg#*=}" ;;
    --human-name=*) HUMAN_NAME="${arg#*=}" ;;
    -h|--help) usage; exit 0 ;;
    -*) echo "Unknown option: $arg" >&2; usage; exit 1 ;;
    *) TARGET="$arg" ;;
  esac
done

if [[ -z "$TARGET" ]]; then
  usage
  exit 1
fi

tier_index=-1
for i in "${!TIERS[@]}"; do
  if [[ "${TIERS[$i]}" == "$TIER" ]]; then
    tier_index=$i
  fi
done
if [[ $tier_index -eq -1 ]]; then
  echo "Unknown tier: $TIER (expected one of: ${TIERS[*]})" >&2
  exit 1
fi

mkdir -p "$TARGET"

render() {
  # render <src> — prints src with placeholders substituted
  sed \
    -e "s/\[model-id\]/$MODEL_ID/g" \
    -e "s/\[Your Name\]/$HUMAN_NAME/g" \
    -e "s/\[Name\]/$HUMAN_NAME/g" \
    -e "s#\[persona-file\]#$PERSONA_FILE#g" \
    "$1"
}

copy_if_absent() {
  local src="$1" dest="$2"
  if [[ -f "$dest" ]]; then
    echo "skip (exists): $dest"
    return
  fi
  mkdir -p "$(dirname "$dest")"
  render "$src" > "$dest"
  echo "created: $dest"
}

append_if_absent() {
  # append_if_absent <dest> <marker> <src>
  local dest="$1" marker="$2" src="$3"
  if [[ ! -f "$dest" ]]; then
    echo "skip (not found, create it first): $dest"
    return
  fi
  if grep -qF -- "$marker" "$dest"; then
    echo "skip (already has '$marker'): $dest"
    return
  fi
  { echo ""; render "$src"; } >> "$dest"
  echo "updated: $dest"
}

ensure_ignored() {
  # ensure_ignored <target-repo> <pattern> — appends <pattern> to the target's
  # .gitignore, creating the file if it doesn't exist yet. Unlike the persona
  # file or README.md, .gitignore holds no project-specific prose, so it's
  # safe to create outright rather than skip — silently leaving
  # HUMAN.md/team-state.md untracked-but-not-ignored would defeat the point.
  local target="$1" pattern="$2"
  local dest="$target/.gitignore"
  if [[ -f "$dest" ]] && grep -qxF -- "$pattern" "$dest"; then
    return
  fi
  echo "$pattern" >> "$dest"
  echo "updated: $dest"
}

append_readme_pointer() {
  # append_readme_pointer <target-repo> <bullet-text> — adds a bullet under a
  # '## Team & Process' heading in README.md, creating that heading on first
  # use. Skips (like other README.md/persona-file merges) if README.md
  # doesn't exist yet — unlike .gitignore, README.md content is project
  # prose we shouldn't fabricate.
  local target="$1" item="- $2"
  local dest="$target/README.md" heading="## Team & Process"
  if [[ ! -f "$dest" ]]; then
    echo "skip (not found, create it first): $dest"
    return
  fi
  if grep -qxF -- "$item" "$dest"; then
    return
  fi
  if ! grep -qxF -- "$heading" "$dest"; then
    { echo ""; echo "$heading"; echo ""; } >> "$dest"
  fi
  echo "$item" >> "$dest"
  echo "updated: $dest"
}

stage_solo() {
  append_if_absent "$TARGET/$PERSONA_FILE" "## Attribution" "$TEMPLATES_DIR/agent-persona-attribution.md.tpl"
  copy_if_absent "$TEMPLATES_DIR/commit_template.md" "$TARGET/.github/commit_template.md"
  append_if_absent "$TARGET/README.md" "## Acknowledgement" "$TEMPLATES_DIR/README-acknowledgement.md.tpl"
}

stage_small_team() {
  copy_if_absent "$TEMPLATES_DIR/pull_request_template.md" "$TARGET/.github/pull_request_template.md"
  copy_if_absent "$TEMPLATES_DIR/CONTRIBUTING.md.tpl" "$TARGET/CONTRIBUTING.md"
  copy_if_absent "$TEMPLATES_DIR/HUMAN.md.tpl" "$TARGET/docs/team/HUMAN.md"
  ensure_ignored "$TARGET" "docs/team/HUMAN.md"
  append_readme_pointer "$TARGET" \
    "See [CONTRIBUTING.md](./CONTRIBUTING.md) to understand the collaborative team structure."
}

stage_growing_startup() {
  copy_if_absent "$TEMPLATES_DIR/AI-POLICY.md.tpl" "$TARGET/AI-POLICY.md"
  copy_if_absent "$TEMPLATES_DIR/team-state.md.tpl" "$TARGET/docs/team/team-state.md"
  ensure_ignored "$TARGET" "docs/team/team-state.md"
  copy_if_absent "$TEMPLATES_DIR/sessions-readme.md.tpl" "$TARGET/.claude/sessions/README.md"
  append_readme_pointer "$TARGET" \
    "See [AI-POLICY.md](./AI-POLICY.md) for the full attribution and accountability policy."
}

stage_enterprise() {
  copy_if_absent "$TEMPLATES_DIR/COMPLIANCE-CHECKLIST.md.tpl" "$TARGET/COMPLIANCE-CHECKLIST.md"
  copy_if_absent "$TEMPLATES_DIR/ai-attribution-workflow.yml.tpl" "$TARGET/.github/workflows/ai-attribution.yml"
}

echo "Scaffolding tier '$TIER' into $TARGET"
for ((i = 0; i <= tier_index; i++)); do
  case "${TIERS[$i]}" in
    solo) stage_solo ;;
    small-team) stage_small_team ;;
    growing-startup) stage_growing_startup ;;
    enterprise) stage_enterprise ;;
  esac
done

echo "Done. The script never overwrites existing files — review any"
echo "'skip' lines above if you expected something to be created."
