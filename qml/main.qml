import QtQuick 2.0
import QtQuick.Window 2.0
import "colour.js" as Colour
import Process 1.0 

Window {

    title: "UbunTuTu - ADB for human beings"
    visible: true
    width: 800
    height: 600
    color: Colour.palette['Porcelain']

    Process {
        id: process
        onReadyRead: {
            var connectStatus = readAll();
            if (connectStatus.toString().match(/\tdevice/)) {
                connectIndicator.color = Colour.palette['Green']
                connectText.text = "Connected"
            }
        }
    }

    Component.onCompleted: {
        process.start(applicationDirPath + "/utils/adb", ["devices"]); 
        loader.source = "Home.qml";
    }

    Rectangle {
        width: 200
        height: parent.height 
        color: Colour.palette['Ash']
        anchors {
            top: parent.top
            left: parent.left
        }

        Row {
            anchors {
                bottom: parent.bottom
                left: parent.left
                margins: 20
            }
            height: 50
            width: parent.width 
            spacing: 15 
            Rectangle {
                id: connectIndicator
                width: 20
                height: 20
                radius: width/2
                color: Colour.palette['Yellow']
            }
            Text {
                id: connectText
                text: "Not Connected" 
                font.pointSize: 16
            }
        }
    }

    Loader {
        id: loader
        anchors {
            top: parent.top
            right: parent.right
            left: listView.right
            bottom: parent.bottom
        }
    }

    ListView {
        id: listView
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
        width: 200

        model: ListModel {
            ListElement { name: "Home" }
            ListElement { name: "Install" }
            ListElement { name: "Screenshot" }
            ListElement { name: "Log" }
            //ListElement { name: "Setting" }
        }

        delegate: Component {
            Rectangle {
                width: listView.width 
                height: 80
                color: listView.currentIndex == index ? Colour.palette['Blue'] : Colour.palette['Ash']
                Text {
                    text: name
                    anchors.centerIn: parent
                    font.pointSize: 20
                    font.bold: true
                    color: Colour.palette['Inkstone']
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: { 
                        listView.currentIndex = index
                        loader.source = name + '.qml'
                    }
                }
                Rectangle {
                    width: parent.height / Math.sqrt(2)
                    height: width
                    color: Colour.palette['Blue']
                    transform: Rotation { origin.x: 25; origin.y: 25; angle: 45}
                    anchors {
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                        rightMargin: -width/2 -3
                    }
                    visible: listView.currentIndex == index
                }
            }
        }
    }
}
