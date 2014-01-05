#!/bin/bash

# our array of repo names, which need to be merged
# TODO: needs to be in sync with android manifest
repos=( "frameworks_av" "frameworks_native" "packages_apps_Camera2" "packages_apps_DashClock" "packages_apps_Dialer" "packages_apps_Gallery2" "system_core" "system_media" )

# Our root of the android source WITH trailing slash
rootdir=~/android/

# Save current directory
startdir=$(pwd)

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

# uploads changes to gerrit
function gerrit_upload()
{
	git push $gerritremote HEAD:refs/for/$branchname
}


#############################

# Start our magic

printf "\n[!] Checking following repos:\n\n"
printf "[+] android_%s\n" "${repos[@]}"
printf "\n========================================\n\n"

for i in "${repos[@]}"
do
	# build the target dir
	i=$rootdir$(echo $i | tr "_" "/")
	# change directory, go into it
	cd $i
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
done

# go back to where we started ;)
cd $startdir