#!/bin/bash
NDK=/your/home/and/Android/android-ndk-r9d
SYSROOT=$NDK/platforms/android-9/arch-arm/
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.8/prebuilt/linux-x86_64
function build_one
{
./configure \
    --prefix=$PREFIX \
    --enable-shared \
    --enable-static \
    --enable-doc \
    --enable-gpl \
    --enable-libx264 \
    --enable-pthreads \
    --enable-ffmpeg \
    --enable-ffplay \
    --enable-ffprobe \
    --enable-ffserver \
    --enable-avdevice \
    --enable-doc \
    --enable-symver \
    --enable-network \
--enable-debug \
    --enable-protocol=tcp \
    --enable-demuxer=rtsp \
    --enable-cross-compile \
    --cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
    --target-os=linux \
    --arch=arm \
    --enable-cross-compile \
    --sysroot=$SYSROOT \
    --extra-cflags="-I/home/kuo/ffmpeg-2.2.2/x264/build/include/ -Os -fpic $ADDI_CFLAGS " \
    --extra-ldflags="-L/home/kuo/ffmpeg-2.2.2/x264/build/lib/ $ADDI_LDFLAGS " \
    $ADDITIONAL_CONFIGURE_FLAG
make clean
make
make install
}
CPU=arm
PREFIX=$(pwd)/android/$CPU 
ADDI_CFLAGS="-marm"
build_one
