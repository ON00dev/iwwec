#!/bin/bash

# Default destination directory
DEST_DIR="/usr/local/bin"

# Check for sudo permissions
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root."
  exit 1
fi

# Prompt for the full path to the script
read -p "Enter the full path to the executable or script (e.g., /path/to/iwwerc.py): " SCRIPT_PATH

# Validate that the script exists
if [ ! -f "$SCRIPT_PATH" ]; then
  echo "The file $SCRIPT_PATH does not exist."
  exit 1
fi

# Determine the script name
SCRIPT_NAME=$(basename "$SCRIPT_PATH")
DEST_PATH="$DEST_DIR/$SCRIPT_NAME"

# Copy the script to the destination path
cp "$SCRIPT_PATH" "$DEST_PATH"

# Make the script executable
chmod +x "$DEST_PATH"

# Check if the directory is in the PATH
if ! echo "$PATH" | grep -q "$DEST_DIR"; then
  # Add the directory to the PATH and save to the user's profile
  echo "export PATH=\$PATH:$DEST_DIR" >> ~/.bashrc
  source ~/.bashrc
fi

echo "Installation complete. You can use the '$SCRIPT_NAME' command from anywhere."