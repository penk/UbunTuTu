import QtQuick 2.0
import Process 1.0
import "colour.js" as Colour
import QtQuick.Dialogs 1.2

Item {
    Component.onCompleted: {
        console.log('Screenshot loaded')
    }
    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.pictures
        selectMultiple: false
        selectFolder: true
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
        }
        onRejected: {
            console.log("Canceled")
        }
    }

Row { 
    spacing: 50
    id: button
    anchors {
        horizontalCenter: parent.horizontalCenter
        bottom: parent.bottom
        bottomMargin: 70
    }

    Rectangle {
        id: pathButton
        width: 200
        height: 50
        radius: 5
        color: Colour.palette['Silk']
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: 'Save to ' + fileDialog.folder.toString().replace(/.*\//, "")
            clip: true
            font.bold: true
            font.pointSize: 14
            width: parent.width - 30
            color: Colour.palette['Inkstone']
            elide: Text.ElideRight
        }
        Text {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 10
            text: '▾'
            color: Colour.palette['Inkstone']
            font.bold: true
            font.pointSize: 14
        }
        MouseArea {
            anchors.fill: parent
            onClicked: fileDialog.visible = true;
        }
    }
    
    Rectangle {
        id: grabButton
        width: 200
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
                shell.start(applicationDirPath + '/utils/screenshot.sh', [ applicationDirPath, fileDialog.folder.toString().replace(/file:\/\//, "") ]);
            }
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

    Rectangle { 
        anchors {
            top: button.bottom
            margins: 20
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        width: parent.width
        visible: screenpath.text !== ""
        color: Colour.palette['Silk']
        
        TextEdit {
            id: screenpath
            anchors.fill: parent
            anchors.margins: 8
            horizontalAlignment: TextEdit.AlignHCenter
            font.pointSize: 14
            selectionColor: Colour.palette['Green']
        }
    }

    Image {
        id: img
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            margins: 15
            topMargin: 25
        }
        fillMode: Image.PreserveAspectFit 
        width: 250
    }
}
