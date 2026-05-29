#!/bin/bash
#
# Screencaster demo: Reviewing DANDI validation results with VisiData
#
# Uses datalad/screencaster (cast2asciinema) to produce an asciinema recording.
# This script is SOURCED by cast2asciinema or record.sh, so the functions
# type, key, sleep, say, run, show are already defined.
#
# Terminal size: 120x35 (set width/height in cast2asciinema or use geometry env)
#
# Prerequisites:
#   - VisiData, asciinema, xterm, xdotool, cowsay, pstree
#   - screencaster (https://github.com/datalad/screencaster) in PATH
#   - bids_invalid_eeg_cbm.jsonl in docs/examples/validation/
#     (generate with: scripts/generate-validation-examples.sh)
#
# Usage:
#   export DISPLAY=:99  # or real display
#   Xvfb :99 -screen 0 1280x1024x24 &  # if headless
#   cd /path/to/dandi-docs-enh-validation
#   ./scripts/visidata-demo/record.sh
#
# The output .cast can be played with: asciinema play docs/examples/validation/visidata-demo.cast

# SCREENCAST_REPO is set by the caller; fall back to PWD
DEMO_REPO="${SCREENCAST_REPO:-$PWD}"
DEMO_DATA="$DEMO_REPO/docs/examples/validation"
DEMO_VDRC="$DEMO_REPO/scripts/visidata-demo/dot_visidatarc"

say "Reviewing DANDI validation results with VisiData"

run "cd $DEMO_DATA"

# --- Launch VisiData on JSONL ---
say "Opening 432 validation results from bids_invalid_eeg_cbm.jsonl"
type "vd --config $DEMO_VDRC bids_invalid_eeg_cbm.jsonl"
key Return
sleep 4

# --- Navigate to severity column ---
key space; sleep 0.5
type "go-col-regex"; sleep 1; key Return; sleep 0.3
type "severity"; key Return
sleep 2

# --- Sort by severity descending ---
key bracketright
sleep 2

# --- Frequency table on severity ---
key space; sleep 0.5
type "demo-say"; sleep 0.5; key Return; sleep 0.3
type "Frequency table on severity (Shift+F)"; key Return
sleep 4

key shift+f
sleep 3

# --- Select ERROR row and dive in ---
key space; sleep 0.5
type "demo-say"; sleep 0.5; key Return; sleep 0.3
type "22 ERRORs and 410 HINTs -- let us focus on errors"; key Return
sleep 4

key slash; sleep 0.5
type "ERROR"; sleep 1; key Return
sleep 1

key Return
sleep 3

# --- Frequency on id to see error types ---
key space; sleep 0.5
type "go-col-regex"; sleep 1; key Return; sleep 0.3
type "^id$"; key Return
sleep 2

key shift+f
sleep 3

# 20 EMPTY_FILE, 1 NIFTI_HEADER_UNREADABLE, 1 EXTENSION_MISMATCH
key space; sleep 0.5
type "demo-say"; sleep 0.5; key Return; sleep 0.3
type "20 empty files, 1 unreadable NIfTI, 1 extension mismatch"; key Return
sleep 4

# --- Back to error list ---
key q; sleep 1

# --- Navigate to message column ---
key space; sleep 0.5
type "go-col-regex"; sleep 1; key Return; sleep 0.3
type "message"; key Return
sleep 2

# --- Expand cell to read full message ---
key space; sleep 0.5
type "demo-say"; sleep 0.5; key Return; sleep 0.3
type "Expand cell with z Enter to read full message"; key Return
sleep 4

key z; sleep 0.3
key Return
sleep 4

key q; sleep 1

# --- Hide less useful columns ---
key space; sleep 0.5
type "go-col-regex"; sleep 1; key Return; sleep 0.3
type "asset_paths"; key Return
sleep 1
key minus
sleep 1

key space; sleep 0.5
type "go-col-regex"; sleep 1; key Return; sleep 0.3
type "within_asset"; key Return
sleep 1
key minus
sleep 1

key space; sleep 0.5
type "go-col-regex"; sleep 1; key Return; sleep 0.3
type "path_regex"; key Return
sleep 1
key minus
sleep 2

# --- Exit VisiData ---
key q; sleep 1
key q; sleep 1

say "Key VisiData commands for validation review:"
say "  ] / [     sort descending / ascending"
say "  Shift+F   frequency table on current column"
say "  /pattern  search for rows matching pattern"
say "  Enter     dive into selected frequency group"
say "  -         hide current column"
say "  z Enter   expand cell to read full content"
say "  q         go back or quit"
