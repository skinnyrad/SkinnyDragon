#!/bin/bash
#This is a wrapper file that is optional. Only use this script after
#going through the install process in the README.

# Path to your virtual environment
VENV_PATH="$HOME/echoblue/venv"

# Path to echoblue.py (adjust if needed)
ECHOBLUE_PATH="$HOME/echoblue/echoblue.py"

# Check if the virtual environment exists
if [ ! -d "$VENV_PATH" ]; then
    echo "Virtual environment not found at $VENV_PATH. By sure to follow the install process in the repo."
    exit 1
fi

# Activate the virtual environment
source "$VENV_PATH/bin/activate"

# Run echoblue.py with all arguments passed to this script
python3 "$ECHOBLUE_PATH" "$@" 2>&1
STATUS=$?

# Deactivate the virtual environment
deactivate

# Return the exit status of echoblue.py
exit $STATUS
