# Linux ~/.bashrc

# If not running interactively, don't do anything
# [[ $- != *i* ]] && return

DOTFILE_PATH="/home/vacation/Desktop/interface"
# echo "I am" $(whoami)

#========== MacOS Bashrc
if [ -f $DOTFILE_PATH/.bashrc.bash ]; then
  source $DOTFILE_PATH/.bashrc.bash
fi

#========== Aliases
if [ -f $DOTFILE_PATH/.aliases.bash ]; then
  source $DOTFILE_PATH/.aliases.bash
else
  echo "$DOTFILE_PATH/.aliases.bash not found"
fi

#========== Functions
if [ -f $DOTFILE_PATH/.functions.bash ]; then
  source $DOTFILE_PATH/.functions.bash
fi

#========== Prompt
if [ -f $DOTFILE_PATH/.prompt.bash ]; then
  source $DOTFILE_PATH/.prompt.bash
fi

#========== Overrides
alias gmv='mv'
alias gsed='sed'
alias gdd='dd'
alias pbcopy='xclip -selection c'
alias gls='/usr/bin/ls'
alias google="s -p duckduckgo"
__git_ps1(){
  true
}
# unalias dircolors

#========== Keyboard
#xmodmap $HOME/.xmodmap
#touch $HOME/Desktop/dhfd

#========== Environment
export PATH="$HOME/bin/monero-gui:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:\
/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/bin:/home/linuxbrew/.linuxbrew/bin"
export CDPATH=$HOME:/Media:/
export EDITOR='code'

#========== Misc
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"
#GO Binaries
export PATH=$PATH:/usr/local/go/bin

#========== Linux specific
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
alias .s='sudo'

#-----pacman & arch
alias pac='pacman'
alias paci='pacman -Si'
alias pacl='pacman -Q'
alias pacle='pacman -Q --explicit'
alias pacs='pacman -Ss'
alias pacI='sudo pacman -S'
alias pacR='sudo pacman -R'
alias pacu='sudo pacman -Suy --noconfirm && sudo pacman -Sc --noconfirm'
alias pacuOff='pacu-wrapper && systemctl poweroff'
alias pacuReboot='pacu-wrapper && systemctl reboot'

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

drive-list() {
  if [[ "$#" == 0 ]]; then
    rclone lsf google-drive:
  else
    rclone lsf "google-drive:$1"
  fi
}

routine-pull(){
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

linux-start(){
  #routine-pull &
  pacu-checker
}

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

pacu-checker() {
  if [ -f ~/.pacu-failed ]; then
    echo "pacu failed last session."
    \rm -f ~/.pacu-failed
  fi
}

#eval $(keychain -q --eval id_rsa)
linux-start
#tilda &
#disown
