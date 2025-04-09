#!/bin/bash

# Define variables
TARGET_DIR="/data/data"
LINK_NAME="/workspace/data"

# Check if the target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Target directory $TARGET_DIR does not exist."
    exit 1
fi

# Check if the link already exists
if [ -e "$LINK_NAME" ]; then
    echo "Link $LINK_NAME already exists."
else
    # Create the hard link
    ln -s "$TARGET_DIR" "$LINK_NAME"

    # Check if the link creation was successful
    if [ $? -eq 0 ]; then
        echo "Hard link created: $LINK_NAME -> $TARGET_DIR"
    else
        echo "Failed to create hard link."
    fi
fi
