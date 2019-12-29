#!/usr/bin/env bash
# shellcheck disable=SC2034 disable=SC1090

#========== Completions, external scripts, git prompt
if [ -d /usr/local/etc/bash_completion.d ]; then
  for file in /usr/local/etc/bash_completion.d/*; do
    safe_source "$file"
  done
fi

safe_source "$HOME/Code/dBash/main.bash"
safe_source "$HOME/Code/hue/main.bash"
safe_source "$HOME/.yarn-completion.bash"

#========== Environment
# export PATH="/usr/local/bin:/bin:/usr/bin:/sbin:/usr/local/sbin:/usr/sbin:/opt/X11/bin:$HOME/bin:/usr/local/opt/go/libexec/bin:$HOME/.config/yarn/global/node_modules/.bin:/usr/local/opt/util-linux/bin:/usr/local/opt/ruby/bin:$HOME/.rvm/bin:$HOME/.cargo/bin:$HOME/Library/Android/sdk/tools:$HOME/Library/Android/sdk/tools/bin:/Applications/Postgres.app/Contents/Versions/latest/bin"
export CDPATH=$HOME:/Volumes:$HOME/Desktop
# export EDITOR='code -w'
export GOPATH="$HOME/.go"
LS_COLORS=$(cat "$HOME/Code/LS_COLORS/LS_COLORS_RAW")
export LS_COLORS

# android SDK
# gradle needs this to find SDK. Opening android studio once fixes.
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export ANDROID_HOME="$HOME/Library/Android/sdk"

# NVM
unset PREFIX            # NVM hates this
unset npm_config_prefix # NVM hates this
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# elixir
export ERL_AFLAGS="-kernel shell_history enabled"
safe_source /usr/local/opt/asdf/asdf.sh

#========== Late sourcing
if [ -f ~/.prompt.bash ]; then
  safe_source ~/.prompt.bash
else
  export PS1="\\n\\w\\n\$ "
fi
safe_source "/Users/vamac/Documents/GoogleDrive/Mackup/.aliases.bash"
safe_source "/Users/vamac/Documents/GoogleDrive/Mackup/.private.bash"
safe_source "/Users/vamac/Documents/GoogleDrive/Mackup/.functions.bash"
