#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ $1 ]]
then 
  #if arg is a number
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ATOMIC_NUMBER=$1
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $1")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $1")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $1")
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $1")
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $1")
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $1")

    echo "The element with atomic number $1 is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  
  else
    #if arg is the symbol
    if [[ $1 =~ ^[a-zA-Z]{1,2}$ ]]
    then
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
      if [[ -z $ATOMIC_NUMBER ]]
      then
        echo "I could not find that element in the database."
        exit
      fi
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
      TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER")

      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."

      else
        #if arg is the name
        if [[ $1 =~ ^[a-zA-Z]+$ ]]
        then
          ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
          if [[ -z $ATOMIC_NUMBER ]]
          then
            echo "I could not find that element in the database."
            exit
          fi
          ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
          MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
          BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
          NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
          TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
          TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
          SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER")

          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
          else
            echo "I could not find that element in the database."
      fi
    fi
  fi
  
else
  echo "Please provide an element as an argument."
fi