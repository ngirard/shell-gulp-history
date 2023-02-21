# Do not save duplicate lines or lines starting with space in history
HISTCONTROL=ignoreboth

# Unlimited history
# In Bash 4.3 and later, setting HISTSIZE to a value less than zero causes the history list to be unlimited
# Setting HISTFILESIZE to a value less than zero causes the history file size to be unlimited
HISTSIZE=-1
HISTFILESIZE=-1

# Append to the history file instead of overwriting it
shopt -s histappend

# Save the current shell history to disk after each command execution
# This ensures that even if the shell terminates unexpectedly,
# the history will still be saved and available for future sessions
# The `history -a` command appends the current history to the history file
# The `history -c` command clears the current shell history
# The `history -r` command reloads the history from the history file
alias __h='history -a; history -c; history -r'

# Add h to PROMPT_COMMAND to run after each command execution
export PROMPT_COMMAND="__h; $PROMPT_COMMAND"

# Default values for environment variables
HISTORY_DIR=${HISTORY_DIR:="$HOME/history"}
# Raw history directory
RAW_HISTORY_DIR=${RAW_HISTORY_DIR:="$HISTORY_DIR/raw"}
# Categorized history directory
CATEGORIZED_HISTORY_DIR=${CATEGORIZED_HISTORY_DIR:="$HISTORY_DIR/categorized"}
# Trash directory
TRASH_DIR=${TRASH_DIR:="$HOME/.local/share/Trash/files"}

# Create history directory if it doesn't exist
[[ -d "${RAW_HISTORY_DIR}" ]] || mkdir -p "${RAW_HISTORY_DIR}"

# Create a new history file for current session
__h_new(){
    HISTFILE="${RAW_HISTORY_DIR}/$(date -I)_bash_$BASHPID.sh"
    export HISTFILE
    __h_t
}

# Add a timestamp comment to the current history file
__h_t(){
    echo "# $(date --iso-8601=s)" >> "${HISTFILE}"
}

# Create a new history file if default file is being used
if [[ "$HISTFILE" == "$HOME/.bash_history" ]]; then
    __h_new
fi
