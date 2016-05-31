TEMPLATE = app
TARGET = UbunTuTu

QT += qml quick 
SOURCES += main.cpp

mac {
    UtilFiles.files = utils
    UtilFiles.path = Contents/MacOS
    QMAKE_BUNDLE_DATA += UtilFiles

    QMLFiles.files = qml
    QMLFiles.path = Contents/MacOS
    QMAKE_BUNDLE_DATA += QMLFiles

    ICON = Ubuntutu.icns
}
