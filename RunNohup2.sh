#!bin/bash
mainCommand=$1
logFile=$2

if [ "$logFile" == "" ]; then
	logFile="/dev/null"
fi

read -p "Do you want to receive an email notification when the job is done? (y/n) " yesORno
lowerCaseYesOrNo=$(echo "$yesORno" | sed -e 's/\(.*\)/\L\1/')
if [ "$lowerCaseYesOrNo" == "y" ] || [ "$lowerCaseYesOrNo" == "yes" ]; then
	read -p "Enter your email address: " email
	read -sp "Enter your email password: " pass
	echo
fi

notification="bash ~/Git/SendMail/SendMail.sh"

echo

if [ "$lowerCaseYesOrNo" == "y" ] || [ "$lowerCaseYesOrNo" == "yes" ]; then
	nohup bash -c "  startSeconds=\$(date +%s) && echo \$startSeconds && $mainCommand && endSeconds=\$(date +%s) && duration=\$(echo \(\$endSeconds-\$startSeconds\) | bc) && $notification $email $pass \$duration " > $logFile 2>&1 &
	echo "Nohup job is running. You will receive an email when the job is done!"
else
	nohup $mainCommand > $logFile 2>&1 &
	echo "Nohup job is running."
fi




