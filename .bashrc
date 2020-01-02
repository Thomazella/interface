#! /usr/bin/env bash
# shellcheck disable=SC1090

export WARN_SOURCE_FAIL="yes"

safe_source() {
  if [ -f "$1" ]; then
    source "$1"
  else
    [ "$WARN_SOURCE_FAIL" == "yes" ] && echo "$1" not found to source
  fi
}

CONFIG_FILE=""

if [[ "$(uname -s)" =~ Darwin ]]; then
  CONFIG_FILE="/Users/vamac/Documents/GoogleDrive/Mackup/.bashrc.mac.bash"
fi

if [[ "$(uname -s)" =~ Linux ]]; then
  CONFIG_FILE="/home/vacation/Desktop/interface/.bashrc.linux.bash"
fi

if [ $CONFIG_FILE ]; then
  source "$CONFIG_FILE"
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
