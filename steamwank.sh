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
  -i|--id)
  ID=$(echo -n "$2" | grep [0-9])
  shift
  ;;
  -n|--name)
  ID=$(curl -s https://steamcommunity.com/groups/$2/memberslistxml/?xml=1 | grep -oPm1 "(?<=<groupID64>)[^<]+" | grep [0-9])
  shift
  ;;
  *)
  ;;
esac
shift
done

if [ -z ${ID+x} ]; then >&2 echo "Error: Steam group ID needed!"; exit 1; fi

export LD_LIBRARY_PATH="${LD_LIBRARY_PATH-}:/usr/lib32" # steam-native hotfix

steam steam://friends/joinchat/$ID
