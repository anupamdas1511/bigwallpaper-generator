#!/bin/bash

BASH_FILE="./bwall.sh"
DEST_DIR="$HOME/Scripts"

mkdir -p "$DEST_DIR"

cp "$BASH_FILE" "$DEST_DIR/bwall"
chmod +x "$DEST_DIR/bwall"

# Append the export command to ~/.bashrc if it's not already present
if ! grep -q "export PATH=\$PATH:$DEST_DIR" ~/.bashrc; then
    echo "export PATH=\$PATH:$DEST_DIR" >> ~/.bashrc
    echo "Added $DEST_DIR to PATH in ~/.bashrc."
else
    echo "$DEST_DIR is already in PATH."
fi