#!/bin/bash

curl -s "https://www.abuseipdb.com/whois/$1" \
  -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.9 Safari/537.36" \
  -b "abuseipdb_session=YOUR-SESSION" | \
  grep -E '<li>\w.*</li>' | \
  sed -E 's/<\/?li>//g' | \
  sed 's/^[ \t]*//' | \
  sed "s|$|.$1|"
