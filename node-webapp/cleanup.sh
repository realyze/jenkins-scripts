#!/bin/bash
set -e
set -x

# Load common variables.
source common.sh

sudo chown -R jenkins-slave:jenkins-slave ${WORKSPACE}

if [ `$DOCKER images | grep ${IMAGE_TAG}` -eq 0 ]; then
  # Remove the build image.
  $DOCKER rmi ${IMAGE_TAG_BUILD}
fi

# Remove the containers to free disk spaaace.
for cidfile in `ls ${CID_DIR}`; do
  $DOCKER rm `cat ${CID_DIR}/${cidfile}`
  rm -f ${CID_DIR}/${cidfile}
done

# Remove artifacts
rm -rf ${ARTIFACTS_DIR}
