#!/bin/bash
###########################################################################
if [ -z $1 ]; then
    echo "usage: movetranslations.sh USERNAME"
    exit
fi
###########################################################################
username=$1
###########################################################################
root=$(pwd)
base="/android"
languages=("ca" "de" "es-ES" "fr" "it" "nl" "pl" "pt-BR" "ru" "tr")
values=("ca" "de" "es" "fr" "it" "nl" "pl" "pt-rBR" "ru" "tr")
###########################################################################
core=${base}/frameworks/base/core/res/res/values
devicecontrol=${base}/packages/apps/DeviceControl/app/src/main/res/values
settings=${base}/packages/apps/Settings/res/values
systemui=${base}/frameworks/base/packages/SystemUI/res/values
updatecenter=${base}/packages/apps/UpdateCenter/src/main/res/values
###########################################################################
. ${base}/build/envsetup.sh
###########################################################################
for i in ${!languages[*]}; do
    #######################################################################
    echo "${languages[$i]}: [core]"
    mkdir -p ${core}-${values[$i]}/
    cp ${languages[$i]}/core/*.xml ${core}-${values[$i]}/
    #######################################################################
    echo "${languages[$i]}: [DeviceControl]"
    mkdir -p ${devicecontrol}-${values[$i]}/
    cp ${languages[$i]}/DeviceControl/*.xml ${devicecontrol}-${values[$i]}/
    #######################################################################
    echo "${languages[$i]}: [Settings]"
    mkdir -p ${settings}-${values[$i]}/
    cp ${languages[$i]}/Settings/*.xml ${settings}-${values[$i]}/
    #######################################################################
    echo "${languages[$i]}: [SystemUI]"
    mkdir -p ${systemui}-${values[$i]}/
    cp ${languages[$i]}/SystemUI/*.xml ${systemui}-${values[$i]}/
    #######################################################################
    echo "${languages[$i]}: [UpdateCenter]"
    mkdir -p ${updatecenter}-${values[$i]}/
    cp ${languages[$i]}/UpdateCenter/*.xml ${updatecenter}-${values[$i]}/
    #######################################################################
done
###########################################################################
cd ${base}/frameworks/base/
git add core/res/res/
git add packages/SystemUI/res/
git commit -m "automatic translation import"
gerritupload ${username}
###########################################################################
cd ${base}/packages/apps/DeviceControl/
git add app/src/main/res/
git commit -m "automatic translation import"
gerritupload ${username}
###########################################################################
cd ${base}/packages/apps/Settings/
git add res/
git commit -m "automatic translation import"
gerritupload ${username}
###########################################################################
cd ${base}/packages/apps/UpdateCenter/
git add src/main/res/
git commit -m "automatic translation import"
gerritupload ${username}
###########################################################################
cd "${root}"
echo "DONE"
###########################################################################