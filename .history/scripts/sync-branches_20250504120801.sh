set -e

BRANCH_PATTERN="feature/*"
DRY_RUN=false
VERBOSE=false
FORCE=false

usage() {
  echo "Usage: $0 [-p pattern] [--dry-run] [--verbose] [--force]"
  echo ""
  echo "Options:"
  echo "  -p, --pattern   Branch name pattern to match (default: feature/*)"
  echo "      --dry-run   Show branches that would be updated, but don't do anything"
  echo "      --verbose   Print extra debugging information"
  echo "      --force     Force checkout even if working directory is dirty"
  echo "  -h, --help      Show this help message"
  exit 1
}

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    -p|--pattern) BRANCH_PATTERN="$2"; shift ;;
    --dry-run) DRY_RUN=true ;;
    --verbose) VERBOSE=true ;;
    --force) FORCE=true ;;
    -h|--help) usage ;;
    *) echo "Unknown option: $1"; usage ;;
  esac
  shift
done

if [ "$VERBOSE" = true ]; then
  set -x
fi

if ! git rev-parse --git-dir > /dev/null 2>&1; then
  echo "❌ Not a git repository. Exiting."
  exit 1
fi

echo "📦 Fetching remote branches..."
git fetch --all --prune

echo "🔍 Matching pattern: $BRANCH_PATTERN"
MATCHED_BRANCHES=$(git branch -r | grep "origin/$(echo "$BRANCH_PATTERN" | sed 's/\*/.*/')")

if [ -z "$MATCHED_BRANCHES" ]; then
  echo "⚠️ No branches matched pattern '$BRANCH_PATTERN'"
  exit 0
fi

for remote_branch in $MATCHED_BRANCHES; do
  local_branch="${remote_branch#origin/}"
  echo "🔄 Updating local branch '$local_branch'..."

  if [ "$DRY_RUN" = true ]; then
    echo "💤 Dry-run: would update '$local_branch'"
    continue
  fi

  if [ "$FORCE" = false ] && ! git diff --quiet; then
    echo "⚠️ Skipping '$local_branch' due to local changes (use --force to override)"
    continue
  fi

  git checkout -B "$local_branch" "$remote_branch"
done

echo "✅ Done."