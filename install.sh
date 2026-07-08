#!/usr/bin/env bash

# setup symlinks in home directory. create them using relative dir
# without ~ component so the link don't have /$HOME/$USER in it.

INITDIR=.init.pub

# Backup a file if it exists as a regular file.
# Returns 1 if target is already a symlink (caller should skip linking).
backup_if_needed() {
  local target="$1"

  # if a link already exist, return abort status
  if [[ -L "$target" ]]; then
    echo "Skipping $target (already a symlink)"
    return 1
  fi

  # otherwise if file exists, back it up
  if [[ -e "$target" ]]; then
    local stamp=$(date +%Y%m%d_%H%M%S)
    mv "$target" "${target}.${stamp}"
    echo "Backed up $target -> ${target}.${stamp}"
  fi

  return 0
}


pushd ~

if backup_if_needed ".zshrc"; then
  echo "Linking .zshrc -> ${INITDIR}/zsh/zshrc"
  ln -s "${INITDIR}/zsh/zshrc" ".zshrc"
fi

popd

# map home/end to beg/end of line on mac
if [[ "$OSTYPE" = darwin* ]]; then
  mkdir -p "${HOME}/Library/KeyBindings"
  local_target="${HOME}/Library/KeyBindings/DefaultKeyBinding.dict"
  if [[ -e "$local_target" ]]; then
    echo "Skipping $local_target (already exists)"
  else
    echo "Linking $local_target -> ${HOME}/${INITDIR}/mac/DefaultKeyBinding.dict"
    ln -s "${HOME}/${INITDIR}/mac/DefaultKeyBinding.dict" "$local_target"
  fi
fi
