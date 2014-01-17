#!/bin/bash

########################################################################
##
## Copyright (C) 2013-2014 Alexander "Evisceration" Martinz
##
##  This program is free software: you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published by
##  the Free Software Foundation, either version 3 of the License, or
##  (at your option) any later version.
##
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.
##
##  You should have received a copy of the GNU General Public License
##  along with this program.  If not, see <http://www.gnu.org/licenses
##
########################################################################
#
# Change the variables here to your needs

# our array of repo names, which need to be merged
# TODO: needs to be in sync with android manifest
repos=( "development" "frameworks_av" "frameworks_native" "frameworks_opt_telephony" "hardware_broadcom_wlan" "hardware_qcom_audio-caf" "hardware_qcom_display-caf" "hardware_qcom_media-caf" "packages_apps_Browser" "packages_apps_Camera2" "packages_apps_DeskClock" "packages_apps_Dialer" "packages_apps_Gallery2" "packages_apps_InCallUI" "packages_apps_Mms" "packages_inputmethods_LatinIME" "packages_services_Telephony" "system_core" "system_media" )

# Save Username
username=$1
# Our root of the android source WITH trailing slash
rootdir=~/android/
# Save current directory
startdir=$(pwd)

# Delay each repo by the specified amount of seconds
# by default no delay
delay=0

# our branch and remote
branchname=android-4.4
remotename=nameless

# remote branch and remote
remotebranchname=cm-11.0
remoteremotename=cm

# our gerrit remote name <3
gerritremote=gerrit

# temporary branch
tmpbranchname=tmp

########################################################################
## Do not edit below this line !
## (of course only if you dont
##  plan to extend functionality)
########################################################################

# uploads changes to gerrit
function gerrit_upload()
{
	git push $gerritremote HEAD:refs/for/$branchname
}


########################################################################

# Check for right usage
if [ -z $1 ]; then
	printf "\nUsage: ${BASH_SOURCE[0]} username\n\n"
	printf "Example: ${BASH_SOURCE[0]} Evisceration\n\n"
	exit 1
fi

# Start our magic

printf "\n[!] Checking following repos:\n\n"
printf "[+] android_%s\n" "${repos[@]}"
printf "\n========================================\n\n"

for i in "${repos[@]}"
do
	# save and build remote name
	addremote=https://github.com/CyanogenMod/android_$i
	addgerritremote=ssh://$username@gerrit.nameless-rom.org:29418/android_$i
	# build the target dir
	i=$rootdir$(echo $i | tr "_" "/")
	# change directory, go into it
	cd $i
	# remove and add remote name
	git remote rm $remoteremotename
	git remote add $remoteremotename $addremote
	git remote rm $gerritremote
	git remote add $gerritremote $addgerritremote
	# checking out on a temporary branch and clean up
	git checkout --orphan $tmpbranchname
	git branch -D $branchname
	git branch -D $remotebranchname
	# fetching our branch
	git checkout -b $branchname
	git fetch $remotename $branchname
	git reset --hard $remotename/$branchname
	# fetch remote branch
	git checkout -b $remotebranchname
	git fetch $remoteremotename $remotebranchname
	git reset --hard $remoteremotename/$remotebranchname
	# rebase on our branch
	git rebase $branchname
	# checkout our branch and merge
	git checkout $branchname
	git merge $remotebranchname
	# upload that shit for review
	gerrit_upload
	# Abort rebase, just in case ...
	git rebase --abort
	# Cleaning up the branch again
	git reset --hard $remotename/$branchname
	# relax a bit and get some space
	printf "\n\n"
	sleep $delay
done

# go back to where we started ;)
cd $startdir

########################################################################
# EOF
