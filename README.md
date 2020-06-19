# small-scripts
Collection of small scripts I develop for some reason.

Here a list of every script explained:
* `shell/activate_venv_if_exists.sh`: run it with `sh` and it will add overwrite the `PROMPT_COMMAND` environment variable on the `~/.bash_profile` file. Activates a Python virtual environment if the folder where you are working on your shell contains one. Deactivates it if not. Tested in _Ubuntu 18.04_.