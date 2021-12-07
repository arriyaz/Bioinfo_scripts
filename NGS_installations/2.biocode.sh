#!/bin/bash


# add default channels
conda config --add channels bioconda
conda config --add channels conda-forge


# Install jupyter-notebook, python and bash kernel
conda install -c conda-forge jupyter_core jupyter_client jupyter_contrib_nbextensions bash_kernel -y


# activate bash kernel
python -m bash_kernel.install


# create suitable environment for ngs and python
conda env create -n biocode --file env2.yml


# Activate the biocode environment
eval "$(conda shell.bash hook)"
conda activate biocode


# Activate the python kernel
python -m ipykernel install --user --name ipy_biocode --display-name "Bio-Python"


# Add a R kernel in this environment
Rscript -e "IRkernel::installspec(name = 'ir-biocode', displayname = 'Bio-R')"


echo ""
echo "<<<<<< You are ready to go. >>>>>>"
