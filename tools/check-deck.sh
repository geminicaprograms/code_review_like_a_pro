#!/usr/bin/env bash
# Deck checks for the Marp decks in this repo.
#
# Usage: tools/check-deck.sh <deck.md> [--slides N] [--no-notes-slide N] [--no-build]
# Checks: slide marker count, <sub> balance, a notes block on every slide
# (except --no-notes-slide), no ___ / ??? / TODO lines, prints the notes word
# count, and builds the deck with marp-cli (pinned) unless --no-build.
set -uo pipefail

MARP_VERSION=4.5.1
deck=${1:-}
[ -n "$deck" ] && [ -f "$deck" ] || { echo "usage: $0 <deck.md> [--slides N] [--no-notes-slide N] [--no-build]" >&2; exit 2; }
shift
slides=12
no_notes=""
build=1
while [ $# -gt 0 ]; do
  case $1 in
    --slides) slides=$2; shift 2 ;;
    --no-notes-slide) no_notes=$2; shift 2 ;;
    --no-build) build=0; shift ;;
    *) echo "unknown option: $1" >&2; exit 2 ;;
  esac
done

fail=0
say() { echo "check-deck: $*"; }
bad() { echo "check-deck: FAIL $*" >&2; fail=1; }

# 1. slide markers
markers=$(grep -c '^<!-- Slide [0-9]*' "$deck")
if [ "$markers" -eq "$slides" ]; then say "slides=$markers"; else bad "slides=$markers (expected $slides)"; fi

# 2. <sub> balance
open=$(grep -o '<sub>' "$deck" | wc -l | tr -d ' ')
close=$(grep -o '</sub>' "$deck" | wc -l | tr -d ' ')
if [ "$open" -eq "$close" ]; then say "subs=$open/$close"; else bad "subs=$open/$close (unbalanced)"; fi

# 3. notes per slide: a comment block that is not a marker and not a directive
notes_ok=0
missing=""
for n in $(seq 1 "$slides"); do
  if [ "$n" = "$no_notes" ]; then continue; fi
  block=$(awk -v n="$n" '
    $0 ~ "^<!-- Slide " n ":" { on=1; next }
    on && $0 ~ "^<!-- Slide [0-9]+:" { exit }
    on { print }' "$deck")
  if printf '%s\n' "$block" | grep -q '^<!--$'; then
    notes_ok=$((notes_ok+1))
  else
    missing="$missing $n"
  fi
done
expected_notes=$slides
[ -n "$no_notes" ] && expected_notes=$((slides-1))
if [ "$notes_ok" -eq "$expected_notes" ]; then say "notes=$notes_ok/$expected_notes"; else bad "notes=$notes_ok/$expected_notes (missing on slide(s):$missing)"; fi

# 4. forbidden lines
if grep -nE '^___$|\?\?\?|TODO' "$deck"; then bad "forbidden line(s) above (___ / ??? / TODO)"; fi

# 5. notes word count (lines between a bare "<!--" and "-->")
words=$(awk '/^<!--$/{on=1; next} /^-->$/{on=0; next} on' "$deck" | wc -w | tr -d ' ')
say "words=$words"

# 6. build
if [ "$build" -eq 1 ]; then
  out=${TMPDIR:-/tmp}/deck-check-$$.html
  if npx -y "@marp-team/marp-cli@$MARP_VERSION" "$deck" -o "$out" --allow-local-files >/dev/null 2>&1 && [ -s "$out" ]; then
    say "build=ok ($out)"
  else
    bad "build failed (marp-cli $MARP_VERSION)"
  fi
fi

[ "$fail" -eq 0 ] && { say "PASS $deck"; exit 0; }
echo "check-deck: FAILED $deck" >&2
exit 1
