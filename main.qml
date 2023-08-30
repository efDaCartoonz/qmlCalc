import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Калькулятор")
    Connections {
        target: appCore

        onSendToQml: {
            lblCount.text = count
        }
    }

    MainForm {
        anchors.fill: parent
        Rectangle {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 50
            color: "#cffdff"
            Label {
                id: lblCount
                color: "black"
            }
        }

        btnNum1.style: ButtonStyle {
            background: Rectangle {
                color: control.pressed ? "#d4e9fa" : "#f1f8fd"
                border.color: "black"
                border.width: 1
                radius: 1
            }
            label: Text {
                text: qsTr("1")
                color: "black"

            }
        }
        btnNum2.style: ButtonStyle {
            background: Rectangle {
                color: control.pressed ? "#d4e9fa" : "#f1f8fd"
                border.color: "black"
                border.width: 1
                radius: 1
            }
            label: Text {
                text: qsTr("2")
                color: "black"
            }
        }
        btnNum1.onClicked: customDialog.open();
        btnNum2.onClicked: customDialog.open();
        Dialog {
            id: customDialog
            width: 600
            height: 500
            contentItem: Rectangle {
                width: 600
                height: 500
                color: "#f7f7f7"
                Rectangle {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: dividerHorizontal.top
                    color: "#f7f7f7"
                    Label {
                        id: textLabel
                        text: qsTr("hellow")
                        color: "#34aadc"
                        anchors.centerIn: parent
                    }
                }
                Rectangle {
                    id: dividerHorizontal
                    color: "#d7d7d7"
                    height: 2
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: row.top
                }
                Row {
                    id: row
                    height: 100
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    Button {
                        id: btnCancel
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        width: parent.width / 2 - 1
                        style: ButtonStyle {
                            background: Rectangle {
                                color: control.pressed ? "#d4e9fa" : "#f1f8fd"
                                border.width: 0
                            }
                            label: Text {
                                text: qsTr("Cancel")
                                color: "black"
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                        onClicked: customDialog.close()
                    }
                    Rectangle {
                        id: dividerVertical
                        width: 2
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        color: "black"
                    }
                    Button {
                        id: btnOk
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        width: parent.width / 2 - 1
                        style: ButtonStyle {
                            background: Rectangle {
                                color: control.pressed ? "#d4e9fa" : "#f1f8fd"
                                border.width: 0
                            }
                            label: Text {
                                text: qsTr("Ok")
                                color: "black"
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                        onClicked: {
                            appCore.receiveFromQml();
                            customDialog.close();
                        }
                    }
                }
            }
        }
    }
}
