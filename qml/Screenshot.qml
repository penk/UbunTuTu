import QtQuick 2.0
import Process 1.0
import "colour.js" as Colour

Item {
    Component.onCompleted: {
        console.log('Screenshot loaded')
    }

    Rectangle {
        id: button
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 70
        }
        width: 300
        height: 50
        radius: 5
        color: Colour.palette['Green']
        Text {
            anchors.centerIn: parent
            text: 'Grab a Screenshot'
            color: 'white'
            font.bold: true
            font.pointSize: 14
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                screenpath.text = 'Waiting..' 
                shell.start(applicationDirPath + '/utils/screenshot.sh', [ applicationDirPath ]);
            }
        }
    }

    Process {
        id: shell 
        onReadyRead: {
            console.log('onReadyRead');
            var path = readAll();
            console.log('Path: ' + path)
            if (path.toString() !== "")
                screenpath.text = 'file://' + path.toString().replace(/(?:\r\n|\r|\n)/g, '')

            img.source = 'file://' + path.toString().replace(/(?:\r\n|\r|\n)/g, '');
        }
    }

    TextEdit {
        id: screenpath
        anchors {
            top: img.bottom
            bottom: button.top
        }
        width: parent.width
        horizontalAlignment: TextEdit.AlignHCenter
        font.pointSize: 16
        selectionColor: Colour.palette['Green']
    }

    Image {
        id: img
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            margins: 15
        }
        fillMode: Image.PreserveAspectFit 
        width: 250
    }
}
