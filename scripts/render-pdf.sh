#!/usr/bin/env bash
# Prints the built CV landing page to <public-dir>/cv.pdf with headless Chrome.
# Serves the directory over HTTP first, because the built HTML uses root-relative
# asset URLs that do not resolve from file://.
#
# Usage: scripts/render-pdf.sh [public-dir] [port]
set -euo pipefail

out_dir="${1:-public}"
port="${2:-8765}"

chrome=""
for c in google-chrome google-chrome-stable chromium chromium-browser; do
  if command -v "$c" >/dev/null 2>&1; then chrome="$c"; break; fi
done
[ -n "$chrome" ] || { echo "render-pdf: no Chrome/Chromium binary found" >&2; exit 1; }
[ -f "$out_dir/index.html" ] || { echo "render-pdf: $out_dir/index.html missing; run hugo first" >&2; exit 1; }

out_dir="$(cd "$out_dir" && pwd)"
profile="$(mktemp -d)"   # isolated profile so an already-running Chrome is not reused

python3 -m http.server --bind 127.0.0.1 --directory "$out_dir" "$port" >/dev/null 2>&1 &
server=$!
trap 'kill "$server" 2>/dev/null || true; rm -rf "$profile"' EXIT
curl --retry 20 --retry-connrefused --retry-delay 1 -sf -o /dev/null "http://127.0.0.1:$port/"

"$chrome" --headless=new --no-sandbox --disable-gpu --hide-scrollbars \
  --user-data-dir="$profile" --no-pdf-header-footer --virtual-time-budget=5000 \
  --print-to-pdf="$out_dir/cv.pdf" "http://127.0.0.1:$port/" 2>/dev/null

[ -s "$out_dir/cv.pdf" ] || { echo "render-pdf: Chrome produced no PDF" >&2; exit 1; }
echo "render-pdf: wrote $out_dir/cv.pdf ($(wc -c <"$out_dir/cv.pdf") bytes)"
