#! /usr/bin/env bash

#- - - - - - - - - - -

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
