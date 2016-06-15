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

    cd Process; qmake && make && make install; cd ..
    qmake && make 
    ./UbunTuTu

## Credits 

* `utils/convert` is a statically linked ImageMagick version 7.0.1-7 built with `png` delegate 
* `utils/adb` is ADB version 1.0.32 from Android SDK platform tool 

## License 

Copyright © 2016 Ping-Hsun (penk) Chen <<penkia@gmail.com>>

The source code is, unless otherwise specified, distributed under the terms of the MIT License.
