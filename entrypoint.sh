#!/bin/bash

cd "$2"

if [ "$1" = "clean" ]; then
    rm -rf ../"$2"
else
    mkdir output
    if [ "$1" = "xelatex" ]; then
        xelatex -interaction=nonstopmode -file-line-error "$3"
    elif [ "$1" = "bibtex" ]; then
        bibtex "$3"
    elif [ "$1" = "make" ]; then
        make "$3" -I /opt/template
    fi
    cp *.pdf output
fi