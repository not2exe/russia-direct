#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOMAINS_FILE="$SCRIPT_DIR/domains.lst"
LIST_NAME="russia-direct"
TEMP_DIR="$(mktemp -d)"

trap 'rm -rf "$TEMP_DIR"' EXIT

# --- проверки ---
if ! command -v go &>/dev/null; then
  echo "ERROR: Go не установлен. https://go.dev/dl/" >&2
  exit 1
fi

if [[ ! -f "$DOMAINS_FILE" ]]; then
  echo "ERROR: $DOMAINS_FILE не найден" >&2
  exit 1
fi

# --- клонируем инструмент сборки ---
echo "Клонируем domain-list-community..."
git clone --depth=1 https://github.com/v2fly/domain-list-community.git "$TEMP_DIR/dlc"

# --- генерируем data-файл из domains.lst ---
mkdir -p "$TEMP_DIR/data"
echo "Генерируем список $LIST_NAME..."
grep -v '^\s*#' "$DOMAINS_FILE" | grep -v '^\s*$' | while read -r domain; do
  echo "domain:$domain"
done > "$TEMP_DIR/data/$LIST_NAME"

echo "Доменов: $(wc -l < "$TEMP_DIR/data/$LIST_NAME" | tr -d ' ')"

# --- сборка ---
echo "Собираем $LIST_NAME.dat..."
cd "$TEMP_DIR/dlc"
go run ./ --datapath="$TEMP_DIR/data" --outputname="$LIST_NAME.dat" --outputdir="$SCRIPT_DIR"

echo "Готово: $SCRIPT_DIR/$LIST_NAME.dat ($(du -h "$SCRIPT_DIR/$LIST_NAME.dat" | cut -f1 | tr -d ' '))"
