#!/usr/bin/env bash

# Check current regulatory domain
current_reg=$(sudo iw reg get 2>/dev/null | awk '/country / {print $2; exit}' | cut -d':' -f1)

echo "Current regulatory domain: ${current_reg:-unknown}"

echo -n "Enter 2-letter country code to set regulatory domain (or press Enter to skip): "
read -r new_dom

# If user pressed Enter, do nothing
if [ -z "$new_dom" ]; then
    echo "No input provided. Leaving domain as '${current_reg:-unknown}'."
    exit 0
fi

# Basic validation: must be exactly 2 alphabetic characters
if ! [[ "$new_dom" =~ ^[A-Za-z]{2}$ ]]; then
    echo "Invalid format (must be exactly 2 letters). Leaving domain as '${current_reg:-unknown}'."
    exit 1
fi

# Normalize to uppercase
new_dom=${new_dom^^}

echo "Attempting to set regulatory domain to: $new_dom"
if sudo iw reg set "$new_dom"; then
    sleep 1
    verify_reg=$(sudo iw reg get 2>/dev/null | awk '/country / {print $2; exit}' | cut -d':' -f1)
    if [ "$verify_reg" = "$new_dom" ]; then
        echo "Regulatory domain successfully set to $verify_reg."
    else
        echo "iw reg set returned success, but domain is still '$verify_reg'. It may not be supported. Leaving as-is."
    fi
else
    echo "Failed to run 'iw reg set'. Leaving domain unchanged."
    exit 1
fi

echo
echo

# Asks the user if they want to make a password for a potential SSH session.
read -p "Do you want to create a password for this session (for use with SSH)? (yes/no): " answer
case "$answer" in
  [Yy][Ee][Ss]|[Yy])
    echo "*** Create a Password for This Session ***"
    echo "At Current Password prompt, JUST PRESS ENTER."
    echo
    passwd
    ;;
  [Nn][Oo]|[Nn])
    exit 1
    ;;
  *)
    exit 1
    ;;
esac
