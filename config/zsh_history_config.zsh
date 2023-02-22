# zsh_history_config.zsh
#
# This file is a configuration script for managing shell history in Zsh.
#
# It sets the following environment variables and aliases:
# - HISTCONTROL: Do not save duplicate lines or lines starting with space in history
# - HISTSIZE and SAVEHIST: Unlimited history
# - __h: alias to save the current shell history to disk after each command execution
# - precmd: Add the __h alias to run after each command execution
# - HISTORY_DIR: Default history directory
# - RAW_HISTORY_DIR: Directory for storing raw shell history files
# - CATEGORIZED_HISTORY_DIR: Directory for storing categorized shell history files
#
# It also creates the required directories and sets up a new history file for each shell session.
#
# This script should be sourced by ~/.zshrc to ensure that the configuration is applied every time a new shell session is started.

# Do not save duplicate lines or lines starting with space in history
HISTCONTROL=(ignoreboth)

# Unlimited history
# In Zsh, setting HISTSIZE to a value less than zero causes the history list to be unlimited.
# Setting SAVEHIST to a value less than zero causes the history file size to be unlimited.
HISTSIZE=-1
SAVEHIST=-1

# Append to the history file instead of overwriting it
setopt appendhistory

# Save the current shell history to disk after each command execution
# This ensures that even if the shell terminates unexpectedly,
# the history will still be saved and available for future sessions
# The `fc -W` command writes the current history to the history file
# The `fc -R` command reloads the history from the history file
alias __h='fc -W; fc -R'

# Function to run before each command execution to save the current shell history to disk
if [[ -z "$precmd_functions" ]]; then
  precmd_functions=(__h)
else
  precmd_functions=($precmd_functions __h)
fi

# Default values for environment variables
HISTORY_DIR=${HISTORY_DIR:="$HOME/history"}
# Raw history directory
RAW_HISTORY_DIR=${RAW_HISTORY_DIR:="$HISTORY_DIR/raw"}
# Categorized history directory
CATEGORIZED_HISTORY_DIR=${CATEGORIZED_HISTORY_DIR:="$HISTORY_DIR/categorized"}

# Create history directories if they doesn't exist
if [ ! -d "$RAW_HISTORY_DIR" ]; then
  mkdir -p "$RAW_HISTORY_DIR"
fi

if [ ! -d "$CATEGORIZED_HISTORY_DIR" ]; then
  mkdir -p "$CATEGORIZED_HISTORY_DIR"
fi

# Create a new history file for current session
__h_new(){
    HISTFILE="${RAW_HISTORY_DIR}/$(date -I)_zsh_$$.sh"
    export HISTFILE
    __h_t
}

# Add a timestamp comment to the current history file
__h_t(){
    echo "# $(date --iso-8601=s)" >> "${HISTFILE}"
}

# Create a new history file if default file is being used
if [[ "$HISTFILE" == "$HOME/.zsh_history" ]]; then
    __h_new
fi
