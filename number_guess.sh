#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess --tuples-only -c"

RAND=$(($RANDOM % 1000 + 1))

echo "Enter your username:"
read USERNAME

USER_ID=$($PSQL "SELECT user_id FROM users WHERE name='$USERNAME'")

if [[ -z $USER_ID ]]
then
  echo "didn't find username $USERNAME"
  USER_ACCOUNT_CREATED=$($PSQL "INSERT INTO users (name) VALUES('$USERNAME')")
  echo "USER_ACCOUNT_CREATED = $USER_ACCOUNT_CREATED"
else
  echo "found username $USERNAME"
fi

exit