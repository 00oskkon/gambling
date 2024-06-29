#!/bin/bash

# FOR DEBUGGING ONLY!
#shopt -s expand_aliases
#alias zenity='zenity 2> >(grep -v Gtk-WARNING >&2)'

# Check Dependencies
if ! [ -x "$(command -v /usr/bin/zenity)" ]; then
	send_notify "zenity not installed"
	exit 1
fi

playAgain=0
min=1
max=100
guess=0
score=$(($max+1))
response=""

while [ "$playAgain" == 0 ]
do
	number=$(("$min" + $RANDOM % "$max"))
	#echo "$number"
	
	while [ "$guess" != "$number" ]
	do
		guess=$(zenity --entry --title="Gambling!" --text="Guess a number between $min - $max:") || exit 1
		
		if [[ "$guess" > "$number" ]]
		then
			#echo "$guess"
			zenity --error --text="$guess is too high!"
		elif [[ "$guess" < "$number" ]]
		then
			#echo "$guess"
			zenity --error --text="$guess is too low!"
		fi
		
		((score--))
	done
	
	zenity --info --text="Number: $number\nYou WIN!\nScore: $score"
	zenity --question --text="Play again?"
	playAgain=$?
done
