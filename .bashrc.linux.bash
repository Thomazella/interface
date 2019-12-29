#! /usr/bin/env bash

# Linux ~/.bashrc

# If not running interactively, don't do anything
# [[ $- != *i* ]] && return

DOTFILE_PATH="/home/vacation/Desktop/interface"

safe_source $DOTFILE_PATH/.bashrc.bash
safe_source $DOTFILE_PATH/.aliases.bash
safe_source $DOTFILE_PATH/.aliases.linux.bash
safe_source $DOTFILE_PATH/.functions.bash
safe_source $DOTFILE_PATH/.functions.linux.bash
safe_source $DOTFILE_PATH/.private.bash
safe_source $DOTFILE_PATH/.prompt.linux.bash

#========== Keyboard
#xmodmap $HOME/.xmodmap
#touch $HOME/Desktop/dhfd

#========== Environment
export PATH="$HOME/bin/monero-gui:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:\
/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/bin:/home/linuxbrew/.linuxbrew/bin:/usr/local/go/bin"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"

# android SDK
# gradle needs this to find SDK. Opening android studio once fixes.
# export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
# export ANDROID_HOME="$HOME/Library/Android/sdk"

# generic stuff
# export PATH="$ANDROID_SDK_ROOT/build-tools/28.0.0/:$HOME/.asdf/installs/elixir/1.9.2/bin:/usr/local/opt/libxslt/bin:/usr/local/opt/openssl/bin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/local/sbin:/usr/sbin:/opt/X11/bin:$HOME/Documents/GoogleDrive/Mackup:/usr/local/opt/go/libexec/bin:$HOME/.config/yarn/global/node_modules/.bin:/usr/local/opt/util-linux/bin:/usr/local/opt/ruby/bin:$HOME/.rvm/bin:$HOME/.cargo/bin:$HOME/Library/Android/sdk/tools:$HOME/Library/Android/sdk/tools/bin:/Applications/Postgres.app/Contents/Versions/latest/bin"
# export MANPATH="/usr/local/opt/erlang/lib/erlang/man:$MANPATH"
export CDPATH=$HOME:/Media:/
export EDITOR='code -w'
# export GOPATH="$HOME/.go"
# LS_COLORS=$(cat "$HOME/Code/LS_COLORS/LS_COLORS_RAW")
# export LS_COLORS

# NVM
unset PREFIX            # NVM hates this
unset npm_config_prefix # NVM hates this
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && safe_source "$NVM_DIR/nvm.sh"                   # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && safe_source "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# elixir/erlang with asdf
export ERL_AFLAGS="-kernel shell_history enabled"
# safe_source /usr/local/opt/asdf/asdf.sh
export ERLANG_OPENSSL_PATH="/usr/local/opt/openssl"
export KERL_CONFIGURE_OPTIONS="--disable-debug --disable-silent-rules --without-javac --enable-shared-zlib --enable-dynamic-ssl-lib --enable-hipe --enable-sctp --enable-smp-support --enable-threads --enable-kernel-poll --enable-wx --enable-darwin-64bit --with-ssl=/usr/local/Cellar/openssl/1.0.2t"

if [ ! "$SSH_AUTH_SOCK" ] && [ -f $DOTFILE_PATH/.private-ssh-add.expect ]; then
  eval "$(ssh-agent)" 2>/dev/null 1>&2
  $DOTFILE_PATH/.private-ssh-add.expect 2>/dev/null 1>&2
fi

linux-start
systemctl --user start tilda.service
