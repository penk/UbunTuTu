import QtQuick 2.0
import Process 1.0

Rectangle {

    Process {
        id: process
        onReadyRead: { 
            text.text += readAll();
            console.log('onReadyRead: ' + text.text);
        }
    }

    width: 300
    height: 400

    Text {
        id: text
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        onClicked: { 
            console.log('clicked')
            process.start("ping", [ "-c 3", "google.com" ]);
        }
    }
}
