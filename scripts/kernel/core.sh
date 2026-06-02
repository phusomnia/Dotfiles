#!/bin/bash

# ==========================================
# COLORS
# ==========================================
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
PURPLE="\033[0;35m"

BOLD="\033[1m"
DIM="\033[2m"
NC="\033[0m"

# ==========================================
# LOGGER
# ==========================================
logger_success() {
  echo -e "${GREEN}${BOLD}[SUCCESS]${NC} $1"
}

logger_error() {
  echo -e "${RED}${BOLD}[ERROR]${NC} $1"
}

logger_warning() {
  echo -e "${YELLOW}${BOLD}[WARNING]${NC} $1"
}

logger_info() {
  echo -e "${CYAN}${BOLD}[INFO]${NC} $1"
}

logger_debug() {
  echo -e "${DIM}[DEBUG]${NC} $1"
}

# ==========================================
# SPINNER
# ==========================================
SPINNER_CHARS=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
SPINNER_DELAY=0.1
SPINNER_START_TIME=0
SPINNER_PID=""

spinner_start() {
  local message="${1:-Loading...}"

  SPINNER_START_TIME=$SECONDS

  (
    while true; do
      local elapsed=$((SECONDS - SPINNER_START_TIME))

      for char in "${SPINNER_CHARS[@]}"; do
        printf "\r${CYAN}${BOLD}%s${NC} %s ${DIM}(%ss)${NC}" \
          "$char" \
          "$message" \
          "$elapsed"

        sleep "$SPINNER_DELAY"
      done
    done
  ) &

  SPINNER_PID=$!
}

spinner_stop() {
  if [[ -n "$SPINNER_PID" ]]; then
    kill "$SPINNER_PID" 2>/dev/null
    wait "$SPINNER_PID" 2>/dev/null
    SPINNER_PID=""
  fi

  printf "\r\033[K"
}

# ==========================================
# PLATFORM
# ==========================================
platform_os() {
  echo "$OSTYPE"
}

platform_is_windows() {
  [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]
}

platform_is_linux() {
  [[ "$OSTYPE" == linux* ]]
}

platform_is_macos() {
  [[ "$OSTYPE" == darwin* ]]
}

# ==========================================
# TERMINAL
# ==========================================
terminal_clear_line() {
  printf "\r\033[K"
}

terminal_hide_cursor() {
  tput civis
}

terminal_show_cursor() {
  tput cnorm
}