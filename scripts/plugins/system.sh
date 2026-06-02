system_info() {
  echo "OS: $OSTYPE"
  echo "Shell: $SHELL"
  echo "Uptime: $(uptime -p 2>/dev/null || echo "N/A")"
  echo "Disk: $(df -h . 2>/dev/null | tail -1 | awk '{print $4}')"
}