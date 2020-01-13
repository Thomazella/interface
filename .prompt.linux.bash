#! /usr/bin/env bash
random256Color() {
  local c && c=$(echo -n $((RANDOM % 231)))
  # bad constrast colors, get another one
  if [ "$c" -le 17 ] || [ "$c" -ge 232 ]; then
    random256Color
  else
    echo -n "\\e[38;05;${c}m"
  fi
}

getTermColumns() {
  if [ ! "$COLUMNS" ]; then
    if command -v tput 2>/dev/null 1>&2; then
      COLUMNS="$(tput cols | tr -d \\n)"
      export COLUMNS
    fi
  fi
}

#get a random color, for use outside ps1, scripts (no i on $-) don't set this var
if [[ "$-" =~ i ]]; then
  r256=$(random256Color)
  export r256
fi

# other formatting
end="\\[\\e[0m\\]"
underline="\\[\\e[4m\\]"
# bold="\\[\\e[1m\\]"
mainColor="\\[$r256\\]"
auxiliarColor="\\[$(random256Color)\\]"

makePS1() {
  # use "preGit" or "postGit" as arg 1 to integrate with gitprompt script

  # colors
  local spacer horizontalLine workdir # historia S green yellow light_black black
  spacer=' '
  getTermColumns

  if [ "$(whoami)" != "root" ]; then
    decorations=$auxiliarColor"~>"$spacer$end
  else
    decorations=$auxiliarColor"#>"$spacer$end
  fi

  horizontalLine="$auxiliarColor$underline$(printf %"${COLUMNS}"s)$end\\n"
  workdir="$mainColor\\w $end"

  case "$1" in
  "preGit") printf %s "${horizontalLine}${workdir}" ;;
  "postGit") printf %s "\\n${decorations}" ;;
  *) printf %s "${horizontalLine}${workdir}\\n${decorations}" ;;
  esac
}

PS1=$(makePS1)
export PS1
# shellcheck disable=2089 disable=2090
PROMPT_COMMAND="__git_ps1 '$(makePS1 preGit)' '$(makePS1 postGit)' '$mainColor$underline%s$end' && chpwd"
export PROMPT_COMMAND
