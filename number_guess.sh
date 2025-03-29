#!/bin/bash
PSQL="psql --username=freecodecamp --dbname= --tuples-only -c"

RAND=$(($RANDOM % 1000 + 1))

echo "Random number: $RAND"

exit