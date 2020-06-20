# small-scripts
Collection of small scripts I develop for some reason.

Here a list of every script explained:
* `shell/activate_venv_if_exists.sh`: run `sh activate_venv_if_exists.sh` and it will overwrite the `PROMPT_COMMAND` environment variable on the `~/.bash_profile` file. If that file does not exists it creates it. The script activates a Python virtual environment if the folder where you are working on your shell contains one. Deactivates it if not. The search is done by looking for a folder that ends with _env_ in its name. Tested in _Ubuntu 18.04_.