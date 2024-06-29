#!/usr/bin/env bash

# Directory to be backed up
DIR="$HOME/.config/bat"

# Backup directory base name
BACKUP_DIR_BASE="$HOME/.config/bat.bak"

# Check if the directory exists
if [ -e "$DIR" ]; then
  # Initialize the backup directory name
  BACKUP_DIR="$BACKUP_DIR_BASE"

  # Increment the backup number if the directory or file already exists
  count=1
  while [ -e "$BACKUP_DIR" ]; do
    BACKUP_DIR="${BACKUP_DIR_BASE}${count}"
    count=$((count + 1))
  done

  # Move the directory to the backup location
  mv "$DIR" "$BACKUP_DIR"

  echo "Moved $DIR to $BACKUP_DIR"
else
  echo "$DIR does not exist, nothing to backup."
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -R "$SCRIPT_DIR"/bat "$DIR"
