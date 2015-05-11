# !/bin/sh
NDK=/your/home/and/Android/android-ndk-r9d
SYSROOT=$NDK/platforms/android-9/arch-arm/
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.8/prebuilt/linux-x86_64
AR=$TOOLCHAIN/bin/arm-linux-androideabi-ar
LD=$TOOLCHAIN/bin/arm-linux-androideabi-ld.gold
CC=$TOOLCHAIN/bin/arm-linux-androideabi-gcc
CPP=$TOOLCHAIN/bin/arm-linux-androideabi-g++
AS=$TOOLCHAIN/bin/arm-linux-androideabi-gcc
RANLIB=$TOOLCHAIN/bin/arm-linux-androideabi-ranlib
STRIP=$TOOLCHAIN/bin/arm-linux-androideabi-strip
function build_one
{
./configure \
  --enable-pic \
  --enable-strip \
  --enable-static \
  --enable-shared \
  --cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
  --sysroot=$SYSROOT \
  --host=arm-linux-androideabi \
  --prefix=./build \
  --extra-cflags="-march=armv7-a -mtune=cortex-a8 -mfloat-abi=softfp -mfpu=neon -D__ARM_ARCH_7__ -D__ARM_ARCH_7A__"
make clean
make
make install
}
build_one
