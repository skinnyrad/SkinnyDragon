#!/bin/bash
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
