import QtQuick 1.1
import QtWebKit 1.0

Rectangle {
    id: mainWindow; color: "#474747"
    width: 900; height: 450

    property string defurl: qsTr("http://www.google.co.jp")
    property string back: qsTr("qrc:main/back.png")
    property string forward: qsTr("qrc:main/forward.png")
    property string reload: qsTr("qrc:main/reload.png")
    property string cancel: qsTr("qrc:main/cancel.png")
    property string home: qsTr("qrc:main/home.png")

    Item {
        width: parent.width; height: 15
        Text {
            id: pageTitle; anchors.centerIn: parent
            text: webView.title
            style: Text.Sunken; font.bold: true
            color: "White"; styleColor: "Black"
            font.pixelSize: 15
        }
    }

    Rectangle {
        id: mainView
        width: parent.width; height: parent.height - mainView.y; y: 20
        color: "Grey"; radius: 3

        Flickable {
            id: webFlick
            width: parent.width - 10; height: parent.height - 35; x: 5; y: 30
            contentHeight: webView.height; contentWidth: webView.width
            interactive: true; clip: true
            WebView {
                id: webView; url: defurl
                preferredHeight: webFlick.height
                preferredWidth: webFlick.width
                onLoadFinished: pageTitle.text = webView.title
            }
        }

        Item {
            id: toolButtons
            width: 200; height: 20; y: 5

            Button {
                width: 45; height: 20; x: 5; image: back
                onButtonClick:  webView.back.trigger()
            }
            Button {
                width: 45; height: 20; x: 53; image: forward
                onButtonClick: webView.forward.trigger()
            }
            Button {
                width: 45; height: 20; x: 101
                image: webView.progress == 1.0 ? reload : cancel
                onButtonClick: webView.reload.trigger()
            }
            Button {
                width: 45; height: 20; x: 149; image: home
                onButtonClick: webView.url = defurl
            }
        }

        Rectangle {
            id: header
            width: parent.width - ((toolButtons.width + 13) + jumpAndSettings.width);
            height: 20; x: toolButtons.width; y: 5
            radius: 3; color: "white"

            Item {
                id: jumpAndSettings
                width: jumpurl.width + settings.width
                height: parent.height
                x: parent.width

                Button {
                     id: jumpurl; image: qsTr("qrc:main/jump.png");
                     width: 80; height: parent.height; x: 5
                     onButtonClick: webView.url = Qt.resolvedUrl(qsTr(url.text))
                }
                Button {
                    id: settings; image: qsTr("qrc:main/settings.png")
                    height: parent.height; width: 45; x: jumpurl.width + 8
                }
            }

            Item {
                width: parent.width - (jumpAndSettings.width - parent.width + 10);
                height: parent.height

                TextInput {
                    id: url; font.pointSize: 10;
                    text: webView.progress == 1.0 ? webView.url : url.text
                    height: parent.height - 4; width: header.width - 50; x: 25; y: 2
                    opacity: webView.progress == 1.0 ? 1.0 : 0.3
                    Behavior on opacity { PropertyAnimation { duration: 300 } }

                    Image {
                        id: favicon; source: qsTr("http://favicon.hatena.ne.jp/?url=" + webView.url)
                        height: 15; width: -15; x: -5
                    }

                    Image {
                        id: waiting; source: qsTr("qrc:main/wait.png");
                        height: 15; width: 15; x: parent.width + 5
                        opacity: webView.progress == 1.0 ? 1.0 : 0.3
                        Behavior on opacity { PropertyAnimation { duration: 300 } }
                    }
                }
            }
        }
    }
}
