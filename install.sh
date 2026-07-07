#!/usr/bin/env bash

# setup symlinks in home directory. create them using relative dir
# without ~ component so the link don't have /$HOME/$USER in it.

INITDIR=.init.pub

pushd ~

ln -sf "${INITDIR}/zsh/zshrc" ".zshrc"

popd

# map home/end to beg/end of line on mac
if [[ "$OSTYPE" = darwin* ]]; then
  mkdir -p "${HOME}/Library/KeyBindings"
  pushd "${HOME}/Library/KeyBindings"
  ln -s "${HOME}/${INITDIR}/mac/DefaultKeyBinding.dict" .
  popd
fi
