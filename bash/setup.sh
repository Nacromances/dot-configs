#!/usr/bin/env bash

BACKUP_DIR="back_up"

pushd
cd ${HOME}
git clone https://github.com/Bash-it/bash-it.git .bash_it
~/.bash_it/install.sh --silent --no-modify-config

mkdir ${BACKUP_DIR}
if [ -f .bashrc ];
then
    mv .bashrc ${BACKUP_DIR}
    ln -s -f dot-configs/bash/.bashrc
fi

if [ -f .bash_profile ];
then
    mv .bash_profile ${BACKUP_DIR}
    ln -s -f dot-configs/bash/.bash_profile
fi

popd

echo "DONE !!"
