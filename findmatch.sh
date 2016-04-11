#!/bin/bash

# this script recursively finds text files, and then finds a pattern match in
# those text files
# $1 is the search pattern
# $2 is the directory that we're starting from
# syntax - ./findmatch.sh pattern /directory

for OUTPUT in $(find $2 -type f -exec file {} + | grep ASCII | sed 's/:.*//')
do
        grep -H $1 $OUTPUT
done
