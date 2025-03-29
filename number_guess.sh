#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess --tuples-only -c"

RAND=$(($RANDOM % 1000 + 1))
COMPLETED=0
NUMBER_OF_GUESSES=0

echo "RAND is $RAND"

echo "Enter your username:"
read USERNAME

USER_DATA=$($PSQL "SELECT name,games_played,best_game FROM users WHERE name='$USERNAME'")

if [[ -z $USER_DATA ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  USER_ACCOUNT_CREATED=$($PSQL "INSERT INTO users (name) VALUES('$USERNAME')")
  #echo "USER_ACCOUNT_CREATED = $USER_ACCOUNT_CREATED"
else
  echo "$USER_DATA" | while read USERNAME BAR GAMES_PLAYED BAR BEST_GAME
  do
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  done
fi
echo "Guess the secret number between 1 and 1000:"
while [[ $COMPLETED = 0 ]] 
do
  NUMBER_OF_GUESSES=$((NUMBER_OF_GUESSES + 1))
  read NUMBER_GUESSED
  re='^[0-9]+$'
  if [[ $NUMBER_GUESSED =~ $re ]]
  then
    #echo "number guessed: $NUMBER_GUESSED rand: $RAND"
    if [[ $NUMBER_GUESSED < $RAND ]]
    then
      echo "It's higher than that, guess again:"
    elif [[ $NUMBER_GUESSED > $RAND ]]; then
      echo "It's lower than that, guess again:"
    else
      echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $RAND. Nice job!"
      COMPLETED=1
    fi
  else
    echo "That is not an integer, guess again:"
  fi
done
exit