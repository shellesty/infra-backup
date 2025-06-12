#!/bin/bash

# === Config ===
LOG_DIR="./logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/infra_backup-$(date +%F).log"

log_msg() {
    echo "$(date): $1" | tee -a "$LOG_FILE"
}

backup_dir() {
    local src="$1"
    local dest="$2"
    
    if [ ! -d "$src" ]; then
        log_msg "ERROR: Source directory '$src' does not exist."
        exit 1
    fi

    mkdir -p "$dest"
    local filename="backup-$(date +%F_%H-%M-%S).tar.gz"
    tar -czf "$dest/$filename" -C "$(dirname "$src")" "$(basename "$src")"
    
    if [ $? -eq 0 ]; then
        log_msg "SUCCESS: Backup created at $dest/$filename"
    else
        log_msg "ERROR: Backup failed."
    fi
}

restore_backup() {
    local archive="$1"
    local target="$2"

    if [ ! -f "$archive" ]; then
        log_msg "ERROR: Backup file '$archive' not found."
        exit 1
    fi

    mkdir -p "$target"
    tar -xzf "$archive" -C "$target"

    if [ $? -eq 0 ]; then
        log_msg "SUCCESS: Backup restored to $target"
    else
        log_msg "ERROR: Restore failed."
    fi
}

# === Main Logic ===
if [ "$1" == "--backup" ]; then
    backup_dir "$2" "$3"
elif [ "$1" == "--restore" ]; then
    restore_backup "$2" "$3"
else
    echo "Usage:"
    echo "  $0 --backup /source /destination"
    echo "  $0 --restore /path/to/archive.tar.gz /target"
    exit 1
fi
