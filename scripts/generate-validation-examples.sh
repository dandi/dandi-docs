#!/bin/bash
#
# Generate validation output examples for DANDI documentation.
#
# Requirements:
#   - dandi-cli with validation improvements (PR #1822+)
#   - bids-examples repo (git clone https://github.com/bids-standard/bids-examples)
#   - bids-error-examples repo (git clone https://github.com/bids-standard/bids-error-examples)
#
# Optional:
#   - nwb2bids (pip install nwb2bids)
#
# Usage:
#   ./scripts/generate-validation-examples.sh
#
# Environment variables (with defaults):
#   DANDI_VENV      - path to dandi venv directory (auto-detected from sibling repo)
#   BIDS_EXAMPLES   - path to bids-examples repo (cloned to temp if unset)
#   BIDS_ERROR_EXAMPLES - path to bids-error-examples repo (cloned to temp if unset)
#
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
OUT_DIR="$REPO_DIR/docs/examples/validation"

# Auto-detect dandi venv from sibling repo and prepend to PATH
DANDI_VENV="${DANDI_VENV:-}"
if [ -z "$DANDI_VENV" ]; then
    for candidate in \
        "$(dirname "$REPO_DIR")/dandi-cli-enh-validators/.venv" \
        "$(dirname "$REPO_DIR")/dandi-cli/.venv" \
    ; do
        if [ -x "$candidate/bin/dandi" ]; then
            DANDI_VENV="$candidate"
            break
        fi
    done
fi

if [ -n "$DANDI_VENV" ] && [ -d "$DANDI_VENV/bin" ]; then
    export PATH="$DANDI_VENV/bin:$PATH"
    echo "Using venv: $DANDI_VENV"
fi

if ! command -v dandi >/dev/null 2>&1; then
    echo "ERROR: dandi CLI not found. Set DANDI_VENV= or install dandi-cli." >&2
    exit 1
fi

echo "dandi location: $(command -v dandi)"
echo "dandi version: $(dandi --version 2>&1 | grep -v WARNING || true)"

# Temp directory for downloads and clones
TMPDIR_BASE="$(mktemp -d)"
trap 'rm -rf "$TMPDIR_BASE"' EXIT

# Clone bids-examples if not provided
BIDS_EXAMPLES="${BIDS_EXAMPLES:-}"
if [ -z "$BIDS_EXAMPLES" ]; then
    echo "Cloning bids-examples (sparse)..."
    BIDS_EXAMPLES="$TMPDIR_BASE/bids-examples"
    git clone --depth 1 --filter=blob:none --sparse \
        https://github.com/bids-standard/bids-examples.git "$BIDS_EXAMPLES" 2>&1
    (cd "$BIDS_EXAMPLES" && git sparse-checkout set eeg_cbm)
fi

BIDS_ERROR_EXAMPLES="${BIDS_ERROR_EXAMPLES:-}"
if [ -z "$BIDS_ERROR_EXAMPLES" ]; then
    echo "Cloning bids-error-examples (sparse)..."
    BIDS_ERROR_EXAMPLES="$TMPDIR_BASE/bids-error-examples"
    git clone --depth 1 --filter=blob:none --sparse \
        https://github.com/bids-standard/bids-error-examples.git "$BIDS_ERROR_EXAMPLES" 2>&1
    (cd "$BIDS_ERROR_EXAMPLES" && git sparse-checkout set invalid_eeg_cbm)
fi

mkdir -p "$OUT_DIR"

# Helper: strip ANSI codes, log lines, and sanitize absolute paths
sanitize() {
    sed 's/\x1b\[[0-9;]*m//g' \
    | grep -v '^\[  *WARNING\]' \
    | grep -v '^\[  *INFO\]' \
    | grep -v '^$' \
    | sed "s|$TMPDIR_BASE/[^/]*/||g" \
    | sed "s|$BIDS_EXAMPLES/||g" \
    | sed "s|$BIDS_ERROR_EXAMPLES/||g" \
    | sed 's|/home/[^/]*/[^ ]*/||g'
}

# Helper: run dandi validate, capturing only stdout (validation output),
# filtering out stderr log messages
run_validate() {
    dandi validate "$@" 2>/dev/null || true
}

echo ""
echo "=== Downloading Dandiset 000027 ==="
DS027_DIR="$TMPDIR_BASE/ds000027"
mkdir -p "$DS027_DIR/sub-RAT123"
# Download directly via API to avoid version parsing issues with dev installs
curl -sL "https://api.dandiarchive.org/api/assets/838bab7b-9ab4-4d66-97b3-898a367c9c7e/download/" \
    -o "$DS027_DIR/sub-RAT123/sub-RAT123.nwb"
echo "Downloaded: $(ls -la "$DS027_DIR/sub-RAT123/sub-RAT123.nwb")"

echo ""
echo "=== NWB validation of 000027 ==="

# NWB text output
run_validate "$DS027_DIR" | sanitize > "$OUT_DIR/nwb_000027.txt"
echo "  -> nwb_000027.txt ($(wc -l < "$OUT_DIR/nwb_000027.txt") lines)"

# NWB JSONL output
run_validate -f json_lines "$DS027_DIR" | sanitize > "$OUT_DIR/nwb_000027.jsonl"
echo "  -> nwb_000027.jsonl ($(wc -l < "$OUT_DIR/nwb_000027.jsonl") lines)"

# NWB grouped by severity
run_validate -g severity "$DS027_DIR" | sanitize > "$OUT_DIR/nwb_000027_grouped.txt"
echo "  -> nwb_000027_grouped.txt ($(wc -l < "$OUT_DIR/nwb_000027_grouped.txt") lines)"

# NWB summary
run_validate --summary "$DS027_DIR" | sanitize > "$OUT_DIR/nwb_000027_summary.txt"
echo "  -> nwb_000027_summary.txt ($(wc -l < "$OUT_DIR/nwb_000027_summary.txt") lines)"

echo ""
echo "=== Valid BIDS: eeg_cbm ==="

# Add .bidsignore with dandiset.yaml if not present (DANDI requirement)
if [ ! -f "$BIDS_EXAMPLES/eeg_cbm/.bidsignore" ]; then
    echo "dandiset.yaml" > "$BIDS_EXAMPLES/eeg_cbm/.bidsignore"
fi

run_validate "$BIDS_EXAMPLES/eeg_cbm" | sanitize > "$OUT_DIR/bids_eeg_cbm.txt"
echo "  -> bids_eeg_cbm.txt ($(wc -l < "$OUT_DIR/bids_eeg_cbm.txt") lines)"

# Valid BIDS grouped by severity with max-per-group for conciseness
run_validate -g severity --max-per-group 3 "$BIDS_EXAMPLES/eeg_cbm" | sanitize > "$OUT_DIR/bids_eeg_cbm_grouped.txt"
echo "  -> bids_eeg_cbm_grouped.txt ($(wc -l < "$OUT_DIR/bids_eeg_cbm_grouped.txt") lines)"

# Valid BIDS summary
run_validate --summary "$BIDS_EXAMPLES/eeg_cbm" | sanitize > "$OUT_DIR/bids_eeg_cbm_summary.txt"
echo "  -> bids_eeg_cbm_summary.txt ($(wc -l < "$OUT_DIR/bids_eeg_cbm_summary.txt") lines)"

echo ""
echo "=== Invalid BIDS: invalid_eeg_cbm ==="

# Add .bidsignore with dandiset.yaml if not present
if [ ! -f "$BIDS_ERROR_EXAMPLES/invalid_eeg_cbm/.bidsignore" ]; then
    echo "dandiset.yaml" > "$BIDS_ERROR_EXAMPLES/invalid_eeg_cbm/.bidsignore"
fi

INVALID_DIR="$BIDS_ERROR_EXAMPLES/invalid_eeg_cbm"

# Text output (default) with max-per-group for readability
run_validate --max-per-group 5 "$INVALID_DIR" | sanitize > "$OUT_DIR/bids_invalid_eeg_cbm.txt"
echo "  -> bids_invalid_eeg_cbm.txt ($(wc -l < "$OUT_DIR/bids_invalid_eeg_cbm.txt") lines)"

# JSONL output (full, no truncation - for VisiData and --load demos)
run_validate -f json_lines "$INVALID_DIR" | sanitize > "$OUT_DIR/bids_invalid_eeg_cbm.jsonl"
echo "  -> bids_invalid_eeg_cbm.jsonl ($(wc -l < "$OUT_DIR/bids_invalid_eeg_cbm.jsonl") lines)"

# Summary
run_validate --summary "$INVALID_DIR" | sanitize > "$OUT_DIR/bids_invalid_eeg_cbm_summary.txt"
echo "  -> bids_invalid_eeg_cbm_summary.txt ($(wc -l < "$OUT_DIR/bids_invalid_eeg_cbm_summary.txt") lines)"

# Grouped by severity
run_validate -g severity --max-per-group 3 "$INVALID_DIR" | sanitize > "$OUT_DIR/bids_invalid_grouped_severity.txt"
echo "  -> bids_invalid_grouped_severity.txt ($(wc -l < "$OUT_DIR/bids_invalid_grouped_severity.txt") lines)"

# Grouped by severity then id
run_validate -g severity -g id --max-per-group 2 "$INVALID_DIR" | sanitize > "$OUT_DIR/bids_invalid_grouped_severity_id.txt"
echo "  -> bids_invalid_grouped_severity_id.txt ($(wc -l < "$OUT_DIR/bids_invalid_grouped_severity_id.txt") lines)"

# YAML format (truncated for readability)
run_validate -f yaml --max-per-group 3 "$INVALID_DIR" | sanitize > "$OUT_DIR/bids_invalid_eeg_cbm.yaml"
echo "  -> bids_invalid_eeg_cbm.yaml ($(wc -l < "$OUT_DIR/bids_invalid_eeg_cbm.yaml") lines)"

# Pretty JSON (truncated for readability)
run_validate -f json_pp --max-per-group 3 "$INVALID_DIR" | sanitize > "$OUT_DIR/bids_invalid_eeg_cbm.json"
echo "  -> bids_invalid_eeg_cbm.json ($(wc -l < "$OUT_DIR/bids_invalid_eeg_cbm.json") lines)"

# Filtered to errors only
run_validate --min-severity ERROR "$INVALID_DIR" | sanitize > "$OUT_DIR/bids_invalid_errors_only.txt"
echo "  -> bids_invalid_errors_only.txt ($(wc -l < "$OUT_DIR/bids_invalid_errors_only.txt") lines)"

echo ""
echo "=== nwb2bids conversion of 000027 ==="
if command -v nwb2bids >/dev/null 2>&1; then
    BIDS_027="$TMPDIR_BASE/000027-bids"
    nwb2bids convert "$DS027_DIR" --bids-directory "$BIDS_027" 2>&1 | tail -5 || true
    if [ -d "$BIDS_027" ]; then
        echo "dandiset.yaml" > "$BIDS_027/.bidsignore"
        run_validate "$BIDS_027" | sanitize > "$OUT_DIR/bids_000027_converted.txt"
        echo "  -> bids_000027_converted.txt"
    else
        echo "  SKIP: nwb2bids produced no output directory"
    fi
else
    echo "  SKIP: nwb2bids not installed (pip install nwb2bids)"
fi

echo ""
echo "=== Done ==="
echo "Generated files in: $OUT_DIR"
ls -la "$OUT_DIR/"
