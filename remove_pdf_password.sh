#!/usr/bin/env bash

password=$1

# Get password from command line
if [[ -n $password ]]; then
    echo "password passed on"
fi

# Ask user to a password
if [[ -z $password ]]; then
    read -p "What is the password of the PDF(s)?" password
fi

# Exit if user doesn't provide a password
if [[ -z $password ]];
then
    echo "no password provided, exiting..."
    exit 1
fi

echo "starting..."

if ! command -v pdftops &> /dev/null
then
    echo "pdftops not found, exiting..."
    exit 1
fi

if ! command -v ps2pdf &> /dev/null
then
    echo "ps2pdf not found, exiting..."
    exit 1
fi

mkdir -p orig

for i in *.[pP][dD][fF]; do 
    pdftops -upw $password "$i"; 
    cp "$i" orig
    rm "$i"
done

for i in *.ps; do ps2pdf "$i";done
rm *.ps

echo "done!"
