#!/bin/sh
LINUX4SAM_RELEASE="linux4sam_v6.0-rc1"
BUILD_DIR="/ssd2/ldesroches/builds/buildroot/"
DL_DIR="/ssd2/ldesroches/buildroot/dl"
EXTERNAL_DIR="/ssd2/ldesroches/buildroot-external-microchip"

echo "--------------------------------------------------------------------------------"
echo "LINUX4SAM_RELEASE: $LINUX4SAM_RELEASE"
echo "BUILD_DIR: $BUILD_DIR"
echo "DL_DIR: $DL_DIR"
echo "EXTERNAL_DIR: $EXTERNAL_DIR"
echo "--------------------------------------------------------------------------------"

#Create build directory if needed
if [ ! -d "$BUILD_DIR" ]; then
	echo "create ${BUILD_DIR}/${LINUX4SAM_RELEASE}"
	mkdir ${BUILD_DIR}/${LINUX4SAM_RELEASE}
fi

export BR2_EXTERNAL="${EXTERNAL_DIR}/"

for f in ${EXTERNAL_DIR}/configs/*; do
	DEFCONFIG=$(basename $f)
	OUTPUT_DIR="${BUILD_DIR}/${LINUX4SAM_RELEASE}/$DEFCONFIG"
	echo "================================================================================"
	echo "build $DEFCONFIG in $OUTPUT_DIR"
	echo "================================================================================"
	mkdir $OUTPUT_DIR
	make O=$OUTPUT_DIR $DEFCONFIG
	echo "BR2_DL_DIR=\"$DL_DIR\"" >> $OUTPUT_DIR/.config
	make O=$OUTPUT_DIR
done
