#! /usr/bin/env  bash

separator() {
  printf "\n\n\n\n\n\n\n"
}

sleeper() {
  sleep 3
}

LHOME=/home/vacation

set -e
command sudo true
echo "Mounting Archbak at /mnt and EFI-HARD at /mnt/boot"
sleeper
if grep --quiet "[/]mnt[ ]" /proc/mounts; then
  echo "Something mounted at /mnt, please run \`sudo umount /mnt\` to continue"
  exit 1
else
  command sudo mount /dev/disk/by-label/Archbak /mnt
fi

if grep --quiet "[/]mnt[/]boot[ ]" /proc/mounts; then
  echo "Something mounted at /mnt/boot, please run \`sudo umount /mnt/boot\` to continue"
  exit 1
else
  command sudo mkdir -p /mnt/boot
  command sudo mount /dev/disk/by-label/EFI-HARD /mnt/boot
fi

echo "Rsync /"
separator
sleeper
# rsync commonly exits with non 0 status because of files vanishing
set +e
# -a means -rlptgoD
# --recursive, -r   recursive
# --links, -l       copy symlinks as symlinks
# --perms, -p       preserve permissions
# --times, -t       preserve modification times
# --group, -g       preserve group
# --owner, -o       preserve owner (super-user only)
# -D                same as --devices --specials
# --devices         preserve device files (super-user only)
# --specials        preserve special files
if ! sudo rsync \
  -a \
  --progress \
  --one-file-system \
  --delete-during \
  --exclude="/media/*" \
  --exclude="/mnt/*" \
  --exclude="/proc/*" \
  --exclude="/sys/*" \
  --exclude="/dev/*" \
  --exclude="/boot/*" \
  --exclude="/tmp/*" \
  --exclude="/var/*" \
  --exclude="$LHOME/Desktop/*" \
  --exclude="$LHOME/.cache/spotify/*" \
  --exclude="$LHOME/.cache/mozilla/firefox/mpakm5ej.dev-edition-default/cache2/entries/*" \
  --exclude="$LHOME/.cache/yarn/*" \
  --exclude="$LHOME/.cache/typescript/*" \
  --exclude="$LHOME/.cache/go-build/*" \
  --exclude="$LHOME/.cache/staticcheck/*" \
  --exclude="$LHOME/.cache/electron/*" \
  --exclude="$LHOME/.cache/coursier/*" \
  --exclude="$LHOME/.cache/yay/*" \
  --exclude="$LHOME/.cache/google-chrome/*" \
  / '/mnt'; then
  echo "Rsync errored, continue anyway? (y/n)"
  if ! read -r; then exit 1; fi
  if [ "$REPLY" == "n" ] || [ "$REPLY" == "no" ] || [ "$REPLY" == "N" ] || [ "$REPLY" == "NO" ]; then
    echo "Aborted"
    exit 1
  fi
fi

echo "Rsync $LHOME/Desktop"
separator
sleeper
if ! sudo rsync \
  -a \
  --progress \
  --one-file-system \
  --delete-during \
  --exclude="node_modules" \
  "$LHOME/Desktop/" "/mnt$LHOME/Desktop"; then
  echo "Rsync errored, continue anyway? (y/n)"
  if ! read -r; then exit 1; fi
  if [ "$REPLY" == "n" ] || [ "$REPLY" == "no" ] || [ "$REPLY" == "N" ] || [ "$REPLY" == "NO" ]; then
    echo "Aborted"
    exit 1
  fi
fi

echo "Rsync /var/lib/pacman"
separator
sleeper
command sudo mkdir -p /mnt/var/lib/pacman
if ! sudo rsync \
  -a \
  --progress \
  --one-file-system \
  --delete-during \
  /var/lib/pacman/ '/mnt/var/lib/pacman'; then
  echo "Rsync errored, continue anyway? (y/n)"
  if ! read -r; then exit 1; fi
  if [ "$REPLY" == "n" ] || [ "$REPLY" == "no" ] || [ "$REPLY" == "N" ] || [ "$REPLY" == "NO" ]; then
    echo "Aborted"
    exit 1
  fi
fi

echo "Rsync /boot"
separator
sleeper
if ! sudo rsync \
  -a \
  --progress \
  --delete-during \
  --exclude=.DS_Store \
  --exclude="._*" \
  --exclude="._.*" \
  /boot/ '/mnt/boot'; then
  echo "Rsync errored, but script is over"
fi

if command -v today-date >/dev/null && [ "$SYSBKP_DATE_FILE" ]; then
  today-date write "$SYSBKP_DATE_FILE"
  echo "run date saved to $SYSBKP_DATE_FILE"
fi
