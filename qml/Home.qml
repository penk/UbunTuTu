import QtQuick 2.0
import Process 1.0
import "colour.js" as Colour

Item {
    Component.onCompleted: {
        console.log('Home loaded')
        sic.start(applicationDirPath + '/utils/adb', ['shell', 'system-image-cli', '-i'])
    }
    Process {
        id: sic
        onReadyRead: {
            console.log('onReadyRead');
            systemImageCli.text += readAll();
            console.log(systemImageCli.text)
        }
    }

    Text {
        anchors {
            top: parent.top
            topMargin: 50
            horizontalCenter: parent.horizontalCenter
        }
        text: "System Information"
        font.pointSize: 20
    }

    TextEdit {
        id: systemImageCli
        anchors.centerIn: parent 
        font.pointSize: 16
        selectionColor: Colour.palette['Green']
    }
}
