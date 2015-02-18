#!/bin/sh

while [[ $# > 1 ]]
do
opts="$1"

case $opts in
    -b|--browser)
    BROWSER="$2"
    shift
    ;;
    -i|--id)
    ID="$2"
    shift
    ;;
    -t|--time)
    TIME="$2"
    shift
    ;;
    *)

    ;;
esac
shift
done

if [ -z ${TIME+x} ]; then TIME=2; fi # Maybe to quick for slow computers
if [ -z ${BROWSER+x} ]; then BROWSER="xdg-open"; fi
if [ -z ${ID+x} ]; then >&2 echo "Error: Steam group ID needed!"; exit; fi

export LD_LIBRARY_PATH="${LD_LIBRARY_PATH-}:/usr/lib32" # steam-native hotfix

$BROWSER steam://friends/joinchat/$ID &

sleep $TIME

killall $BROWSER
