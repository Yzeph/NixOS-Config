#!/usr/bin/env bash

set -euo pipefail

WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/.config/wallpaper}"
ROFI_THEME="${ROFI_THEME:-$HOME/.config/rofi/themes/wallpaper_2_line.rasi}"

if ! pgrep -x "swww-daemon" >/dev/null 2>&1; then
    swww-daemon >/dev/null 2>&1 &
    while ! swww query >/dev/null 2>&1; do
        sleep 0.1
    done
fi

mapfile -t WALLS < <(find -L "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | sort)
[ ${#WALLS[@]} -eq 0 ] && { rofi -e "在 $WALLPAPER_DIR 中未找到壁纸"; exit 1; }

MENU_ITEMS=""
for wp in "${WALLS[@]}"; do
    name=$(basename "$wp")
    MENU_ITEMS+="$name\0icon\x1f$wp\n"
done

ROFI_CMD=(rofi -dmenu -p "选择壁纸" -show-icons)

if [ -n "$ROFI_THEME" ]; then
    ROFI_CMD+=(-theme "$ROFI_THEME")
fi

CHOICE=$(printf '%b' "$MENU_ITEMS" | "${ROFI_CMD[@]}")

[ -z "$CHOICE" ] && exit 0

SELECTED=""
for wp in "${WALLS[@]}"; do
    if [ "$(basename "$wp")" = "$CHOICE" ]; then
        SELECTED="$wp"
        break
    fi
done

if [ -z "$SELECTED" ]; then
    echo "错误: 未找到对应的壁纸文件" >&2
    exit 1
fi

types=(fade grow outer center wipe wave simple left top right bottom any)
random_transition=${types[$RANDOM % ${#types[@]}]}

swww img "$SELECTED" \
    --transition-type "$random_transition" \
    --transition-duration 2 \
    --transition-fps 144 \
    --transition-bezier 0.22,1,0.36,1

if command -v notify-send >/dev/null 2>&1; then
    notify-send "壁纸已切换" "$(basename "$SELECTED") - 效果: $random_transition" -i "$SELECTED"
fi
