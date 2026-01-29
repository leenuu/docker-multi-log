sudo bash -c 'cat > /usr/local/bin/docker-multilog' << 'EOF'
#!/bin/bash

reset="\033[0m"

colors=(
  "\033[38;5;33m" "\033[38;5;39m" "\033[38;5;45m" "\033[38;5;51m"
  "\033[38;5;82m" "\033[38;5;118m" "\033[38;5;154m" "\033[38;5;190m"
  "\033[38;5;220m" "\033[38;5;208m" "\033[38;5;202m" "\033[38;5;196m"
  "\033[38;5;199m" "\033[38;5;165m" "\033[38;5;135m" "\033[38;5;93m"
  "\033[38;5;177m" "\033[38;5;27m"
)

TARGET_LIST=()
if [[ "$1" == "--container" ]]; then
  shift 1
  while [[ -n "$1" ]]; do
    TARGET_LIST+=("$1")
    shift 1
  done
else
  mapfile -t TARGET_LIST < <(docker ps --format "{{.Names}}" | grep "^service-")
fi

RESOLVED=()
for t in "${TARGET_LIST[@]}"; do
  cname=$(docker ps --filter "id=$t" --format "{{.Names}}")
  if [[ -n "$cname" ]]; then
    RESOLVED+=("$cname")
  else
    RESOLVED+=("$t")
  fi
done

max_len=0
for c in "${RESOLVED[@]}"; do
  (( ${#c} > max_len )) && max_len=${#c}
done

i=0
for c in "${RESOLVED[@]}"; do
  color="${colors[$i]}"
  padded=$(printf "%-${max_len}s" "$c")

  (
    docker logs -f "$c" 2>&1 | while IFS= read -r line; do
      echo -e "${color}[${padded}]${reset} $line"
    done
  ) &

  i=$(( (i+1) % ${#colors[@]} ))
done

wait
EOF

sudo chmod +x /usr/local/bin/docker-multilog