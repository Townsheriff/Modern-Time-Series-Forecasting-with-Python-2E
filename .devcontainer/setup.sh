#! /bin/bash
set -e

# Setup SSH Ketys from host, used for github ssh key
echo "Setting up ssh keys"
cp -r /host/.ssh /root/.ssh && chmod -R 600 /root/.ssh && chmod 700 /root/.ssh && chown -R root:root /root/.ssh

# Setting up project
echo "Setting up project"
virtualenv .venv
source .venv/bin/activate
# There is a conflict with dependency symengine, two pacakges require different versions
# We hot fix that with frozen packages and no deps
pip install -r requirements_new.txt --no-deps
# Testing dependencies
python test_installation.py

# Creates hardlink from our dataset
.devcontainer/link-data.sh
python test_data_download.py
