#!/bin/bash

SDK_VER=23
CUSTOM_VER=23
CUSTOM_NAME=nameless

if [ -z "$OUT" ]; then
    echo "Please lunch a product before using this command"
    exit 1
else
    OUTDIR=${OUT%/*/*/*}
fi

STUBJAR=${OUTDIR}/target/common/obj/JAVA_LIBRARIES/android_stubs_current_intermediates/classes.jar
FRAMEWORKJAR=${OUTDIR}/target/common/obj/JAVA_LIBRARIES/framework_intermediates/classes.jar
TELEPHONYJAR=${OUTDIR}/target/common/obj/JAVA_LIBRARIES/telephony-common_intermediates/classes.jar
COMMONJAR=${OUTDIR}/target/common/obj/JAVA_LIBRARIES/android-common_intermediates/classes.jar
CORESERVICESJAR=${OUTDIR}/target/common/obj/JAVA_LIBRARIES/services_intermediates/classes.jar
SERVICESJAR=${OUTDIR}/target/common/obj/JAVA_LIBRARIES/com.android.services.telephony.common_intermediates/classes.jar
OKHTTPJAR=${OUTDIR}/target/common/obj/JAVA_LIBRARIES/okhttp_intermediates/classes.jar

if [ ! -f $STUBJAR ]; then
make $STUBJAR
fi
if [ ! -f $FRAMEWORKJAR ]; then
make $FRAMEWORKJAR
fi
if [ ! -f $TELEPHONYJAR ]; then
make $TELEPHONYJAR
fi
if [ ! -f $COMMONJAR ]; then
make $COMMONJAR
fi
if [ ! -f $CORESERVICESJAR ]; then
make $CORESERVICESJAR
fi
if [ ! -f $SERVICESJAR ]; then
make $SERVICESJAR
fi
if [ ! -f $OKHTTPJAR ]; then
make $OKHTTPJAR
fi

TMP_DIR=${OUTDIR}/tmp
mkdir -p ${TMP_DIR}
$(cd ${TMP_DIR}; jar -xf ${STUBJAR})
$(cd ${TMP_DIR}; jar -xf ${FRAMEWORKJAR})
$(cd ${TMP_DIR}; jar -xf ${TELEPHONYJAR})
$(cd ${TMP_DIR}; jar -xf ${COMMONJAR})
$(cd ${TMP_DIR}; jar -xf ${CORESERVICESJAR})
$(cd ${TMP_DIR}; jar -xf ${SERVICESJAR})
$(cd ${TMP_DIR}; jar -xf ${OKHTTPJAR})

jar -cf ${OUTDIR}/android.jar -C ${TMP_DIR}/ .

echo "android.jar created at ${OUTDIR}/android.jar"
echo "Now attempting to create new sdk platform with it"

if [ -z "$ANDROID_HOME" ]; then
    ANDROID=$(command -v android)
    ANDROID_HOME="${ANDROID%/*}"
    if [ -z "$ANDROID_HOME" ]; then
        echo "ANDROID_HOME variable is not set. Do you have the sdk installed ?"
        exit 1
    fi
fi

cp -rf "${ANDROID_HOME}/platforms/android-${SDK_VER}" "${ANDROID_HOME}/platforms/android-${CUSTOM_VER}-${CUSTOM_NAME}"
rm -f "${ANDROID_HOME}/platforms/android-${CUSTOM_VER}-${CUSTOM_NAME}/android.jar"
cp -f "${OUTDIR}/android.jar" "${ANDROID_HOME}/platforms/android-${CUSTOM_VER}-${CUSTOM_NAME}/android.jar"
sed -i 's/^ro\.build\.version\.sdk=.*/ro.build.version.sdk='${CUSTOM_VER}'/g' "${ANDROID_HOME}/platforms/android-${CUSTOM_VER}-${CUSTOM_NAME}/build.prop"
sed -i 's/^ro\.build\.version\.release=.*/ro.build.version.release='${CUSTOM_VER}'/g' "${ANDROID_HOME}/platforms/android-${CUSTOM_VER}-${CUSTOM_NAME}/build.prop"
sed -i 's/AndroidVersion\.ApiLevel='${SDK_VER}'/AndroidVersion\.ApiLevel='${CUSTOM_VER}'/' "${ANDROID_HOME}/platforms/android-${CUSTOM_VER}-${CUSTOM_NAME}/source.properties"
echo "New SDK created. To build using ${CUSTOM_NAME} sdk select sdk version ${CUSTOM_VER} in Android Studio/ADT"
