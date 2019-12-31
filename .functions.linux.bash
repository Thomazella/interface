#! /usr/bin/env bash

#========== Override macos

__git_ps1() {
  true
}

#- - - - - - - - - - -

goo() {
  google "$@"
}

#========== Generic

chpwd() {
  case $PWD in
  $HOME/Desktop/community)
    source "$HOME/Desktop/interface/chpwd-to-source/community/on-enter-dir"
    ;;
  $HOME/Desktop/confy)
    source "$HOME/Desktop/interface/chpwd-to-source/confy/on-enter-dir"
    ;;
  $HOME/Desktop/elixir-backend-example)
    source "$HOME/Desktop/interface/chpwd-to-source/elixir-backend-example/on-enter-dir"
    ;;
  $HOME/Desktop/interface)
    source "$HOME/Desktop/interface/chpwd-to-source/interface/on-enter-dir"
    ;;
  $HOME/Desktop/oreid)
    source "$HOME/Desktop/interface/chpwd-to-source/oreid/on-enter-dir"
    ;;
  $HOME/Desktop/procure)
    source ".env"
    ;;
  $HOME/Desktop/sense)
    source "$HOME/Desktop/interface/chpwd-to-source/sense/on-enter-dir"
    ;;
  $HOME/Desktop/taffy)
    source "$HOME/Desktop/interface/chpwd-to-source/taffy/on-enter-dir"
    ;;
  $HOME/Desktop/another-elixir)
    source "$HOME/Desktop/interface/chpwd-to-source/another-elixir/on-enter-dir"
    ;;
  $HOME/Desktop/helpers-console)
    source "$HOME/Desktop/interface/chpwd-to-source/helpers-console/on-enter-dir"
    ;;
  *) ;;
  esac

  case $OLDPWD in
  $HOME/Desktop/community)
    source "$HOME/Desktop/interface/chpwd-to-source/community/on-leave-dir"
    ;;
  $HOME/Desktop/confy)
    source "$HOME/Desktop/interface/chpwd-to-source/confy/on-leave-dir"
    ;;
  $HOME/Desktop/elixir-backend-example)
    source "$HOME/Desktop/interface/chpwd-to-source/elixir-backend-example/on-leave-dir"
    ;;
  $HOME/Desktop/interface)
    source "$HOME/Desktop/interface/chpwd-to-source/interface/on-leave-dir"
    ;;
  $HOME/Desktop/oreid)
    source "$HOME/Desktop/interface/chpwd-to-source/oreid/on-leave-dir"
    ;;
  $HOME/Desktop/procure)
    source "$HOME/Desktop/interface/chpwd-to-source/procure/on-leave-dir"
    ;;
  $HOME/Desktop/sense)
    source "$HOME/Desktop/interface/chpwd-to-source/sense/on-leave-dir"
    ;;
  $HOME/Desktop/taffy)
    source "$HOME/Desktop/interface/chpwd-to-source/taffy/on-leave-dir"
    ;;
  $HOME/Desktop/another-elixir)
    source "$HOME/Desktop/interface/chpwd-to-source/another-elixir/on-leave-dir"
    ;;
  $HOME/Desktop/helpers-console)
    source "$HOME/Desktop/interface/chpwd-to-source/helpers-console/on-leave-dir"
    ;;
  *) ;;
  esac
}

#- - - - - - - - - - -

drive-push() {
  if [ "$#" -gt 2 -o "$1" == -h -o "$#" == 0 ]; then
    echo "Usage: drive-push target"
    echo "Pushes target to google drive using rclone remote google-drive"
    echo "Paths are relative to $HOME/GoogleDrive/"
    return
  fi
  if [[ "$#" == 1 ]]; then
    rclone copyto $HOME/GoogleDrive/$1 google-drive:$1
  else
    rclone copyto $HOME/GoogleDrive/$1 google-drive:$2
  fi
}

#- - - - - - - - - - -

drive-pull() {
  if [ "$#" -gt 2 -o "$1" == -h -o "$#" == 0 ]; then
    echo "Usage: drive-pull target"
    echo "Pulls target from google drive using rclone remote google-drive"
    echo "Paths are relative to $HOME/GoogleDrive/"
    return
  fi
  if [[ "$#" == 1 ]]; then
    rclone copyto "google-drive:$1" "$HOME/GoogleDrive/$1"
  else
    rclone copyto "google-drive:$2" "$HOME/GoogleDrive/$1"
  fi
}

#- - - - - - - - - - -

drive-list() {
  if [[ "$#" == 0 ]]; then
    rclone lsf google-drive:
  else
    rclone lsf "google-drive:$1"
  fi
}

#- - - - - - - - - - -

routine-pull() {
  drive-pull Mackup/.docker/
  # drive-pull Mackup/.emacs.d/
  drive-pull Mackup/.gnupg/
  drive-pull Mackup/.ssh/
  drive-pull Mackup/.subversion/
  drive-pull Mackup/.vscode/
  # drive-pull Mackup/Library/
  drive-pull Mackup/.directory
  drive-pull Mackup/.emacs
  drive-pull Mackup/.gitconfig
  drive-pull Mackup/.hyper.js
  drive-pull Mackup/.inputrc
}

#- - - - - - - - - - -

pacu-wrapper() {
  if ! mount | grep '/dev/sd[bc]1 on /boot' --quiet; then
    echo '/boot doesnt seem to be mounted!'
    return 1
  fi

  if ! mount | grep '/dev/sd[bc]1 on /media/efiPartition' --quiet; then
    echo '/media/efiPartition doesnt seem to be mounted!'
    return 1
  fi

  pacu
  if [ "$?" == 1 ]; then
    touch ~/.pacu-failed
  fi
}

#- - - - - - - - - - -

pacu-checker() {
  if [ -f ~/.pacu-failed ]; then
    echo "pacu failed last session."
    \rm -f ~/.pacu-failed
  fi
}

#- - - - - - - - - - -

root() {
  \sudo bash -ic "$*"
}

#- - - - - - - - - - -
