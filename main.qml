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
        onShowExpressionValue: {
            editExpression.text = value
        }
        onShowError: {
            textPrintLog.append("<p style='color: #f00; line-height:80%'>" + message + "</p>")
        }
        onShowExpression: {
            textPrintLog.append("<p style='color: #00f; line-height:80%'>" + message + "</p>")
        }
        onShowExpressionResult: {
            textPrintLog.append("<p style='color: #090; line-height:80%'>" + message + "</p>")
        }
        onShowRequestQueueCount: {
            countQueueReq.text = count
        }
        onShowResultQueueCount: {
            countQueueRes.text = count
        }
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

    property bool isUnexceptInputSymbol: false
    property bool isExpressionClear: false

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
            anchors.bottom: rowClear.top
            height: sizeSeparatorVertical
        }
        Row {
            id: rowClear
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: verticalSeparator3.top
            height: sizeCalcButtonHeight
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Button {
                id: btnDelete
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - sizeSeparatorHorizontal * 3) / 2
                style: ButtonStyle {
                    background: Rectangle {
                        color: control.pressed ? colorBtnPressed : colorBtnNormal
                        border.width: sizeWidgetBorder
                        border.color: colorWidgetBorder
                    }
                    label: Text {
                        text: qsTr("C")
                        color: colorBtnFont
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                onClicked: {
                    appCore.whenDeleteLastSymbol()
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Button {
                id: btnClear
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - sizeSeparatorHorizontal * 3) / 2
                style: ButtonStyle {
                    background: Rectangle {
                        color: control.pressed ? colorBtnPressed : colorBtnNormal
                        border.width: sizeWidgetBorder
                        border.color: colorWidgetBorder
                    }
                    label: Text {
                        text: qsTr("CE")
                        color: colorBtnFont
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                onClicked: {
                    appCore.whenClearExpression()
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
            anchors.bottom: row0.top
            height: sizeSeparatorVertical
        }
        Row {
            id: row0
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

                    appCore.whenAddNewSymbol("1")
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

                    appCore.whenAddNewSymbol("2")
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

                    appCore.whenAddNewSymbol("3")
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

                    appCore.whenAddNewSymbol("+")
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
            anchors.bottom: row1.top
            height: sizeSeparatorVertical
        }
        Row {
            id: row1
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

                    appCore.whenAddNewSymbol("4")
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

                    appCore.whenAddNewSymbol("5")
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

                    appCore.whenAddNewSymbol("6")
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

                    appCore.whenAddNewSymbol("-")
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
            anchors.bottom: row2.top
            height: sizeSeparatorVertical
        }
        Row {
            id: row2
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

                    appCore.whenAddNewSymbol("7")
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

                    appCore.whenAddNewSymbol("8")
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

                    appCore.whenAddNewSymbol("9")
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

                    appCore.whenAddNewSymbol("*")
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
            anchors.bottom: row3.top
            height: sizeSeparatorVertical
        }
        Row {
            id: row3
            height: sizeCalcButtonHeight
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: verticalSeparator7.top
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

                    appCore.whenAddNewSymbol(".")
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

                    appCore.whenAddNewSymbol("0")
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

                    appCore.whenAddNewSymbol("=")
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

                    appCore.whenAddNewSymbol("/")
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
        }
        Rectangle {
            id: verticalSeparator7
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: verticalSeparator8.top
            height: sizeSeparatorVertical
        }
        Rectangle {
            id: verticalSeparator8
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: verticalSeparator9.top
            height: 1
            width: parent.width
            color: colorWidgetBorder
        }
        Rectangle {
            id: verticalSeparator9
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: rowSetCalcTime.top
            height: sizeSeparatorVertical
        }
        Row {
            id: rowSetCalcTime
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: verticalSeparator10.top
            height: sizeSetCalcTimeRow
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Rectangle {
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: lblCalcIntervalDescr.width
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    id: lblCalcIntervalDescr
                    font.pointSize: 14
                    text: qsTr("Интервал вычисления (сек):")
                }
            }

            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            TextField {
                id: editCalcInterval
                text: calcInterval
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - sizeSeparatorHorizontal * 4) - lblCalcIntervalDescr.width - btnSetCalcInterval.width
                focus: true
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
                    appCore.setCalcTimerInterval(editCalcInterval.text)
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
        }
        Rectangle {
            id: verticalSeparator10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: queuesInfo.top
            height: sizeSeparatorVertical
        }
        Row {
            id: queuesInfo
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: verticalSeparator11.top
            height: sizeCalcButtonHeight
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Rectangle {
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: lblQueueReq.width
                Text {
                    id: lblQueueReq
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 14
                    text: qsTr("Выражений в очереди: ")
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Rectangle {
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - lblQueueReq.width - lblQueueRes.width - sizeSeparatorHorizontal * 5) / 2
                Text {
                    id: countQueueReq
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 14
                    text: "0"
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Rectangle {
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: lblQueueRes.width
                Text {
                    id: lblQueueRes
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 14
                    text: qsTr("Решений в очереди: ")
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Rectangle {
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - lblQueueReq.width - lblQueueRes.width - sizeSeparatorHorizontal * 5) / 2
                Text {
                    id: countQueueRes
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 14
                    text: "0"
                }
            }
            Rectangle {
                width: sizeSeparatorHorizontal
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
        }
        Rectangle {
            id: verticalSeparator11
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: sizeSeparatorVertical
        }
    }
}
