#! /usr/bin/env bash

# Linux aliases

#========== Override macos
alias gmv='mv'
alias gsed='sed'
alias gdd='dd'
alias pbcopy='xclip -selection c'
alias gls='/usr/bin/ls'
alias google="s -p duckduckgo"
alias .i="cd $DOTFILE_PATH"

#========== Generic
alias aur='aurman'
alias aurs='aurman --aur --sync --search'
alias aurI='aurman --sync'
alias sys='systemctl'
alias lsblk='lsblk -f'
alias desktop='sudo systemctl start sddm.service'
alias sddm='sddm.service'
alias soff='systemctl poweroff'
alias drive='rclone'
alias ssh='ssh-ident'
alias root='\sudo bash -ixc "$(fc -ln -1)"'
alias sudo='root'
alias .s='root'
alias pac='pacman'
alias paci='pacman --sync --info'                                                                            # -Si
alias pacl='pacman --query'                                                                                  # -Q
alias pacle='pacman --query --explicit'                                                                      # -Qe
alias pacs='pacman --sync --search'                                                                          # -Ss
alias pacI='sudo pacman --sync --refresh --noconfirm'                                                        # -S
alias pacR='sudo pacman --remove'                                                                            # -R
alias pacRdd='sudo pacman --remove --nodeps --nodeps'                                                        # -Rdd
alias pacu='sudo pacman --sync --sysupgrade --refresh --noconfirm && sudo pacman --sync --clean --noconfirm' # Syu && Sc
alias pacuOff='pacu-wrapper && systemctl poweroff'
alias pacuReboot='pacu-wrapper && systemctl reboot'
