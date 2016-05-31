import QtQuick 2.0
import Process 1.0
import "colour.js" as Colour
import QtQuick.Dialogs 1.2

Item {
    Component.onCompleted: {
        console.log('Install loaded')
    }

    Rectangle {
        id: button
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: title.bottom
            topMargin: 100
        }
        width: 300
        height: 50
        radius: 5
        color: Colour.palette['Green']
        Text {
            anchors.centerIn: parent
            text: 'Browse...'
            color: 'white'
            font.bold: true
            font.pointSize: 14
        }
        MouseArea {
            anchors.fill: parent
            onClicked: fileDialog.visible = true
        }
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        selectMultiple: false
        selectFolder: false
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
            shell.start(applicationDirPath + '/utils/install.sh', [ applicationDirPath, fileDialog.fileUrls.toString().replace(/file:\/\//, "") ])
        }
        onRejected: {
            console.log("Canceled")
        }
        nameFilters: [ "Click package (*.click)"]
    }
    Process {
        id: shell 
        onReadyRead: {
            console.log('onReadyRead');
            adbText.text += readAll();
            console.log(adbText.text)
        }
    }

    Text {
        id: title
        anchors {
            top: parent.top
            topMargin: 50
            horizontalCenter: parent.horizontalCenter
        }
        text: "Choose a Package to Install"
        font.pointSize: 20
    }

    TextEdit {
        id: adbText
        clip: true
        anchors {
            right: parent.right
            top: button.bottom
            bottom: parent.bottom
            left: parent.left
            margins: 30
        }
        font.pointSize: 16
        selectionColor: Colour.palette['Green']
        wrapMode: TextEdit.WordWrap
    }
}
