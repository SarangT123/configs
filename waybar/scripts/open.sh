# Check if a command was provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <command>"
    echo "Example: $0 'alacritty -e nmtui'"
    exit 1
fi

# Full command to execute
FULL_CMD="$*"

# Extract the base program name (first word of the command)
PROGRAM=$(echo "$FULL_CMD" | awk '{print $1}')
PROGRAM_NAME=$(basename "$PROGRAM")

# Check if the program is already running
if pgrep -f "$FULL_CMD" > /dev/null; then
    echo "Closing: $FULL_CMD"
    pkill -f "$FULL_CMD"
else
    echo "Opening: $FULL_CMD"
    # Run the command in the background and detach from terminal
    nohup $FULL_CMD > /dev/null 2>&1 &
    disown
fi