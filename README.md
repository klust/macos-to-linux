# Connecting from macOS to Linux

This work-in-progress repository contains a lot of information on how 
to access Linux machines and in particular supercomputer from macOS.

## Setting up the mkdocs environment

Set up your environment by creating a python virtual environment and to activate it.
Therefore, in the directory where you want to put your virtual environment(s) execute:

```
python3 -m venv mkdocs-klust
source mkdocs-klust/bin/activate
```

Which would create and initialise the virtual environment `hpcwin`. 
Once the virtual environment is ready, you can install the needed dependencies.
Go to this directory in the cloned repository and run

```
pip install -r requirements.txt
```