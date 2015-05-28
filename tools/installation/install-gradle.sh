#!/bin/bash

function usage()
{
  echo "Usage: ./install-gradle.sh /path/for/installation"
  echo "Example: ./install-gradle.sh /opt/gradle"
}

if [ -z ${1} ] || [ ${1} == "-h" ]; then
  usage;
  exit 1;
fi

INSTALL_PATH=${1}
BASE_DIR=`pwd`

echo "Installing gradle to "${INSTALL_PATH}
echo -e

echo "Creating folder ..."
mkdir -p ${INSTALL_PATH}
cd ${INSTALL_PATH}
echo -e

echo "Downloading gradle 2.4 ..."
rm -f ${INSTALL_PATH}/gradle-2.4-all.zip &> /dev/null
wget https://services.gradle.org/distributions/gradle-2.4-all.zip
echo -e

echo "Unzipping gradle ..."
unzip gradle-2.4-all.zip
echo -e

cd ${BASE_DIR}
echo "Do not forget to add "${INSTALL_PATH}"/gradle-2.4/bin to your system path!"
exit 0
