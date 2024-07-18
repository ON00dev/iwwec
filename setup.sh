#!/bin/bash

# Script name
SCRIPT_NAME="iwwerc"

# Destination path
DEST_DIR="/usr/local/bin"
DEST_PATH="$DEST_DIR/$SCRIPT_NAME"

# Check for sudo permissions
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root."
  exit 1
fi

# Copy the script to the destination path
cp "$SCRIPT_NAME" "$DEST_PATH"

# Make the script executable
chmod +x "$DEST_PATH"

# Check if the directory is in the PATH
if ! echo "$PATH" | grep -q "$DEST_DIR"; then
  # Add the directory to the PATH and save to user's profile
  echo "export PATH=\$PATH:$DEST_DIR" >> ~/.bashrc
  source ~/.bashrc
fi

echo "Installation complete. You can use the '$SCRIPT_NAME' command from anywhere."