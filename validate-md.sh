#!/bin/bash
# Validate markdown files for common structural issues
# Usage: ./validate-md.sh [path]
# Default: validates all .md files under cases/

set -e
ROOT="${1:-cases}"
ERRORS=0

echo "Validating markdown files in $ROOT..."

for f in $(find "$ROOT" -name "*.md"); do
  # Check: tables without blank line before them
  broken_tables=$(awk '/^\|/{if(prev!="" && prev!~/^\|/ && prev!~/^$/) c++} {prev=$0} END{print c+0}' "$f")
  if [ "$broken_tables" -gt 0 ]; then
    echo "  ❌ $f: $broken_tables table(s) missing blank line before them"
    ERRORS=$((ERRORS + broken_tables))
  fi

  # Check: headers without blank line before them
  broken_headers=$(awk '/^#{1,6} /{if(NR>1 && prev!="" && prev!~/^$/) c++} {prev=$0} END{print c+0}' "$f")
  if [ "$broken_headers" -gt 0 ]; then
    echo "  ⚠️  $f: $broken_headers header(s) missing blank line before them"
  fi
done

if [ "$ERRORS" -gt 0 ]; then
  echo ""
  echo "Found $ERRORS structural error(s). Fix with:"
  echo "  awk '{if(/^\|/ && prev!=\"\" && prev!~/^\|/ && prev!~/^$/){print \"\"; print} else print; prev=\$0}' FILE > FILE.tmp && mv FILE.tmp FILE"
  exit 1
else
  echo "  ✅ All files structurally valid"
fi
