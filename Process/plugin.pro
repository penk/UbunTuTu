TEMPLATE = lib
CONFIG += qt plugin
QT += qml quick

DESTDIR = Process
TARGET  = qmlprocessplugin

SOURCES += plugin.cpp

lib.files = Process
lib.path = $$[QT_INSTALL_QML]
INSTALLS += lib
