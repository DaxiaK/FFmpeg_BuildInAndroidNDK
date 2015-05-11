

============================================================
============================================================
============================================================
====                                          ==============
==== ffmpeg-2.2.2 include libx264 ,configure  ==============
==== for cross compile with AndroidNDK-r9d    ==============
==== Jim Kuo @201406                          ==============
====                                          ==============
============================================================
============================================================
============================================================



A. File Overview

|
|-  ReadMe
|
|-  ffmpeg-2.2.2
|     |
|     |- x264 
|     |
|     |- ffserver.conf
|

============================================================
============================================================

B. How to use this project?


1.BUILD X264 (Optional)

1.1 cd /your/ffmpeg+x264/directory/

1.2 cd x264

1.3 open build_x264.sh with vi or gedit

1.4 change  NDK=/your/NDK/directory

1.5 change SYSROOT/TOOLCHAIN if you will build it on different android version or arm-linux-androideabi version
    (**Warning: if you change it , maybe bring about unexpected error )

1.6 save build_x264.sh and chmod 777 build_x264.sh 

1.7 run build_x264.sh , and wait a moment
    
1.8 when it finish ,you will looking for that it creat a new folder "build" under the "x264" folder

1.9 if you hope  useing libx264 codec on android in ffmpeg binary , you will  copy x264/build/lib/libx264.so.142 to android , Path on android is: /system/lib/

+++++++++++++++++++
+++++++++++++++++++

2.BUILD FFMPEG

2.1 cd /your/ffmpeg+x264/directory/

2.2 open build_android.sh with vi or gedit

2.3 change NDK=/your/NDK/directory

2.4 change SYSROOT/TOOLCHAIN if you will build it on different android version or arm-linux-androideabi version
    (**Warning: if you change it , maybe bring about unexpected error )

2.5 follow your want , change configure option !
    this step are important , it will affect what fuinction you can use on ffmpeg binary!  
    (Ex.--enable-shared \ -> --disable-shared \)

2.6 if you will compile libx264 and want using it , revise that:

    --extra-cflags="-I/your/path/ffmpeg-2.2.2/x264/build/include/ -Os -fpic $ADDI_CFLAGS " \
    --extra-ldflags="-L/your/path/ffmpeg-2.2.2/x264/build/lib/ $ADDI_LDFLAGS " \
 
    /your/path/ffmpeg-2.2.2/ -> /your/ffmpeg+x264/directory/
    
    if you don't use libx264 , pleas delete taht:

    -I/your/path/ffmpeg-2.2.2/x264/build/include/
    -L/your/path/ffmpeg-2.2.2/x264/build/lib/

2.7 save build_android.sh and chmod 777 build_x264.sh 

2.8 run build_android.sh , and wait a moment

2.9 when it finish , your will looking for that it creat a new folder "android" under the "ffmpeg-2.2.2" folder

2.10 Now, copy android/arm/bin/ to android , Path on android is: /system/bin/

2.11 copy the "real" .so file in android/arm/lib/ to android ,  Path on android is: /system/lib/
     the real .so file has named with number Ex. libavcodec-55.so 
     the symbol .so file has named wiht no number Ex.  libavcodec.so 
     (**note : Don't copy other file except real .so  , it maybe bring about unexpected error)
 
+++++++++++++++++++
+++++++++++++++++++

3.CHECK YOUR FFMPEG & X264 CAN WORK

3.1 adb shell your devices

3.2 key this cmd: "ffmpeg"

3.3 if you find your screen show some info , it means successful ,  like:

ffmpeg version 2.2.2 Copyright (c) 2000-2014 the FFmpeg developers
  built on Jun 11 2014 13:17:13 with gcc 4.8 (GCC)
  configuration: --prefix=/your/path/ffmpeg-2.2.2/android/arm --enable-shared --enable-static --enable-doc --enable-gpl --enable-libx264 --enable-pthreads --enable-ffmpeg --enable-ffplay --enable-ffprobe --enable-ffserver --enable-avdevice --enable-doc --enable-symver --enable-network --enable-debug --enable-protocol=tcp --enable-demuxer=rtsp --enable-cross-compile --cross-prefix=/your/path/Android/android-ndk-r9d/toolchains/arm-linux-androideabi-4.8/prebuilt/linux-x86_64/bin/arm-linux-androideabi- --target-os=linux --arch=arm --enable-cross-compile --sysroot=/your/path/Android/android-ndk-r9d/platforms/android-9/arch-arm/ --extra-cflags='-I/your/path/ffmpeg-2.2.2/x264/build/include/ -Os -fpic -marm ' --extra-ldflags='-L/your/path/ffmpeg-2.2.2/x264/build/lib/ '
  libavutil      52. 66.100 / 52. 66.100
  libavcodec     55. 52.102 / 55. 52.102
  libavformat    55. 33.100 / 55. 33.100
  libavdevice    55. 10.100 / 55. 10.100
  libavfilter     4.  2.100 /  4.  2.100
  libswscale      2.  5.102 /  2.  5.102
  libswresample   0. 18.100 /  0. 18.100
  libpostproc    52.  3.100 / 52.  3.100
Hyper fast Audio and Video encoder
usage: ffmpeg [options] [[infile options] -i infile]... {[outfile options] outfile}...



.................
.......
....


============================================================
============================================================

C.how to analyze ffmpeg info:

if you compile ffmpeg many  time , you will analyze how to check your version!

adb shell your devices and key "ffmpeg" , you will get some info like B-3.3.
now we see it:


1.
ffmpeg version 2.2.2  : your ffmpeg version

2.
built on Jun 11 2014 13:17:13 with gcc 4.8 (GCC)
         ￣￣￣￣￣￣￣￣￣￣￣     ￣￣￣￣￣￣
         you campile ffmpeg time        gcc version

3.
 configuration: --prefix=/your/path/ffmpeg-2.2.2/android/arm --enable-shared --enable-static --enable-doc --enable-gpl --enable-libx264 --enable-pthreads --enable-ffmpeg --enable-ffplay --enable-ffprobe --enable-ffserver --enable-avdevice --enable-doc --enable-symver --enable-network --enable-debug --enable-protocol=tcp --enable-demuxer=rtsp --enable-cross-compile --cross-prefix=/your/path/Android/android-ndk-r9d/toolchains/arm-linux-androideabi-4.8/prebuilt/linux-x86_64/.....................................
 

they are your configure , you can check what option you enable or disable in it!


============================================================
============================================================

D.ffserver

if your enable ffserver, you can use ffserver on android!
if you will use it,you will prepare ffserver.conf on android ,  Path on android is: /etc/

refence:http://ffmpeg.org/sample.html

start ffserver cmd is:
ffserver

and if you hope use real time stream, your will key :

ffserver &
ffmpeg -i input http://localhost:port/feedname


============================================================
============================================================

E.common command line

ffmpeg:

-i  :input
-re :copy intput file fps 
-vcodec copy :copy video copy
-acodec copy :copy audio copy
-loglever debug : show debug info


ffserver :

-d :show debug info

If your will find more command ,please follow ffmpeg.org:
https://www.ffmpeg.org/

============================================================
============================================================


F.Postscript

Known Issues
1.RTSP I/O 會顯示需要 pthread support , 但已經包入ffmpeg中卻仍顯示沒有support
2.http input realtim 會沒反應, 顯示200訪問成功 ,但connection=close
3.ffmpeg 輸入 .avi .flv 格式的時候會沒反應
4.ffserver real time 如果codec全部都copy 需要加上-re 否則會出錯,但再輸出成feed1.ffm時 嘗試訪問會顯示 coedec不相同的issues
































