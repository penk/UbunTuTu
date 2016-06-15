# UbunTuTu - ADB for Human Beings

UbunTuTu is a graphical replacement of adb command for Ubuntu Phone

![screenshot](https://raw.githubusercontent.com/penk/UbunTuTu/master/images/screenshot.png)

## Features

* Get system image version
* Install click package
* Grab screenshot
* Fetch log
* Import & export contacts

## Build

On Linux:

    cd Process; qmake && make && sudo make install; cd ..
    qmake && make
    ./UbunTuTu

On OS X:

    cd Process; qmake && make && make install; cd ..
    qmake && make
    macdeployqt UbunTuTu.app -qmldir=qml/ -verbose=1

## Credits

* `utils/mac/adb` is ADB version 1.0.32 from Android SDK platform tool
* `utils/mac/convert` is a statically linked ImageMagick version 7.0.1-7 built with `png` delegate
* `utils/linux/adb` is ADB version 1.0.32 from Android SDK platform tool
* `utils/linux/convert` is a soft link to /usr/bin/convert

## License

Copyright © 2016 Ping-Hsun (penk) Chen <<penkia@gmail.com>>

The source code is, unless otherwise specified, distributed under the terms of the MIT License.
