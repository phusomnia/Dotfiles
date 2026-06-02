#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

for k4l in "$SCRIPT_DIR"/scripts/kernel/*.sh; do
  source "$k4l"
done

source "$SCRIPT_DIR/scripts/plugins/debian.sh"

debian_pipeline
