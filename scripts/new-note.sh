#!/usr/bin/env bash
set -euo pipefail

slug="${1:-}"
title="${2:-}"

if [[ -z "$slug" || -z "$title" ]]; then
  echo "Usage: ./scripts/new-note.sh my-note-slug \"My Note Title\""
  exit 1
fi

dir="content/notes/$slug"
mkdir -p "$dir"
cat > "$dir/index.md" <<MD
---
title: "$title"
date: $(date +%F)
slug: "$slug"
description: ""
warning: "Always verify current vendor documentation before treating this note as implementation guidance."
---

Write the note here.

## Screenshots

![Screenshot](001-screenshot.png)
MD

echo "Created $dir/index.md"
