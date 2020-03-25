#!/bin/bash -x

#CONSTANTS
IS_NO_PLAY=0
IS_LADDER=1
IS_SNAKE=2

#INITIAL PLAYER POSITION
playerPosition=0

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

#CALLING THE FUNCTION
dice=$( rollDice )
option=$( generateOption )

#PLAYER CHECKING FOR THE OPTION
case $option in
	$IS_NO_PLAY)
		playerPosition=0
	;;
	$IS_LADDER)
		playerPosition=$(( $playerPosition+$dice ))
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
