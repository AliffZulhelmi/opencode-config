#!/bin/bash
# macOS notification helper for opencode-plugin-notification.
# Receives the notification message as remaining args (same convention as notify.ps1).
msg="$*"
if [ -z "$msg" ]; then
  msg="OpenCode task completed"
fi
escaped=$(printf '%s' "$msg" | sed 's/\\/\\\\/g; s/"/\\"/g')
osascript -e "display notification \"$escaped\" with title \"OpenCode\""
