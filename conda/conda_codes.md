## Create a conda environment
`conda create -n ENV_NAME`


## Remove an environment
`conda env remove -n ENV_NAME` python=3.10


## Create an environment from yml file
`conda env create -f environment.yml`


## Display Conda environment information
`conda info`


## List the name of environments
`conda evn list`


## Clone an environment
`conda create --name newCloneEnvName --clone envname`

## Adding a channel and moving to top of the priority list
`conda config --add channels biobakery`


# Viewing a list of the packages in an environment
## If the environment is not activated, in your terminal window or an Anaconda Prompt, run:
`conda list -n myenv`


## If the environment is activated, in your terminal window or an Anaconda Prompt, run:
`conda list`


## To see if a specific package is installed in an environment, in your terminal window or an Anaconda Prompt, run:
`conda list -n myenv scipy`





