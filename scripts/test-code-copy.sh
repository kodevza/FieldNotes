#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
test_note="$repo_root/content/notes/code-copy-test.md"
output_dir="$(mktemp -d)"

cleanup() {
  rm -f "$test_note"
  rm -rf "$output_dir"
}
trap cleanup EXIT

cat > "$test_note" <<'MARKDOWN'
---
title: "Code Copy Test"
date: 2026-06-23
slug: "code-copy-test"
---

```pwsh
Get-Process
```

```sh
echo shell
```

```python
print("python")
```

```json
{"copy": false}
```
MARKDOWN

hugo --destination "$output_dir" --quiet

page="$output_dir/notes/code-copy-test/index.html"

grep -q 'data-code-copy' "$page"
test "$(grep -c 'data-code-copy' "$page")" -eq 3
test "$(grep -c 'data-copy-button' "$page")" -eq 3
grep -q '/js/code-copy.min.' "$page"
grep -q 'PowerShell' "$page"
grep -q 'Shell' "$page"
grep -q 'Python' "$page"
test "$(grep -c 'language-json' "$page")" -eq 1
