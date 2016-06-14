import QtQuick 2.0
import Process 1.0
import "colour.js" as Colour

Item {

    Component.onCompleted: {
        console.log('Log loaded')
        shell.start(applicationDirPath + '/utils/adb', ['shell', 'tail', '-f', '/home/phablet/.cache/upstart/scope-registry.log'])
    }
    Process {
        id: shell
        onReadyRead: {
            log.text += readAll();
            flickable.contentY = log.contentHeight - parent.height + 100
            console.log(log.text)
        }
    }

    Text {
        id: title
        anchors {
            top: parent.top
            topMargin: 50
            horizontalCenter: parent.horizontalCenter
        }
        text: "System Log"
        font.pointSize: 20
    }

    Flickable {
        id: flickable
        anchors {
            top: title.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 30
        }
        clip: true
        contentHeight: log.contentHeight

        TextEdit {
            id: log
            anchors {
                margins: 30
            }
            width: parent.width
            font.pointSize: 16
            selectionColor: Colour.palette['Green']
            wrapMode: TextEdit.WordWrap
            cursorPosition: log.text.length
        }
    }
}
