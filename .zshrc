#! /usr/bin/env zsh

# Lines configured by zsh-newuser-install
HISTFILE=$HOME/.histfile.zsh
HISTSIZE=4000
SAVEHIST=10000
setopt appendhistory autocd extendedglob
unsetopt beep nomatch
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/vamac/.zshrc'

fpath=(/usr/local/share/zsh-completions $fpath)
plugins=(… zsh-completions)
autoload -Uz compinit
compinit
# End of lines added by compinstall

#========== Bash stuff ==========#

#it's recommended by a man page to set this here for better compatibility I guess
tput init

#========== Completions, external scripts, git prompt
source "$HOME/Code/dBash/main.bash"
source "$HOME/Code/hue/main.bash"
source "/usr/local/etc/bash_completion.d/git-prompt.sh"

GIT_PS1_SHOWDIRTYSTATE="true"
GIT_PS1_SHOWSTASHSTATE="true"
GIT_PS1_SHOWUNTRACKEDFILES="true"
GIT_PS1_SHOWUPSTREAM="auto"
# You can further control behaviour by setting GIT_PS1_SHOWUPSTREAM to a space-separated list of values: verbose name legacy git svn
# GIT_PS1_SHOWUPSTREAM="verbose name git"
GIT_PS1_STATESEPARATOR=""
# If you would like to see more information about the identity of commits checked out as a detached HEAD, set GIT_PS1_DESCRIBE_STYLE to one of these values: contains branch describe tag default
GIT_PS1_DESCRIBE_STYLE="branch"
GIT_PS1_SHOWCOLORHINTS="true"

#========== Mac only
if [[ "$(uname -s)" =~ Darwin ]]; then
  export PATH="/usr/local/bin:/bin:/usr/bin:/sbin:/usr/local/sbin:/usr/sbin:/opt/X11/bin:$HOME/Documents/GoogleDrive/Mackup:/usr/local/opt/go/libexec/bin:$HOME/.config/yarn/global/node_modules/.bin:/usr/local/opt/util-linux/bin:/usr/local/opt/ruby/bin:$HOME/.rvm/bin:$HOME/.cargo/bin:$HOME/Library/Android/sdk/tools:$HOME/Library/Android/sdk/tools/bin:/Applications/Postgres.app/Contents/Versions/latest/bin"
  export MANPATH="/usr/local/opt/erlang/lib/erlang/man:$MANPATH"
  export CDPATH=$HOME:/Volumes:$HOME/Desktop
  export EDITOR='code -w'
  export GOPATH="$HOME/.go"
  LS_COLORS=$(cat "$HOME/Code/LS_COLORS/LS_COLORS_RAW") && export LS_COLORS

  #ruby flags
  export LDFLAGS="-L/usr/local/opt/ruby/lib"
  export CPPFLAGS="-I/usr/local/opt/ruby/include"

  # android SDK
  # gradle needs this to find SDK. Opening android studio once fixes.
  export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
  export ANDROID_HOME="$HOME/Library/Android/sdk"

  # fix compinit path pointing to old version (auto pruned from brew on update)
  # before nvm!
  CURRENT=$(find /usr/local/Cellar/zsh -depth 1 -type d | sed -e 's/.\///')
  export FPATH=${FPATH/5.6.2_1/$CURRENT}

  # Mono for subnautica
  export MONO_GAC_PREFIX="/usr/local"

  # NVM
  unset PREFIX            # NVM hates this
  unset npm_config_prefix # NVM hates this
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"                   # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion" # This loads nvm bash_completion

  # ZSH
  PROMPT_SUBST="true"

  # elixir
  export ERL_AFLAGS="-kernel shell_history enabled"

  if [ -f $HOME/.prompt.zsh ]; then
    source $HOME/.prompt.zsh
  else
    export PS1=$'\n%~\n%# '
  fi
fi

#========== Environment
export TIMEFORMAT=$'\n-time elapsed-\nreal\t%3Rs\nuser\t%3Us\nsystem\t%3Ss'
export BLOCKSIZE=1000000 #1 Megabyte
export LESS="--RAW-CONTROL-CHARS --HILITE-UNREAD --window=-5 --quiet --LINE-NUMBERS --buffers=32768 --quit-if-one-screen --prompt=?eEND:%pb\\%. ?f%F:Stdin.\\: page %d of %D, line %lb of %L"
export PAGER="less"
export BASH_ENV="$HOME/.bashrc.bash"
GPG_TTY=$(tty) && export GPG_TTY

#========== Late sourcing
source $HOME/.aliases.bash
source $HOME/.functions.bash
# dosource "$VSCODE_OVERRIDES"
# eval "$(direnv hook zsh)"

#========== Zsh overrides
alias srit="source $HOME/.zshrc && clear"
setopt interactivecomments
bindkey '\e[3~' delete-char
