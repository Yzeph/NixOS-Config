#!/usr/bin/env bash

set -euo pipefail

profiles=("power-saver" "balanced" "performance")
icons=("节能" "平衡" "性能")
labels=("省电模式" "平衡模式" "性能模式")

current=$(powerprofilesctl get)

case "$1" in
"get")
  for i in "${!profiles[@]}"; do
    if [[ "$current" == "${profiles[i]}" ]]; then
      echo "{\"text\":\"${icons[i]} \", \"tooltip\":\"当前模式：${labels[i]}\"}"
      exit
    fi
  done
  echo "{\"text\":\"?\", \"tooltip\":\"未知模式\"}"
  ;;
"toggle")
  for i in "${!profiles[@]}"; do
    if [[ "$current" == "${profiles[i]}" ]]; then
      next=$(((i + 1) % ${#profiles[@]}))
      powerprofilesctl set "${profiles[next]}"
      exit
    fi
  done
  powerprofilesctl set balanced
  ;;
esac
