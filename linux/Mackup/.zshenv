#! /usr/bin/env zsh

if [ "$HOME/.ps1.zsh" ] && [[ "$(uname -s)" =~ Darwin ]]; then
    source "$HOME/.ps1.zsh"
fi
