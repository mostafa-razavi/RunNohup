#!bin/bash
EXE=$1
COMMAND="nohup ""$EXE"" > /dev/null 2>&1 & disown \$!"
eval "$COMMAND"

