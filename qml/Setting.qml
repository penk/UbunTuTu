import QtQuick 2.0
import Process 1.0
import "colour.js" as Colour
import QtQuick.Dialogs 1.2

Item {
    Component.onCompleted: {
        console.log('Setting loaded')
    }

    Row {
        spacing: 50
        id: button
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 150
        }

        Rectangle {
            id: importButton
            width: 200
            height: 50
            radius: 5
            color: Colour.palette['Green']
            Text {
                anchors.centerIn: parent
                text: 'Import Contacts'
                color: 'white'
                font.bold: true
                font.pointSize: 14
            }
            MouseArea {
                anchors.fill: parent
                onClicked: fileDialog.visible = true;
            }
        }

        Rectangle {
            id: exportButton
            width: 200
            height: 50
            radius: 5
            color: Colour.palette['Silk']
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: 'Export Contacts'
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
                onClicked: dirDialog.visible = true;
            }
        }
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a contact file"
        folder: shortcuts.documents
        //selectMultiple: false
        //selectFolder: false
        //selectFolder: fileDialogSelectFolder.checked
        //nameFilters: [ "Contacts file (*.vcf)" ]
        //selectedNameFilter: "All files (*)"
        selectFolder: fileDialogSelectFolder.checked
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
            shell.start(applicationDirPath + '/utils/contacts.sh', [ applicationDirPath, fileDialog.fileUrls.toString().replace(/file:\/\//, ""), "import" ])
        }
        onRejected: {
            console.log("Canceled")
        }
    }

    FileDialog {
        id: dirDialog
        title: "Please choose a directory"
        folder: shortcuts.home
        //selectMultiple: false
        //selectFolder: true
        onAccepted: {
            console.log("You chose: " + fileDialog.folder)
            shell.start(applicationDirPath + '/utils/contacts.sh', [ applicationDirPath, dirDialog.folder.toString().replace(/file:\/\//, ""), "export" ])
        }
        onRejected: {
            console.log("Canceled")
        }
    }

    Process {
        id: shell
        onReadyRead: {
            console.log('onReadyRead');
            var text = readAll()
            console.log(text)
            adbText.text = text
        }
    }

    Text {
        id: title
        anchors {
            top: parent.top
            topMargin: 50
            horizontalCenter: parent.horizontalCenter
        }
        text: "Import & export contacts"
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


