#!/usr/bin/env bash
# install local files and scripts

# Determine the script's directory
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

# Define source and destination directories
SOURCE_DIR="$SCRIPT_DIR/local"
DEST_DIR="$HOME"
BACKUP_DIR="$HOME/local.bak"

# Check if local.bak already exists
if [ -d "$BACKUP_DIR" ]; then
    echo "Backup directory $BACKUP_DIR already exists. Exiting."
    exit 1
fi

# Create the backup directory
mkdir "$BACKUP_DIR"

# Copy files from source to destination
for file in "$SOURCE_DIR"/.* "$SOURCE_DIR"/*; do
    # Skip the '.' and '..' directories
    if [ "$(basename "$file")" == "." ] || [ "$(basename "$file")" == ".." ]; then
        continue
    fi

    dest_file="$DEST_DIR/$(basename "$file")"

    # Check if the destination file already exists
    if [ -e "$dest_file" ]; then
        # Move the existing file to the backup directory
        mv "$dest_file" "$BACKUP_DIR/"
        echo "Moved existing file $dest_file to $BACKUP_DIR"
    fi

    # Copy the new file to the destination directory
    cp -r "$file" "$DEST_DIR/"
    echo "Copied $file to $DEST_DIR"
done

echo "Dotfiles have been copied to $DEST_DIR and existing files have been moved to $BACKUP_DIR."

