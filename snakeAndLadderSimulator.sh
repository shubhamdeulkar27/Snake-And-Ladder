#!/bin/bash -x

#CONSTANTS
IS_NO_PLAY=0
IS_LADDER=1
IS_SNAKE=2
IS_WIN=100

#VARIABLES
playerOne=0
playerTwo=0
diceOneCount=0
diceTwoCount=0
playerTurn=0

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

#FUNCTION FOR PLAY
function play(){
	local playerPosition=0
	dice=$( rollDice )
	option=$( generateOption )
	case $option in
		$IS_NO_PLAY)
			playerPosition=0
		;;
		$IS_LADDER)
			playerPosition=$(( $playerPosition+$dice ))
		;;
		$IS_SNAKE)
			playerPosition=$(( $playerPosition-$dice ))
		;;
		*)
			printf "Invalid"
		;;
	esac
echo $playerPosition
}

#DICTIONARIES TO STORE BOTH PLAYERS MOVES
declare -A playerOneMoves
declare -A playerTwoMoves

#PALYING GAME WITH TWO PLAYERS
while [ true ]
do
	playGame=$( play )
	if (( $(( $playerTurn%2 ))==0 ))
	then
		if (( $playGame>0 ))
		then
			if (( $(( $playerOne+$playGame ))<=$IS_WIN ))
			then
				playerOne=$(( $playerOne+$playGame ))
			else
				continue
			fi
		elif (( $playGame<0 ))
		then
			if (( $(( $playerOne+$playGame ))>=0 ))
			then
				playerOne=$(( $playerOne+$playGame ))
			else
				continue
			fi
		fi
	playerOneMoves[ (( diceOneCount++ )) ]=$playerOne
	elif (( $(( $playerTurn%2 ))!=0 ))
	then
		if (( $playGame>0 ))
		then
			if (( $(( $playerTwo+$playGame ))<=$IS_WIN ))
			then
				playerTwo=$(( $playerTwo+$playGame ))
			else
				continue
			fi
		elif (( $playGame<0 ))
		then
			if (( $(( $playerTwo+$playGame ))>=0 ))
			then
				playerTwo=$(( $playerTwo+$playGame ))
			else
				continue
			fi
		fi
		playerTwoMoves[ (( diceTwoCount++ )) ]=$playerTwo
	fi
	(( playerTurn++ ))

	if (( $playerOne==$IS_WIN || $playerTwo==$IS_WIN ))
	then
		break
	fi
done

