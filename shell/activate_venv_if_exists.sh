#!/bin/sh

## Global variables
THIS_FILE_NAME="$(basename $0)"
THIS_FILE_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BASH_PROFILE_NAME=".bash_profile"
BASH_PROFILE_PATH="$HOME/$BASH_PROFILE_NAME"
BASHRC_PATH="$HOME/.bashrc"

## Functions
add_script_to_bash_profile(){
  # Create .bash_profile if it doesn't exist
  if [ ! -f $BASH_PROFILE_PATH ]; then
    touch $BASH_PROFILE_PATH
  fi
  # Add .bash_profile execution to .bashrc
  if grep -Fiq $BASH_PROFILE_NAME $BASHRC_PATH; then
    :
  else
    echo "\n# If it exists, run the bash_profile when opening a terminal\nif [ -f $BASH_PROFILE_PATH ]; then . $BASH_PROFILE_PATH; fi" >> $BASHRC_PATH
  fi
  # Export the command to run this script to the .bash_profile
  if grep -Fiq $THIS_FILE_NAME $BASH_PROFILE_PATH; then
    :
  else
    echo "\nexport PROMPT_COMMAND=\"\\\$(sh $THIS_FILE_PATH/$THIS_FILE_NAME flag)\"" >> $BASH_PROFILE_PATH
    exec bash
  fi
}

check_if_venv_is_activated(){
  # If the environment variable exists, it shows 1 and 0 otherwise
  if [ "$VIRTUAL_ENV" != "" ]; then echo 1; else echo 0; fi
}

check_if_venv_exists_in_current_path(){
  # It searchs for a folder whose name ends with "env". Echos 1 if there a folder like that and 0 if not
  if ls *env 2>/dev/null | grep -qi pyvenv.cfg; then 
      echo 1 
    else
      echo 0
  fi
}

# Execution
if [ -z "$1" ]; then
  # This part of the code won't be ever run by bash on its own
  add_script_to_bash_profile
else
  venv_exists="$(check_if_venv_exists_in_current_path)"
  if [ "$(check_if_venv_is_activated)" = "1" ]; then
    if [ "$venv_exists" = "0" ]; then
      # Deactivate a venv 
      echo "deactivate"
    fi
  else
    if [ "$venv_exists" = "1" ]; then
      # Activate the venv
      venv_path="$(dirname $(find ./ -name 'pyvenv.cfg' -exec readlink -f {} \;))"
      echo "source $venv_path/bin/activate"
    fi
  fi
fi