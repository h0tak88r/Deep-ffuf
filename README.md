# Deep-ffuf Fuzzing Script

This Bash script is designed to automate the fuzzing process using the ffuf tool on a list of hosts. It supports customization of the hosts file and the fuzzing wordlist.

## Prerequisites

- [ffuf](https://github.com/ffuf/ffuf) - Install it with `go get -u github.com/ffuf/ffuf`.

## Usage

```bash
bash deep-fuzz.sh -H <hosts_file> -W <wordlist>
```

### Options:

- `-H <hosts_file>`: Path to the file containing hosts (default: filtered_httpx.txt)
- `-W <wordlist>`: Path to the fuzzing wordlist (default: Wordlists/h0tak88r_fuzz.txt)

## Example

```bash
bash deep-fuzz.sh -H hosts.txt -W Wordlists/custom_wordlist.txt
```

## Notes

- Ensure that you have ffuf installed before running the script.
- Make sure to provide the correct paths to your hosts file and wordlist.
