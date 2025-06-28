#!/bin/bash

dns_brute_full () {
    echo "cleaning..."
    rm -f "$1.wordlist" "$1.dns_brute" "$1.dns_gen"

    echo "making static wordlist."
    awk -v domain="$1" '{print $0 "." domain}' 
"/Users/aminm/Downloads/Hunt/WordLists/dns-brute/subdomains-assetnote-merged.txt" 
>> "$1.wordlist"

    echo "making 4 chars wordlist."
    awk -v domain="$1" '{print $0 "." domain}' 
"/Users/aminm/Downloads/Hunt/WordLists/dns-brute/4.txt" >> "$1.wordlist"

    echo "shuffledns static brute-force..."
    shuffledns -list "$1.wordlist" -d "$1" -r ~/.resolver -m "$(which 
massdns)" -mode resolve -silent | tee "$1.dns_brute" >/dev/null 2>&1

    echo "[+] finished, total $(wc -l < "$1.dns_brute") resolved."

    echo "running subfinder..."
    subfinder -d "$1" -all | dnsx -silent | anew "$1.dns_brute" >/dev/null 
2>&1

    echo "[+] finished, total $(wc -l < "$1.dns_brute") resolved."

    echo "running DNSGen..."
    dnsgen "$1.dns_brute" -w 
"/Users/aminm/Downloads/Hunt/WordLists/dns-brute/words.txt" > "$1.dns_gen" 
2>/dev/null

    echo "finished with $(wc -l < "$1.dns_gen") words..."

    echo "shuffledns dynamic brute-force on dnsgen results..."
    shuffledns -list "$1.dns_gen" -d "$1" -r ~/.resolvers -m "$(which 
massdns)" -mode resolve -silent | anew "$1.dns_brute" >/dev/null 2>&1

    echo "[+] finished, total $(wc -l < "$1.dns_brute") resolved..."
}

dns_brute_full "$1"

