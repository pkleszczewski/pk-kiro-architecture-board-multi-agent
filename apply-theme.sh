#!/bin/bash
# Apply brand template to MkDocs and Marp configuration
# Reads BRAND_TEMPLATE from .env file

set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$SCRIPT_DIR"

# Load .env (only if BRAND_TEMPLATE not already set)
if [ -z "$BRAND_TEMPLATE" ] && [ -f "$ROOT_DIR/.env" ]; then
  export $(grep -v '^#' "$ROOT_DIR/.env" | grep BRAND_TEMPLATE | xargs)
fi

BRAND="${BRAND_TEMPLATE:-default}"
echo "Applying brand template: $BRAND"

# Determine CSS source files
case "$BRAND" in
  brand-1)
    MKDOCS_CSS="templates/marp/brands/brand-1-mkdocs.css"
    MARP_CSS="templates/marp/brands/brand-1.css"
    ;;
  brand-2)
    MKDOCS_CSS="templates/marp/brands/brand-2-mkdocs.css"
    MARP_CSS="templates/marp/brands/brand-2.css"
    ;;
  *)
    MKDOCS_CSS=""
    MARP_CSS="templates/marp/default.css"
    ;;
esac

# Apply MkDocs stylesheet
if [ -n "$MKDOCS_CSS" ] && [ -f "$ROOT_DIR/$MKDOCS_CSS" ]; then
  cp "$ROOT_DIR/$MKDOCS_CSS" "$ROOT_DIR/cases/stylesheets/custom.css"
  echo "  MkDocs: applied $MKDOCS_CSS → cases/stylesheets/custom.css"
else
  # Default dark theme
  cat > "$ROOT_DIR/cases/stylesheets/custom.css" << 'EOF'
:root {
  --md-primary-fg-color: #1a1a2e;
  --md-primary-bg-color: #e0e0e0;
  --md-accent-fg-color: #64ffda;
}

[data-md-color-scheme="slate"] {
  --md-default-bg-color: #1a1a2e;
  --md-default-fg-color: #e0e0e0;
  --md-code-bg-color: #0f0f1a;
  --md-code-fg-color: #64ffda;
  --md-typeset-a-color: #64ffda;
}

.md-header {
  background-color: #0f0f1a;
}

.md-tabs {
  background-color: #0f0f1a;
}
EOF
  echo "  MkDocs: applied default theme"
fi

# Write active Marp theme path for documentalist reference
echo "$MARP_CSS" > "$ROOT_DIR/.active-marp-theme"
echo "  Marp:   $MARP_CSS (saved to .active-marp-theme)"

echo "Done. Restart mkdocs serve to see changes."
