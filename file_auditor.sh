#!/bin/bash
# Advanced Bash Scripting, Automation

# A utility to recursively audit large datasets for corruption
# Usage: ./file_auditor.sh /path/to/data

DIRECTORY=$1

if [ -z "$DIRECTORY" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

echo "Starting audit on $DIRECTORY at $(date)"

find "$DIRECTORY" -type f -name "*.csv" | while read -r file; do
    # Check if file is empty
    if [ ! -s "$file" ]; then
        echo "[WARNING] Empty file detected: $file"
        continue
    fi
    
    # Check for non-UTF8 characters (common in ML datasets)
    if iconv -f utf-8 -t utf-8 -c "$file" > /dev/null; then
        echo "[OK] $file is valid."
    else
        echo "[ERROR] Encoding issues in $file"
    fi
done
