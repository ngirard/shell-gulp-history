# fish_history_config.fish
#
# This file is a configuration script for managing shell history in Fish.
#
# It sets the following environment variables:
# - HISTCONTROL: Do not save duplicate lines or lines starting with space in history
# - HISTSIZE and HISTFILESIZE: Unlimited history
# - fish_history_autosave: Automatically save the history after every command execution
# - HISTORY_DIR: Default history directory
# - RAW_HISTORY_DIR: Directory for storing raw shell history files
# - CATEGORIZED_HISTORY_DIR: Directory for storing categorized shell history files
#
# It also creates the required directories and sets up a new history file for each shell session.
#
# This script should be sourced by ~/.config/fish/config.fish to ensure that the configuration is applied every time a new shell session is started.

# Do not save duplicate lines or lines starting with space in history
set -Ux HISTCONTROL ignoreboth

# Unlimited history
set -Ux HISTSIZE -1
set -Ux HISTFILESIZE -1

# Automatically save the history after every command execution
set -U fish_history_autosave 1

# Default values for environment variables
set -Ux HISTORY_DIR "$HOME/history"
# Raw history directory
set -Ux RAW_HISTORY_DIR "$HISTORY_DIR/raw"
# Categorized history directory
set -Ux CATEGORIZED_HISTORY_DIR "$HISTORY_DIR/categorized"

# Create history directories if they don't exist
if [ ! -d "$RAW_HISTORY_DIR" ]
  mkdir -p "$RAW_HISTORY_DIR"
end

if [ ! -d "$CATEGORIZED_HISTORY_DIR" ]
  mkdir -p "$CATEGORIZED_HISTORY_DIR"
end

# Create a new history file for current session
function __h_new
  set -Ux HISTFILE "$RAW_HISTORY_DIR/$(date -I)_fish_$$.sh"
  __h_t
end

# Add a timestamp comment to the current history file
function __h_t
  echo "# $(date --iso-8601=s)" >> "$HISTFILE"
end

# Create a new history file if default file is being used
if test "$HISTFILE" = "$HOME/.local/share/fish/fish_history"
  __h_new
end