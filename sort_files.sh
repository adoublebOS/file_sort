#!/bin/bash

#VARIABLES
WORKDIR=$(pwd)
BACKUPDIR=$(date +'%T--%F')
mkdir -p "/home/$USER/backups/script_backups"
DESTINATION=$"/home/$USER/backups/script_backups"

printf "$BACKUPDIR is a backup directory" | boxes -d stone -p a2v1

#DIRECTORY CONFIRMATION CODE
printf "\n\nIs the working directory correct?\n$(pwd)\nConfirm with 'y'"
read CONFIRM
if [ "$CONFIRM" == "y" ]; then
    echo $DESTINATION/$BACKUPDIR
    mkdir $DESTINATION/$BACKUPDIR
    sudo tar czf "$DESTINATION/$BACKUPDIR/$BACKUPDIR.tar.gz" $WORKDIR
    for file in *; do
        if [ "$file" != "sort_files.sh" ] && [[ -f "$file" ]] && [ "${file##*.}" != "$file" ]; then
            echo "${file##*.}"
            mkdir -p "${file##*.}"
            mv "$file" "${file##*.}"
        elif [ "${file##*.}" == "$file" ] && [[ -f "$file" ]]; then
            mkdir -p "no-file-type"
            mv "$file" "no-file-type"
        fi
    done
else
    echo "Process terminated."
fi
