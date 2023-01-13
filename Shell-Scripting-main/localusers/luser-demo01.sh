#!/bin/bash

# This script displays various information to the screen.

# Display the text 'hello'
echo 'Hello'

# Assign a value to the variable
WORD='script'

# Display that value using the variable.
echo "$WORD"

# Single quotes prevents the expansion
# Demonstrate that single quotes cause variables to NOT get expanded
echo '$WORD'

# Combine the variable with hard-coded text.
echo "This is a shell $WORD"

# Display the contents of the variable using an alternative syntax.
echo "This is a shell ${WORD}"

# Append text to the variable.
echo "${WORD}ing is fun!"

# Show how NOT to append text to a variable
echo "$WORDing is fun!"

# Create a new variable
ENDING='ed'

# Combining the two variables.
echo "This is ${WORD}${ENDING}."

# Change the value stored in the ENDING variable. (Reassignment)
ENDING='ing'
echo "${WORD}${ENDING} is fun"

# Reassignment value to ENDING.
ENDING='s'
echo "You are going to write many ${WORD}${ENDING} in this class!"
