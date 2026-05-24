#!/usr/bin/env bash
# 截图与录屏脚本（适用于 Niri + Wayland）

set -e

SCREENSHOT_DIR="$HOME/screenshot"
mkdir -p "$SCREENSHOT_DIR"
FILENAME="Screenshot from $(date +%Y-%m-%d\ %H-%M-%S).png"
FILEPATH="$SCREENSHOT_DIR/$FILENAME"

case "$1" in
  --screen)
    grim "$FILEPATH"
    ;;
  --window)
    grim -g "$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' 2>/dev/null || slurp)" "$FILEPATH"
    ;;
  *)
    grim -g "$(slurp)" "$FILEPATH"
    ;;
esac

notify-send "Screenshot saved" "$FILENAME"
