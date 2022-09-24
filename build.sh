export ROOT_DIR=$(pwd)
export KERNEL_OUT_DIR=$ROOT_DIR/linux/arch/arm/boot
export UBOOT_OUT_DIR=$ROOT_DIR/u-boot/
export CROSS_COMPILE=$ROOT_DIR/toolchain/bin/arm-none-linux-gnueabihf-
export ARCH=arm

echo "###########################################"
echo "---------- Building U-Boot ----------------"
echo "###########################################"
cd $ROOT_DIR/u-boot
make am335x_evm_defconfig
make -j4
echo "###########################################"
echo "---------- Building Kernel ----------------"
echo "###########################################"
cd $ROOT_DIR/linux
make -j4 omap2plus_defconfig
make -j4 zImage modules dtbs
echo "###########################################"
echo "---------- Creating FIT image -------------"
echo "###########################################"
cd $ROOT_DIR
./$ROOT_DIR/u-boot/tools/mkimage -f bbb_fit_img_source.its bbb_fit_img_blob.itb
