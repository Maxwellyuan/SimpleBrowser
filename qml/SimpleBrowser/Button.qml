import QtQuick 1.1

Rectangle {
    signal buttonClick()

    property string label: ""
    property color defaultColor: "Gold"
    property alias image: icon.source

    color: defaultColor
    radius: 5

    Text {
        id: labeltext
        text: qsTr(label)
        anchors.centerIn: parent
    }
    Image {
        id: icon
        smooth: true
        anchors.centerIn: parent
        height: 20; width: 20
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onEntered: parent.color = Qt.darker(parent.defaultColor, 1.2)
        onExited: parent.color = defaultColor
        onClicked: buttonClick()
    }
}
