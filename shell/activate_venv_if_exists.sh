#!/bin/sh

## Global variables
THIS_FILE_NAME=$(basename $0)
THIS_FILE_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BASH_PROFILE_PATH=$HOME/.bash_profile

## Functions
add_script_to_bash_profile(){
  if grep -Fiq "$THIS_FILE_NAME" $BASH_PROFILE_PATH; then
    :
  else
    echo "\n" >> $BASH_PROFILE_PATH
    echo "export PROMPT_COMMAND=\"\\\$(sh $THIS_FILE_PATH/$THIS_FILE_NAME)\"" >> $BASH_PROFILE_PATH
  fi
}

check_if_venv_is_activated(){
  # If the environment variable exists, it shows 1 and 0 otherwise
  if [ "$VIRTUAL_ENV" != "" ]; then echo 1; else echo 0; fi
}

check_if_venv_exists_in_current_path(){
  # If the environment variable exists, it shows 1 and 0 otherwise. It searchs for a folder
  # whose name ends with "env"
  if ls *env 2>/dev/null | grep -qi pyvenv.cfg; then 
      echo 1 
    else
      echo 0
  fi
}

# Execution
add_script_to_bash_profile
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
    echo ". $venv_path/bin/activate"
  fi
fi