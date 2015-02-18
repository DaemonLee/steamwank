#!/bin/sh

#   Copyright 2015 Daemon Lee Schmidt <DaemonLeeSchmidt@gmail.com>

#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at

#       http://www.apache.org/licenses/LICENSE-2.0

#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

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
