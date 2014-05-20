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

if [ -z $1 ]; then
    echo "Usage: ${BASH_SOURCE[0]} output.zip [/path/to/output/folder/] [-v]"
    exit 1
fi

rdir=`pwd`
if [[ $2 == "./" ]]; then
    ddir=$rdir
else
    ddir=$2
fi
if [[ -z $2 ]] || [[ $2 == "-v" ]]; then
    outputfile=$1.changelog
else
    outputfile=$ddir/$1.changelog
fi

# Clean outputfile
rm -f $outputfile

#Header
echo '<?xml version="1.0" encoding="utf-8"?>' >> $outputfile
echo '<changelog bulletedList="true">' >> $outputfile

# Find the directories to log
find $rdir -path $rdir/.repo -prune -o -name .git -print | sed 's/\/.git//g' | sed 'N;$!P;$!D;$d' | while read line
do
    cd $line
    # Test to see if the repo needs to have a changelog written.
    log=$(git log --pretty="%s" --no-merges --since="yesterday 02:00:00" --date-order)
    project=$(git remote -v | head -n1 | awk '{print $2}' | sed 's/.*\///' | sed 's/\.git//')
    if [ -z "$log" ]; then
        if [[ $2 == "-v" ]] || [[ $3 == "-v" ]]; then
            printf "\033[31m[-] Nothing updated on $project, skipping\033[0m\n"
        fi
    else
        printf "\033[32m[+] Writing changes for $project\033[0m\n"

        # Write the changelog
        echo '<changelogversion versionName="'${project}'">' >> $outputfile
        echo "$log" | while read line
        do
            echo '    <changelogtext><![CDATA['$line']]></changelogtext>' >> $outputfile
        done
        echo "</changelogversion>" >> $outputfile
    fi
done

#Footer
echo '</changelog>' >> $outputfile

exit 0

