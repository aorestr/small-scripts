### Add the following lines at the end of your ~/.bash_profile

function activate_venv_if_exists() {
  local file="./venv/bin/activate"
  echo "if [ -f $file ]; then source $file; fi"
}


# try to activate a python venv if exists on the current folder
export PROMPT_COMMAND=$(activate_venv_if_exists)