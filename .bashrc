#! /usr/bin/env bash
SHELL_CONFIG=""
if [[ "$(uname -s)" =~ Darwin ]]; then
  SHELL_CONFIG="/Users/vamac/.bashrc.bash"
fi

if [[ "$(uname -s)" =~ Linux ]]; then
  SHELL_CONFIG="/home/vacation/Desktop/interface/bash-on-linux/.bashrc"
fi

if [ $SHELL_CONFIG ]; then
  source $SHELL_CONFIG
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
