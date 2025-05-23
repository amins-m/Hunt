#!/usr/bin/env python3
import sys, os, tempfile, subprocess
from urllib.parse import urlsplit

def run_command_in_zsh(command):
    try:
        result = subprocess.run(['zsh', '-c', command], capture_output=True, text=True)

        if result.returncode != 0:
            print("Error occurred:", result.stderr)
            return False

        return result.stdout.strip()
    except subprocess.SubprocessError as exc:
        print("Status : FAIL", exc.returncode, exc.output)

class colors:
    GRAY = '\033[90m'

def get_hostname(url):
    if url.startswith('http'):
        # Split the URL into components
        url_components = urlsplit(url)
        # Get the hostname from the netloc component
        return url_components.netloc
    else:
        return url

def good_url(url):
    extensions = ['.json', '.js', '.fnt', '.ogg', '.css', '.jpg', '.jpeg', '.png', '.svg', '.img', '.gif', '.exe', '.mp4',
    '.flv', '.pdf', '.doc', '.ogv', '.webm', '.wmv', '.webp', '.mov', '.mp3', '.m4a', '.m4p', '.ppt', '.pptx', '.scss', '.tif',
    '.tiff', '.ttf', '.otf', '.woff', '.woff2', '.bmp', '.ico', '.eot', '.htc', '.swf', '.rtf', '.image', '.rf', '.txt', 'xml',
    'zip']
    try:
        parsed_url = urlsplit(url)
        return not any(parsed_url.path.endswith(ext) for ext in extensions)
    except Exception as e:
        print("Error:", str(e))
        return None

def finalize(file_path, domain):
    unique_lines = set()
    with open(file_path, 'r') as file:
        for line in file:
            if good_url(line.strip()):
                unique_lines.add(line.strip())

    unique_lines = {value for value in unique_lines if value}

    if len(unique_lines) == 0:
        return False

    with open(f"{domain}.passive", 'w') as file:
        for element in unique_lines:
            file.write(str(element) + '\n')
    
    return unique_lines

def is_file(filepath):
    # Check if the path exists and is a file
    return os.path.isfile(filepath)

def generate_temp_file():
    with tempfile.NamedTemporaryFile(mode='w', delete=False) as temp_file:
        return temp_file.name

def run_nice_passive(domain):
    
    temp_file = generate_temp_file()
    print(f"{colors.GRAY}Gathering URLs passively for: {domain}{colors.GRAY}")

    commands = [
        f"echo https://{domain}/ | tee {temp_file}",
        f"echo \"{domain}\" | waybackurls | sort -u  | tee -a {temp_file}",
        f"echo \"{domain}\" | gau --threads 1 --subs | sort -u | tee -a {temp_file}"
    ]

    # Running commands
    for command in commands:
        print(f"{colors.GRAY}Executing command: {command}{colors.GRAY}")
        run_command_in_zsh(command)

    print(f"{colors.GRAY}Merging result for: {domain}{colors.GRAY}")
    res = finalize(temp_file, domain)

    res_num = len(res) if res else 0
    print(f"{colors.GRAY}Done for {domain}, results: {res_num}{colors.GRAY}")

def get_input():
    # Check if input is provided through stdin
    if not sys.stdin.isatty():
        return sys.stdin.read().strip().split("\n")
    # Check if input is provided through command-line arguments
    elif len(sys.argv) > 1:
        return [sys.argv[1]]
    else:
        return None

if __name__ == "__main__":
    input_data = get_input()

    if input_data is None:
        print(f"Usage: echo domain.tld | nice_passive")
        print(f"Usage: cat domains.txt | nice_passive")
        sys.exit()

    for entry in input_data:
        entry = entry.strip()
        if not entry:
            continue
        domain = get_hostname(entry)
        run_nice_passive(domain)
