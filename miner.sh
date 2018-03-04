#!/bin/bash
#mining pool selector and command abbreviator
#© 2018. This program is released into the public domain.

printf "welcome to EZscrytpminer!\\n"
printf "what will you be mining today?\\n1.)digibyte\\n2.)lynx\\n3.)artbyte\\n"
read -r CURRENCY
printf "today you will mine:"

case $CURRENCY in
        "1") printf "digibyte\\n";;
        "2") printf "lynx\\n";;
        "3") printf "artbyte\\n";;
        *) printf "invalid selection, exiting\\n";exit;;
esac

printf  "where will you mine today?\\n1.)multipool\\n2.)theblocksfactory\\n"
read -r POOL
printf "today you will mine at "
case $POOL in
        "1") printf "multipool\\n";;
        "2") printf "theblocksfactory\\n";;
        *) printf "invalid selection, exiting.\\n";;
esac
if [  "$CURRENCY" != 1 ] && [ "$POOL" == 2 ];  then
        printf "invalid selection, you can't mine that at theblocksfactory, exiting.\\n" ; exit
fi
POOLPORT="foo"
USERNAME="bar"
function username {
        if [ "$POOL" == 1 ]; then
                export USERNAME="typefacechaos1.3"
        fi
        if [ "$POOL" == 2 ]; then
                export USERNAME="typefacechaos.1"
        fi
        echo $USERNAME
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
                        export POOLPORT="us.multipool.us:2259"
                fi;;

                "2")
                        export POOLPORT="s1.theblocksfactory.com:9004";;
        esac

        echo $POOLPORT
}
POOLPORT=$(poolport)
USERNAME=$(username)
cd
./bfgminer/bfgminer --scrypt -o stratum+tcp://"$POOLPORT" -u "$USERNAME" -p x -S all --set GSD:clock=300
