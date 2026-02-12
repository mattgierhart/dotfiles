---
name: dotfiles-sync-check
description: Validates chezmoi state and checks for secrets in tracked files. Use to audit the repository for security issues and verify that the managed dotfiles are in sync.
---

# Sync Check

Validates that the dotfiles repository is clean, properly synced via chezmoi, and contains no secrets in tracked files.

## Prerequisites

- Git repository with dotfiles
- Understanding of which files should be tracked vs. local-only

## Workflow

### 1. Check for Secrets in Tracked Files

Scan all tracked files for potential secret patterns:

```bash
# Patterns that should never appear in tracked files
grep -rn \
  -e 'API_KEY' \
  -e 'SECRET_KEY' \
  -e 'PRIVATE_KEY' \
  -e 'PASSWORD=' \
  -e 'TOKEN=' \
  -e 'Bearer ' \
  -e 'sk-' \
  -e 'ghp_' \
  -e 'ghs_' \
  --include='dot_*' \
  --include='*.toml' \
  --include='*.json' \
  . || echo "No secrets found"
```

### 2. Verify .gitignore Coverage

Ensure sensitive patterns are gitignored:

```bash
# Check that these patterns are in .gitignore
grep -q '*.local' .gitignore && echo "OK: *.local ignored" || echo "WARN: *.local not ignored"
grep -q '.env' .gitignore && echo "OK: .env ignored" || echo "WARN: .env not ignored"
grep -q 'temp/' .gitignore && echo "OK: temp/ ignored" || echo "WARN: temp/ not ignored"
```

### 3. Validate Managed Files Inventory

Cross-reference what's in the repo against what README claims:

```bash
# List all dot_* files (chezmoi-managed)
echo "=== Tracked dotfiles ==="
find . -maxdepth 2 -name 'dot_*' -not -path './.git/*'

# Compare against README's "Files Managed" section
echo "=== README claims ==="
grep -A 20 'Files Managed' README.md
```

### 4. Check for Untracked Sensitive Files

Ensure no sensitive files are accidentally present but untracked:

```bash
git ls-files --others --exclude-standard | grep -E '\.(local|secret|env|key|pem)$' || echo "No sensitive untracked files"
```

### 5. Verify SoT Currency

Check if SoT files are up to date relative to dotfiles:

```bash
# Compare modification times
for f in dot_*; do
  echo "$f: $(stat -c %Y "$f" 2>/dev/null || stat -f %m "$f" 2>/dev/null)"
done

echo "---"

for f in SoT/*.md; do
  echo "$f: $(stat -c %Y "$f" 2>/dev/null || stat -f %m "$f" 2>/dev/null)"
done
```

### 6. Report

Output a summary:

```
=== Dotfiles Sync Check Report ===
Secrets scan: PASS/FAIL
Gitignore coverage: PASS/WARN
Managed files: {count} tracked
Sensitive untracked: PASS/FAIL
SoT currency: CURRENT/STALE
```

## References

- `SoT/security-model.md` — Security policies
- `.gitignore` — Ignored patterns
- `README.md` — Files Managed section
