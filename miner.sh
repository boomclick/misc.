#!/bin/bash
#mining pool selector and command abbreviator
#© 2018. This program is released into the public domain.

printf "welcome to scryptminerUS!\\n"

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


function username {
        if [ "$POOL" == 1 ]; then
                export USERNAME="typefacechaos1.3"
        fi
        if [ "$POOL" == 2 ]; then
                export USERNAME="typefacechaos.1"
        fi
}


function poolport {
        case $POOL in
                "1") if [ "$CURRENCY" == 1 ]; then
                export POOLPORT="us.multipool.us:3351"
                fi ;
                if [ "$CURRENCY" == 2 ]; then
                        export POOLPORT="us.multipool.us:3348"
                fi ;
                if [ "$CURRENCY" == 3 ]; then
                        export POOLPORT="us.multipool.us:3359"
                fi
                if [ "$CURRENCY" == 4 ]; then
                        export POOLPORT="us.multipool.us:3334"
                fi;;
                "2")
                        export POOLPORT="s1.theblocksfactory.com:9004";;
        esac

        echo $POOLPORT
}

function main {
        if [ -f ~/minerd ]; then
                currency
                pool
                POOLPORT=$(poolport)
                USERNAME=$(username)
                cd
                ./bfgminer/bfgminer --scrypt -o stratum+tcp://"$POOLPORT" -u "$USERNAME" -p x -S all --set GSD:clock=300        else
                printf "you must have minerd to run this script, please install and try again.\\n"
        fi
}
main
