# **Git Branch Syncer**

**Git Branch Syncer is a Python-based tool designed to streamline Git branch management by synchronizing branches matching a specified pattern with a "mother" branch (e.g., main or master). This is particularly useful for keeping feature branches up-to-date with the latest changes from a primary branch.**

## Features

* ***Branch Synchronization***: Syncs branches matching a pattern with a designated mother branch.
* ***Glob Pattern Matching***: Supports Unix-style patterns (e.g., feature/*) to target multiple branches.
* ***Dry-Run Mode***: Simulates the sync process without making changes.
* ***Verbose Output***: Provides detailed logs for debugging and transparency.
* ***Force Sync Option***: Allows syncing even when there are uncommitted local changes.

## Requirements

* Python 3.6 or higher
* Git (command-line tool)
* A valid Git repository (local with access to a remote)

## Installation

### ***Option 1: Install from PyPI***
Install the package directly from the Python Package Index (PyPI):
```bash
pip install git-branch-syncer
```
### ***Option 2: Clone the Repository***
1. ***Clone the Repository***:

```bash
git clone https://github.com/yourusername/git-branch-syncer.git
cd git-branch-syncer
```

2. ***Set Up a Virtual Environment (recommended)***:
```bash
python -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
```

3. ***Install Dependencies***:
* The project has no external Python dependencies beyond the standard library, but you can install it as a package for convenience:

```bash
pip install .
```
* If you have a requirements.txt (e.g., for development tools like pytest), install it:

```bash
pip install -r requirements.txt
```

# Usage
Run the tool using the Python module syntax. The script syncs branches matching the specified pattern with the mother branch.

### ***Basic Command***
Sync all feature/* branches with main:
```bash
python -m git_branch_syncer.syncer --pattern "feature/*" --mother main
```

***Command-Line Arguments***

| Argument | Description | Default|
|----------|-----|----------|
| -p, --pattern | Glob pattern to match branches (e.g., feature/*)  | feature/*|
| --mother | Mother branch to sync from | main|
| --dry-run | Simulate sync without making changes | False|
| --verbose | Enable detailed output for debugging | False|
| --force | Force sync despite uncommitted changes | False|

# Examples
1. ***Dry-Run Mode*** (simulate syncing):
```bash
python -m git_branch_syncer.syncer --pattern "feature/*" --mother main --dry-run
```

2. ***Verbose Output*** (detailed logs):
```bash
python -m git_branch_syncer.syncer --pattern "feature/*" --mother main --verbose
```

3. ***Force Sync*** (ignore local changes):
```bash
python -m git_branch_syncer.syncer --pattern "feature/*" --mother main --force
```

4. ***Sync All Branches*** (using * pattern):
```bash
python -m git_branch_syncer.syncer --pattern "*" --mother main
```

# Troubleshooting
* ***No branches matched pattern***: Ensure **git fetch --all --prune** retrieves remote branches and verify branches exist with **git branch -r**. Check if the pattern (e.g., feature/*) matches branch names after stripping the remote prefix (e.g., origin/).
* ***Fetch failures***: Verify remote configuration (**git remote -v**) and network connectivity. Ensure you have access to the repository.
* ***Not a Git repository***: Run the script from within a valid Git repository.

# Development
Prerequisites:
* Python 3.6+
* Git
* (Optional) pytest for running tests

# Contributing

1. Fork the repository.
2. Create a feature branch:

```bash
git checkout -b feature/your-feature
```
3. Commit changes:
```bash
git commit -am 'Add your feature'
```
4. Push to the branch:
```bash
git push origin feature/your-feature
```
5. Create a pull request on GitHub.

## Acknowledgements

   * Built to simplify Git branch management for development teams.
   * Leverages Python’s subprocess for Git commands and fnmatch for pattern matching.
   * Inspired by common workflows in collaborative software development.

# License

This project is licensed under the MIT License. See the  file for details.
