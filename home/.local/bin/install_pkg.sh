#!/bin/bash

source $HOME/.local/share/scripts/utils.sh

# Make sure we have at least package atom
if [ -z "$1" ];
then
    u_error "Need at least one package atom"
fi

for pkg in "$@"
do
    QUERY=$(equery -q l $pkg -F "[\$location] [\$mask] \$cpv:\$slot::\$repo");
    if [ $? -ne 0 ];
    then
        u_error "Could not find package $pkg"
        exit 1
    else
        printf "$QUERY\n"
    fi
done
