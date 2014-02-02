#!/bin/bash

###########################################################################
##                                                                       ##
## Copyright (C) 2014 Kilian "Jumoog" von Pflugk                         ##
## Copyright (C) 2014 Alexander "Evisceration" Martinz                   ##
##                                                                       ##
##  This program is free software: you can redistribute it and/or modify ##
##  it under the terms of the GNU General Public License as published by ##
##  the Free Software Foundation, either version 3 of the License, or    ##
##  (at your option) any later version.                                  ##
##                                                                       ##
##  This program is distributed in the hope that it will be useful,      ##
##  but WITHOUT ANY WARRANTY; without even the implied warranty of       ##
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        ##
##  GNU General Public License for more details.                         ##
##                                                                       ##
##  You should have received a copy of the GNU General Public License    ##
##  along with this program.  If not, see <http://www.gnu.org/licenses   ##
##                                                                       ##
###########################################################################

if [ -z $1 ] || [ -z $2 ]; then
    echo "Usage: ${BASH_SOURCE[0]} output.zip /path/to/output/folder/ [-v]"
    exit 1
fi

if [ $BUILD_IS_JENKINS ] && [ "$BUILD_IS_JENKINS" -eq 1 ]; then
    sdate=`date --date '2 days ago' +"%m/%d/%Y"`
else
    sdate=`date --date yesterday +"%m/%d/%Y"`
fi
cdate=`date +"%m_%d_%Y"`
rdir=`pwd`
if [[ $2 == "./" ]]; then
    ddir=$rdir
else
    ddir=$2
fi
outputfile=$ddir/$1.changelog

# Find the directories to log
find $rdir -path $rdir/.repo -prune -o -name .git -print | sed 's/\/.git//g' | sed 'N;$!P;$!D;$d' | while read line
do
    cd $line
    # Test to see if the repo needs to have a changelog written.
    log=$(git log --pretty="%h - %an - %s" --no-merges --since=$sdate --date-order)
    project=$(git remote -v | head -n1 | awk '{print $2}' | sed 's/.*\///' | sed 's/\.git//')
    if [ -z "$log" ]; then
        if [[ $3 == "-v" ]]; then
            printf "\033[31m[-] Nothing updated on $project, skipping\033[0m\n"
        fi
    else
        printf "\033[32m[+] Writing changes for $project\033[0m\n"

        # Write the changelog
        echo "Project: $project" >> $outputfile
        echo "$log" | while read line
        do
             echo "  * $line" >> $outputfile
        done
        echo "" >> $outputfile
    fi
done

exit 0
