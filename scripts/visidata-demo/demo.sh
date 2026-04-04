#!/bin/bash
#
# Screencaster demo: Reviewing DANDI validation results with VisiData
#
# Uses datalad/screencaster to produce an asciinema recording.
#
# Terminal size: 120x35
#
# Prerequisites:
#   - VisiData installed
#   - screencaster (https://github.com/datalad/screencaster) in PATH
#   - bids_invalid_eeg_cbm.jsonl in docs/examples/validation/
#     (generate with: scripts/generate-validation-examples.sh)
#
# Usage:
#   cd /path/to/dandi-docs-enh-validation
#   cast2asciinema scripts/visidata-demo/demo.sh docs/examples/validation/
#
# The output cast file can be renamed to visidata-demo.cast and embedded
# in the docs via the asciinema-player.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
DATA="$REPO_DIR/docs/examples/validation/bids_invalid_eeg_cbm.jsonl"

say "Reviewing DANDI validation results with VisiData"
say "Dataset: invalid BIDS EEG dataset (invalid_eeg_cbm)"

run "cd $REPO_DIR/docs/examples/validation"
run "export TERM=xterm-256color"

# --- Launch VisiData on JSONL ---
say "Opening validation JSONL in VisiData..."
type "vd --config $SCRIPT_DIR/dot_visidatarc bids_invalid_eeg_cbm.jsonl"
key Return
sleep 3

# --- Orient: show the columns ---
key space; sleep 0.5
type "demo-say"; sleep 0.5; key Return; sleep 0.3
type "432 validation results with id, severity, path, message, origin..."; key Return
sleep 3

# --- Navigate to severity column ---
key space; sleep 0.5
type "go-col-regex"; sleep 0.5; key Return; sleep 0.3
type "severity"; key Return
sleep 2

# --- Sort by severity descending ---
key space; sleep 0.5
type "demo-say"; sleep 0.5; key Return; sleep 0.3
type "Sort by severity (] for descending)"; key Return
sleep 2

key ']'
sleep 2

# --- Frequency table on severity ---
key space; sleep 0.5
type "demo-say"; sleep 0.5; key Return; sleep 0.3
type "Frequency table on severity (Shift+F) -- see the breakdown"; key Return
sleep 2

key shift+f
sleep 3

# Show the frequency breakdown: ERROR vs HINT
key space; sleep 0.5
type "demo-say"; sleep 0.5; key Return; sleep 0.3
type "22 ERRORs and 410 HINTs -- focus on the errors"; key Return
sleep 3

# --- Select ERROR row and dive in ---
key slash; sleep 0.5
type "ERROR"; key Return
sleep 1

key Return
sleep 3
# Now viewing only ERROR rows

# --- Navigate to id column ---
key space; sleep 0.5
type "go-col-regex"; sleep 0.5; key Return; sleep 0.3
type "^id$"; key Return
sleep 2

# --- Frequency on id to see error types ---
key space; sleep 0.5
type "demo-say"; sleep 0.5; key Return; sleep 0.3
type "Frequency on issue ID -- what types of errors?"; key Return
sleep 2

key shift+f
sleep 3

# Show: BIDS.EMPTY_FILE (20), BIDS.NIFTI_HEADER_UNREADABLE (1), BIDS.EXTENSION_MISMATCH (1)
key space; sleep 0.5
type "demo-say"; sleep 0.5; key Return; sleep 0.3
type "20 empty files, 1 unreadable NIfTI, 1 extension mismatch"; key Return
sleep 3

# --- Back to error list ---
key q; sleep 1

# --- Navigate to message column to read details ---
key space; sleep 0.5
type "go-col-regex"; sleep 0.5; key Return; sleep 0.3
type "message"; key Return
sleep 2

# --- Expand a cell to read the full message ---
key space; sleep 0.5
type "demo-say"; sleep 0.5; key Return; sleep 0.3
type "Expand cell (z Enter) to read full message"; key Return
sleep 2

key 'z'; sleep 0.3
key Return
sleep 3

# --- Back out ---
key q; sleep 1

# --- Hide less useful columns ---
key space; sleep 0.5
type "demo-say"; sleep 0.5; key Return; sleep 0.3
type "Hide null columns with - key for a cleaner view"; key Return
sleep 2

# Go to asset_paths (usually null)
key space; sleep 0.5
type "go-col-regex"; sleep 0.5; key Return; sleep 0.3
type "asset_paths"; key Return
sleep 1
key '-'
sleep 1

# Hide within_asset_paths
key space; sleep 0.5
type "go-col-regex"; sleep 0.5; key Return; sleep 0.3
type "within_asset"; key Return
sleep 1
key '-'
sleep 1

# Hide path_regex
key space; sleep 0.5
type "go-col-regex"; sleep 0.5; key Return; sleep 0.3
type "path_regex"; key Return
sleep 1
key '-'
sleep 1

sleep 2

# --- Exit ---
key q; sleep 1
key q; sleep 1

say ""
say "Key VisiData commands for validation review:"
say "  ] / [     -- sort descending / ascending"
say "  Shift+F   -- frequency table on current column"
say "  /pattern  -- search for rows matching pattern"
say "  Enter     -- dive into selected frequency group"
say "  -         -- hide current column"
say "  z Enter   -- expand cell to read full content"
say "  q         -- go back / quit"
