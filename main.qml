import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2

ApplicationWindow {
    visible: true
    x: winX
    y: winY
    width: winWidth
    height: winHeight
    title: qsTr("Калькулятор")
    Connections {
        target: appCore

    }

    property int sizeSeparatorHorizontal: 4
    property int sizeSeparatorVertical: 4
    property int sizeCalcButtonHeight: 40

    property int sizeExpressionRow: 40
    property int sizeSetCalcTimeRow: 40

    property string colorBtnNormal: "#f1f8fd"
    property string colorBtnPressed: "#d4e9fa"
    property string colorBtnFont: "#000000"

    property int sizeWidgetBorder: 1
    property string colorWidgetBorder: "#000000"

    onClosing: {
        appCore.saveWindowSize(width, height)
        appCore.saveWindowPosition(x, y)
    }

    MainForm {
        anchors.fill: parent
        Rectangle {
            id: verticalSeparator0
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.top
            height: sizeSeparatorVertical
        }
        Row {
            id: rowExpression
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: verticalSeparator0.bottom
            height: sizeExpressionRow
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            TextField {
                id: editExpression
                readOnly: true
                placeholderText: qsTr("0")
                anchors.verticalCenter: parent.verticalCenter
                height: sizeExpressionRow
                width: parent.width - sizeSeparatorHorizontal * 2
                font.pointSize: 14
                verticalAlignment: TextInput.AlignVCenter
                style: TextFieldStyle {
                    background: Rectangle {
                        border.width: sizeWidgetBorder
                        border.color: colorWidgetBorder
                    }
                }

            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
        }
        Rectangle {
            id: verticalSeparator1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: rowExpression.bottom
            height: sizeSeparatorVertical
        }
        Row {
            id: rowLog
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: verticalSeparator1.bottom
            anchors.bottom: verticalSeparator2.top
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            TextArea {
                id: textPrintLog
                readOnly: true
                textFormat: TextEdit.RichText
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: parent.width - sizeSeparatorHorizontal * 2
                font.pointSize: 12
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
        }

        Rectangle {
            id: verticalSeparator2
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: row0.top
            height: sizeSeparatorVertical
        }
        Row {
            id: row0
            height: sizeCalcButtonHeight
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: verticalSeparator3.top
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Button {
                id: btnNum1
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - sizeSeparatorHorizontal * 5) / 4
                style: ButtonStyle {
                    background: Rectangle {
                        color: control.pressed ? colorBtnPressed : colorBtnNormal
                        border.width: sizeWidgetBorder
                        border.color: colorWidgetBorder
                    }
                    label: Text {
                        text: qsTr("1")
                        color: colorBtnFont
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                onClicked: {
                    editExpression.text += "1"
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Button {
                id: btnNum2
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - sizeSeparatorHorizontal * 5) / 4
                style: ButtonStyle {
                    background: Rectangle {
                        color: control.pressed ? colorBtnPressed : colorBtnNormal
                        border.width: sizeWidgetBorder
                        border.color: colorWidgetBorder
                    }
                    label: Text {
                        text: qsTr("2")
                        color: colorBtnFont
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                onClicked: {
                    editExpression.text += "2"
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Button {
                id: btnNum3
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - sizeSeparatorHorizontal * 5) / 4
                style: ButtonStyle {
                    background: Rectangle {
                        color: control.pressed ? colorBtnPressed : colorBtnNormal
                        border.width: sizeWidgetBorder
                        border.color: colorWidgetBorder
                    }
                    label: Text {
                        text: qsTr("3")
                        color: colorBtnFont
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                onClicked: {
                    editExpression.text += "3"
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Button {
                id: btnNumAddition
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - sizeSeparatorHorizontal * 5) / 4
                style: ButtonStyle {
                    background: Rectangle {
                        color: control.pressed ? colorBtnPressed : colorBtnNormal
                        border.width: sizeWidgetBorder
                        border.color: colorWidgetBorder
                    }
                    label: Text {
                        text: qsTr("+")
                        color: colorBtnFont
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                onClicked: {
                    textPrintLog.append("<p style='color:#FF0000;'>Red</p>")
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
        }
        Rectangle {
            id: verticalSeparator3
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: row1.top
            height: sizeSeparatorVertical
        }
        Row {
            id: row1
            height: sizeCalcButtonHeight
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: verticalSeparator4.top
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Button {
                id: btnNum4
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - sizeSeparatorHorizontal * 5) / 4
                style: ButtonStyle {
                    background: Rectangle {
                        color: control.pressed ? colorBtnPressed : colorBtnNormal
                        border.width: sizeWidgetBorder
                        border.color: colorWidgetBorder
                    }
                    label: Text {
                        text: qsTr("4")
                        color: colorBtnFont
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                onClicked: {
                    editExpression.text += "4"
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Button {
                id: btnNum5
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - sizeSeparatorHorizontal * 5) / 4
                style: ButtonStyle {
                    background: Rectangle {
                        color: control.pressed ? colorBtnPressed : colorBtnNormal
                        border.width: sizeWidgetBorder
                        border.color: colorWidgetBorder
                    }
                    label: Text {
                        text: qsTr("5")
                        color: colorBtnFont
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                onClicked: {
                    editExpression.text += "5"
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Button {
                id: btnNum6
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - sizeSeparatorHorizontal * 5) / 4
                style: ButtonStyle {
                    background: Rectangle {
                        color: control.pressed ? colorBtnPressed : colorBtnNormal
                        border.width: sizeWidgetBorder
                        border.color: colorWidgetBorder
                    }
                    label: Text {
                        text: qsTr("6")
                        color: colorBtnFont
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                onClicked: {
                    editExpression.text += "6"
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Button {
                id: btnNumSubtract
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - sizeSeparatorHorizontal * 5) / 4
                style: ButtonStyle {
                    background: Rectangle {
                        color: control.pressed ? colorBtnPressed : colorBtnNormal
                        border.width: sizeWidgetBorder
                        border.color: colorWidgetBorder
                    }
                    label: Text {
                        text: qsTr("-")
                        color: colorBtnFont
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                onClicked: {
                    textPrintLog.append("<p style='color: #0f0'>Green</p>")
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
        }
        Rectangle {
            id: verticalSeparator4
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: row2.top
            height: sizeSeparatorVertical
        }
        Row {
            id: row2
            height: sizeCalcButtonHeight
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: verticalSeparator5.top
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Button {
                id: btnNum7
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - sizeSeparatorHorizontal * 5) / 4
                style: ButtonStyle {
                    background: Rectangle {
                        color: control.pressed ? colorBtnPressed : colorBtnNormal
                        border.width: sizeWidgetBorder
                        border.color: colorWidgetBorder
                    }
                    label: Text {
                        text: qsTr("7")
                        color: colorBtnFont
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                onClicked: {
                    editExpression.text += "7"
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Button {
                id: btnNum8
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - sizeSeparatorHorizontal * 5) / 4
                style: ButtonStyle {
                    background: Rectangle {
                        color: control.pressed ? colorBtnPressed : colorBtnNormal
                        border.width: sizeWidgetBorder
                        border.color: colorWidgetBorder
                    }
                    label: Text {
                        text: qsTr("8")
                        color: colorBtnFont
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                onClicked: {
                    editExpression.text += "8"
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Button {
                id: btnNum9
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - sizeSeparatorHorizontal * 5) / 4
                style: ButtonStyle {
                    background: Rectangle {
                        color: control.pressed ? colorBtnPressed : colorBtnNormal
                        border.width: sizeWidgetBorder
                        border.color: colorWidgetBorder
                    }
                    label: Text {
                        text: qsTr("9")
                        color: colorBtnFont
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                onClicked: {
                    editExpression.text += "9"
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Button {
                id: btnNumMultiply
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - sizeSeparatorHorizontal * 5) / 4
                style: ButtonStyle {
                    background: Rectangle {
                        color: control.pressed ? colorBtnPressed : colorBtnNormal
                        border.width: sizeWidgetBorder
                        border.color: colorWidgetBorder
                    }
                    label: Text {
                        text: qsTr("*")
                        color: colorBtnFont
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                onClicked: {
                    textPrintLog.append("<p style='color: #00f'>Blue</p>")
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
        }
        Rectangle {
            id: verticalSeparator5
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: row3.top
            height: sizeSeparatorVertical
        }
        Row {
            id: row3
            height: sizeCalcButtonHeight
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: verticalSeparator6.top
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Button {
                id: btnNumDot
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - sizeSeparatorHorizontal * 5) / 4
                style: ButtonStyle {
                    background: Rectangle {
                        color: control.pressed ? colorBtnPressed : colorBtnNormal
                        border.width: sizeWidgetBorder
                        border.color: colorWidgetBorder
                    }
                    label: Text {
                        text: qsTr(".")
                        color: colorBtnFont
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                onClicked: {
                    editExpression.text += "."
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Button {
                id: btnNum0
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - sizeSeparatorHorizontal * 5) / 4
                style: ButtonStyle {
                    background: Rectangle {
                        color: control.pressed ? colorBtnPressed : colorBtnNormal
                        border.width: sizeWidgetBorder
                        border.color: colorWidgetBorder
                    }
                    label: Text {
                        text: qsTr("0")
                        color: colorBtnFont
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                onClicked: {
                    editExpression.text += "0"
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Button {
                id: btnNumEquals
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - sizeSeparatorHorizontal * 5) / 4
                style: ButtonStyle {
                    background: Rectangle {
                        color: control.pressed ? colorBtnPressed : colorBtnNormal
                        border.width: sizeWidgetBorder
                        border.color: colorWidgetBorder
                    }
                    label: Text {
                        text: qsTr("=")
                        color: colorBtnFont
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                onClicked: {
                    editExpression.text = ""
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Button {
                id: btnNumDivision
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - sizeSeparatorHorizontal * 5) / 4
                style: ButtonStyle {
                    background: Rectangle {
                        color: control.pressed ? colorBtnPressed : colorBtnNormal
                        border.width: sizeWidgetBorder
                        border.color: colorWidgetBorder
                    }
                    label: Text {
                        text: qsTr("/")
                        color: colorBtnFont
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                onClicked: {
                    textPrintLog.append("<p style='color: #999'>Gray</p>")
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
        }
        Rectangle {
            id: verticalSeparator6
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: verticalSeparator7.top
            height: sizeSeparatorVertical
        }
        Rectangle {
            id: verticalSeparator7
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: verticalSeparator8.top
            height: 1
            width: parent.width
            color: colorWidgetBorder
        }
        Rectangle {
            id: verticalSeparator8
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: rowSetCalcTime.top
            height: sizeSeparatorVertical
        }
        Row {
            id: rowSetCalcTime
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: verticalSeparator9.top
            height: sizeSetCalcTimeRow
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Label {
                id: lblCalcIntervalDescr
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 14
                text: qsTr("Интервал вычисления (мсек):")
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            TextField {
                id: editCalcInterval
                placeholderText: qsTr("10000")
                anchors.verticalCenter: parent.verticalCenter
                focus: true
                font.pointSize: 14
                width: (parent.width - sizeSeparatorHorizontal * 4) - lblCalcIntervalDescr.width - btnSetCalcInterval.width
                verticalAlignment: TextInput.AlignVCenter
                style: TextFieldStyle {
                    background: Rectangle {
                        border.width: sizeWidgetBorder
                        border.color: colorWidgetBorder
                    }
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Button {
                id: btnSetCalcInterval
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - sizeSeparatorHorizontal * 5) / 4
                style: ButtonStyle {
                    background: Rectangle {
                        color: control.pressed ? colorBtnPressed : colorBtnNormal
                        border.width: sizeWidgetBorder
                        border.color: colorWidgetBorder
                    }
                    label: Text {
                        text: qsTr("Установить")
                        color: colorBtnFont
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                onClicked: {
                    textPrintLog.append(editCalcInterval.text)
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
        }

        Rectangle {
            id: verticalSeparator9
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: sizeSeparatorVertical
        }
    }
}
