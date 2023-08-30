import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

Item {
    width: 360
    height: 360

    property alias btnNum1: btnNum1
    property alias btnNum2: btnNum2

    RowLayout {
        anchors.centerIn: parent

        Button {
            id: btnNum1
        }
        Button {
            id: btnNum2
        }
    }
}
