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

#set -x

rdir=$(pwd)
if [[ $2 == "./" ]]; then
    ddir=${rdir}
else
    ddir=${2}
fi
if [[ -z ${2} ]] || [[ ${2} == "-v" ]]; then
    outputfile=${1}.changelog
else
    outputfile=${ddir}/${1}.changelog
fi

tmpfile=${outputfile}.tmp

if [[ $(date +%u) -eq 7 ]] ; then
    targetdate="1 sunday 02:00:00 ago"
else
    targetdate="yesterday 02:00:00"
fi

changes_since='changes since '${targetdate}
update_name=$(echo ${1} | rev | cut -d/ -f1 | rev)
update_md5=$( cut -d ' ' -f 1 <<< $(md5sum ${1}))

# Clean outputfile
rm -f ${outputfile}
rm -f ${tmpfile}

# Head
echo -n '<!DOCTYPE html><head><meta charset="utf-8"><meta http-equiv="X-UA-Compatible" content="IE=edge"><title>NamelessRom - Changelog</title><meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"><link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css"></head>' >> ${outputfile}
# Body
echo -n '<body style="background:#f9f9f9;"><div class="container"><h1>NamelessRom&nbsp;<small>'${changes_since}'</small></h1><h4 style="padding-top:10px;padding-bottom:20px;">'${update_name}'&nbsp;<small>'${update_md5}'</small></h4><ul class="list-group">' >> ${outputfile}

# Find the directories to log
find ${rdir} -path ${rdir}/.repo -prune -o -name .git -print | sed 's/\/.git//g' | sed 'N;$!P;$!D;$d' | while read line
do
    cd ${line}
    # Test to see if the repo needs to have a changelog written.
    log=$(git log --no-merges --date-order --oneline --since="${targetdate}")
    project=$(git remote -v | head -n1 | awk '{print $2}' | sed 's/.*\///' | sed 's/\.git//')
    if [ -z "${log}" ]; then
        if [[ $2 == "-v" ]] || [[ $3 == "-v" ]]; then
            printf "\033[31m[-] Nothing updated on ${project}, skipping\033[0m\n"
        fi
    else
        printf "\033[32m[+] Writing changes for ${project}\033[0m\n"

        echo -n "0" > ${tmpfile}counter
        echo "$log" | while read line
        do
            change_count=$(cat ${tmpfile}counter)
            let change_count+=1
            splitted=' ' read -r change_id change_title <<< ${line}
            echo -n '<li class="'${project}'-content list-group-item hidden" style="background-color:#f7f7f9;margin-left:10px;"><a href="https://github.com/NamelessRom/'${project}'/commit/'${change_id}'" target="_blank"><b>'${change_id}'</b></a>&nbsp;-&nbsp;<em>'${change_title}'</em></li>' >> ${tmpfile}content
            echo -n ${change_count} > ${tmpfile}counter
        done

        change_count=$(cat ${tmpfile}counter)
        rm -f ${tmpfile}counter
        content=$(cat ${tmpfile}content)
        rm -f ${tmpfile}content

        echo -n '<li id="'${project}'-main" class="toggleable list-group-item show"><span class="badge">'${change_count}'</span><span class="caret"></span>&nbsp; '${project}'</li>' >> ${outputfile}
        echo -n ${content} >> ${outputfile}
    fi
done

# Finish it
echo -n '</ul></div><script type="text/javascript" src="/js/jquery.min.js"></script><script type="text/javascript" src="/js/main.js"></script></body></html>' >> ${outputfile}

exit 0
