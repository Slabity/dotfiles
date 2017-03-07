#!/bin/bash

source $HOME/.local/share/scripts/utils.sh

FNAME=$HOME/.local/bin/$1

cat << 'EOF' | $EDITOR - +"file $FNAME"
#!/bin/bash

source $HOME/.local/share/scripts/utils.sh
EOF

if [ -f $FNAME ];
then
    chmod +x $FNAME
fi

