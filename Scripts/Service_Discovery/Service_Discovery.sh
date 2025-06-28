#!/bin/bash

# Usage: ./scan.sh <IP|CIDR|domain>
if [ -z "$1" ]; then
  echo "Usage: $0 <IP|CIDR|domain>"
  exit 1
fi

TARGET="$1"
PORTS="80,8000,8080,8880,2052,2082,2086,2095,443,2053,2083,2078,2096,8443,10443"
OUT_BASE="${TARGET//\//_}"
TMP_HOSTS_FILE=$(mktemp)

echo "[*] Expanding $TARGET to hosts..."
echo "$TARGET" | mapcidr -silent | tee "$TMP_HOSTS_FILE" > "${OUT_BASE}_hosts.txt"

echo "[*] Running Naabu on expanded hosts..."
naabu -silent -p "$PORTS" -list "$TMP_HOSTS_FILE" | tee "${OUT_BASE}_open_ports.txt" | \
httpx -silent \
  -follow-host-redirects \
  -title \
  -status-code \
  -cdn \
  -tech-detect \
  -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36" \
  -H "Referer: https://llegit.com" \
  -threads 50 | tee "${OUT_BASE}_httpx.txt"

# Clean up
rm "$TMP_HOSTS_FILE"

echo "[+] Results saved:"
echo "    - Hosts:         ${OUT_BASE}_hosts.txt"
echo "    - Open ports:    ${OUT_BASE}_open_ports.txt"
echo "    - HTTP details:  ${OUT_BASE}_httpx.txt"
