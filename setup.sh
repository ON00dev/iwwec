#!/bin/bash

# script name
SCRIPT_NAME="iwwerc.py"

# local path
DEST_DIR="/usr/local/bin"
DEST_PATH="$DEST_DIR/iwwerc"

# check sudo permition
if [ "$EUID" -ne 0 ]; then
  echo "Please, execute as root"
  exit
fi

# copy script to destine path
cp $SCRIPT_NAME $DEST_PATH

# turn executable
chmod +x $DEST_PATH

# check directory in PATH
if [[ ":$PATH:" != *":$DEST_DIR:"* ]]; then
  echo "export PATH=\$PATH:$DEST_DIR" >> ~/.bashrc
  source ~/.bashrc
fi

echo "Complete installation. You can use the 'iwwerc' command from anywhere."