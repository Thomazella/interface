#! /usr/bin/env zsh
# ================================================================
## To install source this file from your .zshrc file

# color vars
unset ZSH_THEME_GIT_PROMPT_BRANCH r256 color1 color2
c1=$(((RANDOM % 55) + 85))
color1=$(echo -n "%{\e[38;05;${c1}m%}")
color2=$(echo -n "%{\e[38;05;$(($c1 + 2))m%}")
color3=$(echo -n "%{\e[38;05;$(($c1 + 4))m%}")
export end=$'\e[0m'
underline=$'\e\[4m'
#echo $color1 ___ $end
#echo $color2 ___ $end

# see documentation at http://linux.die.net/man/1/zshexpn
preexec_update_git_vars() {
    case "$2" in
    git*|hub*|gh*|stg*)
        __EXECUTED_GIT_COMMAND=1
        ;;
    esac
}

precmd_update_git_vars() {
    if [ -n "$__EXECUTED_GIT_COMMAND" ] || [ ! -n "$ZSH_THEME_GIT_PROMPT_CACHE" ]; then
        update_current_git_vars
        unset __EXECUTED_GIT_COMMAND
    fi
}

chpwd_update_git_vars() {
    update_current_git_vars
}

update_current_git_vars() {
    unset __CURRENT_GIT_STATUS

    if [ "$GIT_PROMPT_EXECUTABLE" = "python" ]; then
        local py_bin=${ZSH_GIT_PROMPT_PYBIN:-"python"}
        __GIT_CMD=$(git status --porcelain --branch &> /dev/null 2>&1 | ZSH_THEME_GIT_PROMPT_HASH_PREFIX=$ZSH_THEME_GIT_PROMPT_HASH_PREFIX $py_bin "$__GIT_PROMPT_DIR/gitstatus.py")
    else
        __GIT_CMD=$(git status --porcelain --branch &> /dev/null | $__GIT_PROMPT_DIR/src/.bin/gitstatus)
    fi
    __CURRENT_GIT_STATUS=("${(@s: :)__GIT_CMD}")
    unset __GIT_CMD

    GIT_BRANCH=$__CURRENT_GIT_STATUS[1]
    GIT_AHEAD=$__CURRENT_GIT_STATUS[2]
    GIT_BEHIND=$__CURRENT_GIT_STATUS[3]
    GIT_STAGED=$__CURRENT_GIT_STATUS[4]
    GIT_CONFLICTS=$__CURRENT_GIT_STATUS[5]
    GIT_CHANGED=$__CURRENT_GIT_STATUS[6]
    GIT_UNTRACKED=$__CURRENT_GIT_STATUS[7]
    GIT_STASHED=$__CURRENT_GIT_STATUS[8]
    GIT_LOCAL_ONLY=$__CURRENT_GIT_STATUS[9]
    GIT_UPSTREAM=$__CURRENT_GIT_STATUS[10]
    GIT_MERGING=$__CURRENT_GIT_STATUS[11]
    GIT_REBASE=$__CURRENT_GIT_STATUS[12]
}

git_super_status() {
    precmd_update_git_vars

    if [ -n "$__CURRENT_GIT_STATUS" ]; then
        local STATUS="$ZSH_THEME_GIT_PROMPT_PREFIX$ZSH_THEME_GIT_PROMPT_BRANCH$GIT_BRANCH%{${reset_color}%}"
        local clean=1

        if [ -n "$GIT_REBASE" ] && [ "$GIT_REBASE" != "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_REBASE$GIT_REBASE%{${reset_color}%}"
        elif [ "$GIT_MERGING" -ne "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_MERGING%{${reset_color}%}"
        fi

        if [ "$GIT_LOCAL_ONLY" -ne "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_LOCAL%{${reset_color}%}"
        elif [ "$ZSH_GIT_PROMPT_SHOW_UPSTREAM" -gt "0" ] && [ -n "$GIT_UPSTREAM" ] && [ "$GIT_UPSTREAM" != ".." ]; then
            local parts=( "${(s:/:)GIT_UPSTREAM}" )
            if [ "$ZSH_GIT_PROMPT_SHOW_UPSTREAM" -eq "2" ] && [ "$parts[2]" = "$GIT_BRANCH" ]; then
                GIT_UPSTREAM="$parts[1]"
            fi
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UPSTREAM_FRONT$GIT_UPSTREAM$ZSH_THEME_GIT_PROMPT_UPSTREAM_END%{${reset_color}%}"
        fi

        if [ "$GIT_BEHIND" -ne "0" ] || [ "$GIT_AHEAD" -ne "0" ]; then
            STATUS="$STATUS "
        fi
        if [ "$GIT_BEHIND" -ne "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_BEHIND$GIT_BEHIND%{${reset_color}%}"
        fi
        if [ "$GIT_AHEAD" -ne "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_AHEAD$GIT_AHEAD%{${reset_color}%}"
        fi

        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_SEPARATOR"

        if [ "$GIT_STAGED" -ne "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED$GIT_STAGED%{${reset_color}%}"
            clean=0
        fi
        if [ "$GIT_CONFLICTS" -ne "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CONFLICTS$GIT_CONFLICTS%{${reset_color}%}"
            clean=0
        fi
        if [ "$GIT_CHANGED" -ne "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CHANGED$GIT_CHANGED%{${reset_color}%}"
            clean=0
        fi
        if [ "$GIT_UNTRACKED" -ne "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED$GIT_UNTRACKED%{${reset_color}%}"
            clean=0
        fi
        if [ "$GIT_STASHED" -ne "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STASHED$GIT_STASHED%{${reset_color}%}"
            clean=0
        fi
        if [ "$clean" -eq "1" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CLEAN%{${reset_color}%}"
        fi

        echo "%{${reset_color}%}$STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX%{${reset_color}%}"
    fi
}

# Always has path to this directory
# A: finds the absolute path, even if this is symlinked
# h: equivalent to dirname
export __GIT_PROMPT_DIR=${0:A:h}
export GIT_PROMPT_EXECUTABLE=${GIT_PROMPT_EXECUTABLE:-"python"}

# Load required modules
autoload -U add-zsh-hook
autoload -U colors
colors

# Allow for functions in the prompt
setopt PROMPT_SUBST

# Hooks to make the prompt
add-zsh-hook chpwd chpwd_update_git_vars
add-zsh-hook preexec preexec_update_git_vars
add-zsh-hook precmd precmd_update_git_vars

# Default values for the appearance of the prompt.
# The theme is identical to magicmonty/bash-git-prompt
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_HASH_PREFIX=":"
ZSH_THEME_GIT_PROMPT_SEPARATOR=" "
ZSH_THEME_GIT_PROMPT_BRANCH="%{ $color3%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[red]%}%{ ●%2G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}%{ ✖%2G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%}%{ ✚%2G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{↓· %3G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{↑· %3G%}"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg_bold[blue]%}%{⚑ %2G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%}%{…%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{✔ %2G%}"
ZSH_THEME_GIT_PROMPT_LOCAL="%{$color1%} local%{$end%}"
# The remote branch will be shown between these two
ZSH_THEME_GIT_PROMPT_UPSTREAM_FRONT=" {%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_END="%{${reset_color}%}}"
ZSH_THEME_GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}|MERGING%{${reset_color}%}"
ZSH_THEME_GIT_PROMPT_REBASE="%{$fg_bold[magenta]%}|REBASE%{${reset_color}%} "

# vim: set filetype=zsh:

# ================================================================

random256Color() {
  local c && c=$(echo -n $((RANDOM % 231)))
  if [ "$c" -le 17 ] || [ "$c" -ge 232 ]; then
    random256Color
  else
    echo -n "\e[38;05;${c}m"
  fi
}

glyphGitDev() {
  echo -ne \\uf7a1
}

glyphGitBranch() {
  echo -ne \\ue725
}

glyphGitCat() {
  echo -ne \\uf61a
}

getTermColumns() {
  if [ ! "$COLUMNS" ]; then
    if command -v tput 2>/dev/null 1>&2; then
      export COLUMNS="$(tput cols | tr -d \\n)"
    fi
  fi
}

#get a random color, for use outside ps1, scripts (no i on $-) don't set this var
if [[ "$-" =~ i ]]; then
  r256=$(random256Color) && export r256
fi

makePS1() {
  # use "preGit" or "postGit" as arg 1 to integrate with gitprompt script

  local purple pink spacer horizontalLine workdir
  purple=$'\e[34m'
  pink=$'\e[35m'
  #The spaces below avoids emoji collapsing on themselves. MacOS Sierra glitch.
  spacer=' '
  getTermColumns

  if [ "$(whoami)" != "root" ]; then
    decorations='~>'
    # case $((RANDOM % 7)) in
    # 0) decorations="🐺 🌋"$spacer ;;
    # 1) decorations="🌸 🌿"$spacer ;;
    # 2) decorations="🚀 💫"$spacer ;;
    # 3) decorations="🍁 🍷"$spacer ;;
    # 4) decorations="🔮 🦋"$spacer ;;
    # 5) decorations="🌄 🎆"$spacer ;;
    # 6) decorations="🍇 🥓"$spacer ;;
    # esac
  else
    decorations='##'$spacer
    # color1=$purple
    # color2=$pink
    # decorations="💠 💠"$spacer
  fi

  horizontalLine="${color3}${underline}$(printf %"${COLUMNS}"s)${end}"
  workdir="${color1}%~${end}"
  decorations="%{${color2}%}${decorations} %{${end}%}"

  printf %s ${horizontalLine}$'\n'${workdir} $'$(git_super_status)\n'${decorations}
}

PROMPT=$(makePS1) && export PROMPT