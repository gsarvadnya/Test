#!/bin/bash
set -e

# Set up Python virtual environment and install dependencies
python3 -m venv venv
source venv/bin/activate

pip install --upgrade pip
pip install -r requirements_build.txt
pip install -r src/requirements.txt
pip install pycrypto

# Build the project
echo "Build CentOS package - RELEASE_VERSION=$RELEASE_VERSION"
export LINUX_PACKAGE="VMware-NSX-Migration-for-VMware-Cloud-Director-${RELEASE_VERSION}-Centos.tar.gz"
echo "LINUX_PACKAGE=$LINUX_PACKAGE"
python -m PyInstaller src/vcdNSXMigrator.spec
tar -czvf $LINUX_PACKAGE -C dist/ .

# Save the artifacts
mkdir -p /workspace/build
mv $LINUX_PACKAGE /workspace/build/