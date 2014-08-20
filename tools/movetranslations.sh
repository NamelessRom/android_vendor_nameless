#!/bin/bash
###########################################################################
if [ -z $1 ]; then
    echo "usage: movetranslations.sh BRANCH_NAME"
    exit
fi
###########################################################################
branch_name=$1
###########################################################################
root=$(pwd)
base="/android"
languages=("af" "ar" "ca" "cs" "da" "de" "el" "es-ES" "fa" "fi" "fr" "hi" "hu" "it" "ja" "ko" "nl" "no"     "pl" "pt-BR"  "ro" "ru" "sr" "sv-SE"  "th" "tr" "uk" "vi" "zh-CN"  "zh-HK"  "zh-TW")
values=(   "af" "ar" "ca" "cs" "da" "de" "el" "es"    "fa" "fi" "fr" "hi" "hu" "it" "ja" "ko" "nl" "nb-rNO" "pl" "pt-rBR" "ro" "ru" "sr" "sv-rSE" "th" "tr" "uk" "vi" "zh-rCN" "zh-rHK" "zh-rTW")
###########################################################################
core=${base}/frameworks/base/core/res/res/values
devicecontrol=${base}/packages/apps/DeviceControl/resources/src/main/res/values
settings=${base}/packages/apps/Settings/res/values
systemui=${base}/frameworks/base/packages/SystemUI/res/values
namelesscenter=${base}/packages/apps/NamelessCenter/app/src/main/res/values
namelessprovider=${base}/packages/providers/NamelessProvider/app/src/main/res/values
namelesssetupwizard=${base}/packages/apps/NamelessSetupWizard/app/src/main/res/values
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
    echo "${languages[$i]}: [NamelessCenter]"
    mkdir -p ${namelesscenter}-${values[$i]}/
    cp ${languages[$i]}/NamelessCenter/*.xml ${namelesscenter}-${values[$i]}/
    #######################################################################
    echo "${languages[$i]}: [NamelessProvider]"
    mkdir -p ${namelessprovider}-${values[$i]}/
    cp ${languages[$i]}/NamelessProvider/*.xml ${namelessprovider}-${values[$i]}/
    #######################################################################
    echo "${languages[$i]}: [NamelessSetupWizard]"
    mkdir -p ${namelesssetupwizard}-${values[$i]}/
    cp ${languages[$i]}/NamelessSetupWizard/*.xml ${namelesssetupwizard}-${values[$i]}/
    #######################################################################
done
###########################################################################
cd ${base}/frameworks/base/
git add core/res/res/
git add packages/SystemUI/res/
git commit -m "automatic translation import"
gerritupload ${branch_name}
###########################################################################
cd ${base}/packages/apps/DeviceControl/
git add resources/src/main/res/
git commit -m "automatic translation import"
gerritupload ${branch_name}
###########################################################################
cd ${base}/packages/apps/Settings/
git add res/
git commit -m "automatic translation import"
gerritupload ${branch_name}
###########################################################################
cd ${base}/packages/apps/NamelessCenter/
git add app/src/main/res/
git commit -m "automatic translation import"
gerritupload ${branch_name}
###########################################################################
cd ${base}/packages/apps/NamelessSetupWizard/
git add app/src/main/res/
git commit -m "automatic translation import"
gerritupload ${branch_name}
###########################################################################
cd ${base}/packages/providers/NamelessProvider/
git add app/src/main/res/
git commit -m "automatic translation import"
gerritupload ${branch_name}
###########################################################################
cd "${root}"
echo "DONE"
###########################################################################
