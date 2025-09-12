#!/bin/bash

# Script used to find and replace string occurences inside files in directory recursively

usage() {
  echo "Usage: ${0} FIND REPLACE DIR"
  exit 1
}

# If user doesn't supply three arguments, then give them help
NUMBER_OF_PARAMETERS="${#}"
if [[ "${NUMBER_OF_PARAMETERS}" -ne 3 ]]
then
  usage
fi

FIND="${1}"
REPLACE="${2}"
DIR="${3}"

# Check if $DIR exists
if [[ ! -d "${DIR}" ]]; then
  echo "${DIR} does not exist" >&2
  exit 1
fi

# Recursivly search for files containing find string
grep -rl "${FIND}" "${DIR}" | while read -r FILE; do
  sed -i -e "s/${FIND}/${REPLACE}/g" "${FILE}"

  # Check if string was successfully replaced
  if [[ "${?}" -ne 0 ]]; then
    echo "Could not replace string '${FIND}' with '${REPLACE}' in ${FILE}" >&2
  else
    echo "Successfully replaced string '${FIND}' with '${REPLACE}' in ${FILE}"
  fi
done
