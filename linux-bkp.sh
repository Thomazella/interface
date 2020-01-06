#! /usr/bin/env bash

FILES=(
  "$HOME/.config/kdeglobals"
  # "$HOME/.config/kglobalshortcutsrc"
  # "$HOME/.config/khotkeysrc"
  # "$HOME/.config/kwinrc"
  # "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"
  # "$HOME/.local/share/kxmlgui5/katepart/katepart5ui.rc"
  # "$HOME/.local/share/kxmlgui5/konsole/konsoleui.rc"
  # "$HOME/.local/share/kxmlgui5/konsole/sessionui.rc"
  # "$HOME/.local/share/kxmlgui5/kwrite/kwriteui.rc"
  # "$HOME/.local/share/konsole"
)
RSYNC="rsync -rtvvuc"
BACKUP="$HOME/Desktop/interface/linux/home"

path-components() {
  local path="$*"
  local dir
  local file
  local backup
  dir=$(dirname "$path" | sed s/[/]home[/]vacation[/]//)
  file="$(basename "$path")"
  backup="$BACKUP/$dir/$file"
  echo "$dir" "$file" "$backup"
}

sanitize-path() {
  local dir
  local file
  local backup
  dir="$1"
  file="$2"
  backup="$3"

  if [ ! -d "$dir" ]; then
    echo mkdir -p "$BACKUP/$dir"
  fi
}

make-link() {
  local dir
  local file
  local backup
  dir="$1"
  file="$2"
  backup="$3"

  if stat "$HOME/$dir/$file" | grep -q "symbolic link"; then
    return
  fi

  if [ -d "$HOME/$dir/$file" ]; then
    echo "$RSYNC $HOME/$dir/$file/ $BACKUP/$dir/$file"
  else
    echo "$RSYNC $HOME/$dir/$file $BACKUP/$dir/$file"
  fi
  echo trash "$HOME/$dir/$file"
  echo ln -si "$BACKUP/$dir/$file" "$HOME/$dir/$file"
}

for file in "${FILES[@]}"; do
  # shellcheck disable=SC2046
  sanitize-path $(path-components "$file")
  # shellcheck disable=SC2046
  make-link $(path-components "$file")
done
