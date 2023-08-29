#!/bin/bash

cd "$2"

if [ "$1" = "clean" ]; then
    rm -rf ../"$2"
else
    mkdir -p /data/"$2"/output
fi
if [ "$1" = "xelatex" ]; then
    xelatex -synctex=1 -interaction=nonstopmode -output-directory=/data/"$2" -file-line-error "$3"
    cp *.pdf /data/"$2"/output
elif [ "$1" = "bibtex" ]; then
    bibtex "$3"
fi
