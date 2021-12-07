#!/bin/bash


# After fresh linux installation run the following command sequentially

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y curl unzip build-essential ncurses-dev
sudo apt-get install -y byacc zlib1g-dev python-dev git cmake python3-pip
sudo apt-get install -y default-jdk ant
sudo apt-get install -y libzmq3-dev libcurl4-openssl-dev libssl-dev




# Optimize profile and terminal
# run these code only once

cat bash_profile.txt >> ~/.bash_profile
cat bashrc.txt >> ~/.bashrc

# refresh the changes

source ~/.bashrc



# Install miniconda
bash Miniconda3*.sh -b




# Initialize the conda env
~/miniconda3/condabin/conda init

echo ""
echo "<<<Good luck on your new journey with Bioinformatics>>"
echo "----Please restart your terminal------------"


