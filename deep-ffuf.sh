#!/bin/bash

# Check if the required tools are installed
command -v ffuf >/dev/null 2>&1 || { echo >&2 "ffuf is not installed. Aborting."; exit 1; }

# Default values
hosts_file="filtered_httpx.txt"
wordlist="Wordlists/h0tak88r_fuzz.txt"

# Function to display script usage
usage() {
    echo "Usage: $0 -H <hosts_file> -W <wordlist>"
    echo "Options:"
    echo "  -H <hosts_file>     Path to the file containing hosts (default: $hosts_file)"
    echo "  -W <wordlist>       Path to the fuzzing wordlist (default: $wordlist)"
    exit 1
}

# Parse command-line options
while getopts "H:W:" opt; do
    case $opt in
        H) hosts_file="$OPTARG" ;;
        W) wordlist="$OPTARG" ;;
        \?) echo "Invalid option: -$OPTARG" >&2; usage ;;
    esac
done

# Check if the hosts file exists
if [ ! -f "$hosts_file" ]; then
    echo "Hosts file not found: $hosts_file"
    usage
fi

# Loop through each host in the file and execute the ffuf commands
while IFS= read -r url; do
    echo "Fuzzing $url"
    echo "Fuzzing $url" | notify --bulk

    # Fuzzing with GET requests
    ffuf -u "$url/FUZZ" -w "$wordlist" -mc 200
    ffuf -u "$url/FUZZ" -w "$wordlist" -mc 200 -X POST
    ffuf -u "$url/FUZZ/" -w "$wordlist" -mc 200
    ffuf -u "$url//FUZZ" -w "$wordlist" -mc 200
    ffuf -u "$url/FUZZ~" -w "$wordlist" -mc 200
    ffuf -u "$url/FUZZ/~" -w "$wordlist" -mc 200

    # Fuzzing with POST requests
    ffuf -u "$url/FUZZ/" -w "$wordlist" -mc 200 -X POST
    ffuf -u "$url/FUZZ~~" -w "$wordlist" -mc 200 -X POST
    ffuf -u "$url/FUZZ/" -w "$wordlist" -mc 200 -X POST
    ffuf -u "$url//FUZZ" -w "$wordlist" -mc 200 -X POST
    ffuf -u "$url/FUZZ~" -w "$wordlist" -mc 200 -X POST
    ffuf -u "$url/FUZZ/~" -w "$wordlist" -mc 200 -X POST

    echo "--------------------------------------"
done < "$hosts_file"
