#!/bin/bash
cd "$(dirname "$0")/.."
source .venv/bin/activate
python -m git_branch_syncer.syncer --pattern "feature/*" --mother main