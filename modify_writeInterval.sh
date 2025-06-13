#!/usr/bin/bash

# Check if a new writeInterval value is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <new_writeInterval_value>"
    exit 1
fi

# Store the new writeInterval value
NEW_VALUE=$1

# Path to the controlDict file
CONTROL_DICT="./controlDict"

# Check if controlDict file exists
if [ ! -f "$CONTROL_DICT" ]; then
    echo "Error: $CONTROL_DICT not found"
    exit 1
fi

# Read the current writeInterval value
CURRENT_VALUE=$(grep -E "^writeInterval\s+[0-9]+" "$CONTROL_DICT" | awk '{print $2}' | tr -d ';')

if [ -z "$CURRENT_VALUE" ]; then
    echo "Error: Could not find writeInterval in $CONTROL_DICT"
    exit 1
fi

echo "Current writeInterval: $CURRENT_VALUE"
echo "Changing writeInterval to: $NEW_VALUE"

# Modify the writeInterval value in the file
sed -i "s/^writeInterval\s\+[0-9]\+;/writeInterval$NEW_VALUE;/" "$CONTROL_DICT"

if [ $? -eq 0 ]; then
    echo "Successfully updated writeInterval to $NEW_VALUE"
else
    echo "Error: Failed to update writeInterval"
    exit 1
fi
