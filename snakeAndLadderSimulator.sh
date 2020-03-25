#!/bin/bash -x

#INITIAL PLAYER POSITION
playerPosition=0

#FUNCTION TO ROLL THE DICE 
function rollDice(){
	dice=$(( 1+RANDOM%6 ))
	echo $dice
}

#CALLING THE FUNCTION
dice=$( rollDice )
