#!/bin/bash -x

#CONSTANTS
IS_NO_PLAY=0
IS_LADDER=1
IS_SNAKE=2
IS_WIN=100

#VARIABLES
playerPosition=0
diceCount=0

#FUNCTION TO ROLL THE DICE 
function rollDice(){
	dice=$(( 1+RANDOM%6 ))
	echo $dice
}

#FUNCTION FOR GENERATING OPTIONS
function generateOption(){
	option=$(( RANDOM%3 ))
	echo $option
}

declare -A playerPositions

while [ $playerPosition -ne $IS_WIN ]
do
	#CALLING THE FUNCTION
	dice=$( rollDice )
	option=$( generateOption )

	#PLAYER CHECKING FOR THE OPTION
	case $option in
		$IS_NO_PLAY)
			continue
		;;
		$IS_LADDER)
			if (( $(( $playerPosition+$dice ))>$IS_WIN ))
			then
				continue
			else
				playerPosition=$(( $playerPosition+$dice ))
			fi
		;;
		$IS_SNAKE)
			if (( $(( $playerPosition-$dice ))>=0 ))
			then
				playerPosition=$(( $playerPosition-$dice ))
			else
				playerPosition=0
			fi
		;;
		*)
			printf "Invalid"
		;;
	esac
	positions[ (( ++diceCount )) ]=$playerPosition
done

echo ${!positions[@]}
echo ${positions[@]}
