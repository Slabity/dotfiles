# Checks if a program exists.
type_exists() {
    if [[ $(type $1) ]];
    then
        return 0
    else
        return 1
    fi
}

# Use tput to determine terminal sequences.
if type_exists tput;
then
    bold=$(tput bold)
    unbold=$(tput dim)
    italic=$(tput sitm)
    unitalic=$(tput ritm)
    uline=$(tput smul)
    unuline=$(tput rmul)
    reset=$(tput sgr0)

    col0=$(tput setaf 0)
    col1=$(tput setaf 1)
    col2=$(tput setaf 2)
    col3=$(tput setaf 3)
    col4=$(tput setaf 4)
    col5=$(tput setaf 5)
    col6=$(tput setaf 6)
    col7=$(tput setaf 7)
    col8=$(tput setaf 8)
    col9=$(tput setaf 9)
    col10=$(tput setaf 10)
    col11=$(tput setaf 11)
    col12=$(tput setaf 12)
    col13=$(tput setaf 13)
    col14=$(tput setaf 14)
    col15=$(tput setaf 15)

    blackl=$col0
    black2=$col8
    red1=$col1
    red2=$col9
    green1=$col2
    green2=$col10
    yellow1=$col3
    yellow2=$col11
    blue1=$col4
    blue2=$col12
    purple1=$col5
    purple2=$col13
    cyan1=$col6
    cyan2=$col14
    white1=$col7
    white2=$col15

    strictblack=$(tput setaf 16)
    strictred=$(tput setaf 124)
    strictgreen=$(tput setaf 82)
    strictyellow=$(tput setaf 226)
    strictblue=$(tput setaf 19)
    strictpurple=$(tput setaf 92)
    strictcyan=$(tput setaf 45)
    strictwhite=$(tput setaf 255)
fi

check="\xE2\x9C\x93"

u_header() {
    printf "${bold}==========  %s  ==========${reset}\n" "$1"
}

u_success() {
    printf "${bold}${strictgreen}Success:${unbold} %s${reset}\n" "$1"
}

u_note() {
    printf "${bold}${strictcyan}Note:${unbold} %s${reset}\n" "$1"
}

u_warning() {
    printf "${bold}${strictyellow}Warning:${unbold} %s${reset}\n" "$1"
}

u_error() {
    printf "${bold}${strictred}Error:${unbold} %s${reset}\n" "$1"
}

u_confirm() {
    printf "${bold}${strictwhite}%s (y/n) ${reset}" "$1"
    read "REPLY"

    if [[ $# == 1 ]];
    then
        if [[ "$REPLY" =~ ^[Yy]$ ]];
        then
            return 0
        else
            return 1
        fi
    fi
}
