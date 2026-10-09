#!/bin/bash
#
# Record the VisiData validation demo as an asciinema cast.
#
# Simplified recording driver inspired by datalad/screencaster's
# cast2asciinema, without datalad-specific dependencies.
#
# Prerequisites:
#   - xterm, xdotool, pstree (apt: xterm xdotool psmisc)
#   - cowsay (apt: cowsay) -- optional
#   - asciinema, visidata (pip: asciinema visidata)
#   - Xvfb or a real X display ($DISPLAY must be set)
#
# Usage:
#   export DISPLAY=:99  # or real display
#   Xvfb :99 -screen 0 1280x1024x24 &  # if headless
#   ./scripts/visidata-demo/record.sh
#
# Output: docs/examples/validation/visidata-demo.cast
#
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
OUTPUT="$REPO_DIR/docs/examples/validation/visidata-demo.cast"
DEMO_VDRC="$SCRIPT_DIR/dot_visidatarc"

width=120
height=36
text_width=$(($width - 8))
geometry=${width}x${height}

# Save real sleep before override
REAL_SLEEP="$(command -v sleep)"

# Build the PATH for the inner xterm bash
ASCIINEMA_BIN="$(dirname "$(command -v asciinema)")"
VD_BIN="$(dirname "$(command -v vd)")"
INNER_PATH="$ASCIINEMA_BIN:$VD_BIN:/usr/games:$PATH"

# --- Helper functions (same API as screencaster) ---

function _type() {
    xdotool type --delay 40 "$1"
}
function _key() {
    xdotool key $*
}

# These are the functions the demo script will call
function type() { _type "$@"; }
function key() { _key "$@"; }
function sleep() { xdotool sleep $1; }
function say() {
    _type "$(printf "#\n# $1" | fmt -w ${text_width} --prefix '# ')"
    _key Return
    sleep 3
}
function show() {
    _type "$(printf "\n$1\n\n" | sed -e 's/^/# /g')"
    _key Return
    sleep 3
}
function run() {
    _type "$1"
    sleep 0.5
    _key Return
    $REAL_SLEEP 2
}

# --- Start xterm with PATH pre-configured ---
echo "Starting xterm ($geometry) on DISPLAY=$DISPLAY ..."
SHELL=/bin/bash xterm -geometry $geometry \
    -e bash --rcfile <(echo "export PATH='$INNER_PATH'; export PS1='\[\e[0;36m\]validation-demo\[\e[0m\] \$ '") &
xterm_pid=$!
$REAL_SLEEP 3

WID=$(xdotool search --classname xterm 2>/dev/null | head -1)
if [ -z "$WID" ]; then
    echo "ERROR: Could not find xterm window" >&2
    exit 1
fi
echo "xterm PID=$xterm_pid, Window=$WID"

# Focus window
xdotool windowfocus --sync $WID 2>/dev/null || true
$REAL_SLEEP 1

# --- Start asciinema inside xterm ---
echo "Starting asciinema recording -> $OUTPUT"
_type "asciinema rec '$OUTPUT' -i 2 -c bash"
_key Return
$REAL_SLEEP 4

# Verify asciinema is running
PTREE="$(pstree -p -A $xterm_pid 2>/dev/null)" || true
echo "Process tree: $PTREE"
if ! echo "$PTREE" | grep -q asciinema; then
    echo "ERROR: asciinema not found in process tree" >&2
    kill $xterm_pid 2>/dev/null || true
    exit 1
fi
echo "asciinema is running"

# Set PS1 inside asciinema's bash (no absolute paths for reproducibility)
_type "export PS1='\\[\\e[0;36m\\]validation-demo\\[\\e[0m\\] \$ '"
_key Return
$REAL_SLEEP 1

# --- Source the demo script ---
echo "Running demo..."
. "$SCRIPT_DIR/demo.sh"

$REAL_SLEEP 2

# --- End recording ---
show "$(cowsay "DANDI validation + VisiData demo complete" 2>/dev/null || echo "# Demo complete.")"
$REAL_SLEEP 1

# Exit asciinema's bash (Ctrl+D)
_key ctrl+d
$REAL_SLEEP 3

# Exit outer bash
_key ctrl+d
$REAL_SLEEP 2

# Wait for xterm to close
for i in $(seq 1 10); do
    kill -0 $xterm_pid 2>/dev/null || break
    echo "Waiting for xterm to close..."
    $REAL_SLEEP 1
done
kill $xterm_pid 2>/dev/null || true

if [ -f "$OUTPUT" ]; then
    SIZE=$(wc -c < "$OUTPUT")
    LINES=$(wc -l < "$OUTPUT")
    echo ""
    echo "Recording saved: $OUTPUT ($SIZE bytes, $LINES events)"
    echo "Play with: asciinema play '$OUTPUT'"
else
    echo "ERROR: Recording file not created!" >&2
    exit 1
fi
