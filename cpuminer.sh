#!/bin/bash
#mining pool selector and command abbreviator
#© 2018. This program is released into the public domain.

printf "welcome to cpuminer!\\n"

function currency {

        printf "what will you be mining today?\\n1.)digibyte\\n2.)lynx\\n3.)artbyte\\n4.)litecoin\\n"
        read -r CURRENCY
        printf "today you will mine:"

        case $CURRENCY in
                "1") printf "digibyte\\n";;
                "2") printf "lynx\\n";;
                "3") printf "artbyte\\n";;
                "4") printf "litecoin\\n";;
                *) printf "invalid selection, try again\\n";currency;;
        esac
}

function pool {

        printf  "where will you mine today?\\n1.)multipool\\n2.)theblocksfactory\\n"
        read -r POOL
        printf "today you will mine at "
        case $POOL in
                "1") printf "multipool\\n";;
                "2") printf "theblocksfactory\\n";;
                *) printf "invalid selection, try again\\n"; pool;;
        esac


        if [  "$CURRENCY" != 1 ] && [ "$POOL" == 2 ];  then
                printf "invalid selection, you can't mine that at theblocksfactory, exiting.\\n" ; exit
        fi
}

function quietness {
        printf "will you me mining in quiet mode?[y/n]\\n"
        read -r QUIET
        case $QUIET in
                "y") export QUIET="-q";;
                "n") export QUIET=" ";;
                *) printf "invalid selection, try again.\\n"; quietness;;

        esac
}

function threads {
        printf "how many processors will you use (out of $(nproc))?\\n"
        read -r THREADS
        if [ "$THREADS" \< "$(nproc)" ]; then
                printf "you will use $THREADS threads/processors.\\n"
        else
                printf "invalid selection, try again.\\n"
                threads
        fi
}

function username {
        if [ "$POOL" == 1 ]; then
                USERNAME="typefacechaos1.3"
        fi
        if [ "$POOL" == 2 ]; then
                USERNAME="typefacechaos.1"
        fi
}


function poolport {
        case $POOL in
                "1") if [ "$CURRENCY" == 1 ]; then
                        POOLPORT="us.multipool.us:3351"
                fi ;
                if [ "$CURRENCY" == 2 ]; then
                        POOLPORT="us.multipool.us:3348"
                fi ;
                if [ "$CURRENCY" == 3 ]; then
                        POOLPORT="us.multipool.us:3359"
                fi
                if [ "$CURRENCY" == 4 ]; then
                        POOLPORT="us.multipool.us:3334"
                fi;;
                "2")
                        POOLPORT="s1.theblocksfactory.com:9004";;
        esac

}

function main {
        if [ -f ~/minerd ]; then
                currency
                pool
                quietness
                threads
                poolport
                username

                cd
                ./minerd -o stratum+tcp://"$POOLPORT" -u "$USERNAME" -p x "$QUIET" -t "$THREADS"
        else
                printf "you must have minerd to run this script, please install and try again.\\n"
        fi
}
main
