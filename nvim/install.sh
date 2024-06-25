#!/usr/bin/env bash

mv ~/.config/nvim ~/.config/nvim.bak
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cp -R ${SCRIPT_DIR} ~/.config/nvim 
