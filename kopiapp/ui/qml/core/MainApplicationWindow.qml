import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.4
import QtQuick.Window 2.12
import Qt.labs.platform 1.1

import Kopi 1.0

import "../mainscreens"
import "../kviews"
import "../basickontrols"

ApplicationWindow {
    id: root

    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    visible: true
    color: KStyle.styleDefinition.kpalette.window

    property string theme

    header: KMainToolbar {
        id: maintoolbar
        height: 35
        enabled: true

        showChartsModeButtons: chartsModeLoader.item.visible
        mainMenuButton.onClicked: mainMenuDrawer.open()

        chartModeButton.onClicked: {
            mainStackView.pop()
            mainStackView.push(chartsModeLoader.item)
        }

        marketButton.onClicked: {
            mainStackView.pop()
            mainStackView.push(marketScreenLoader.item)
        }

        b2.onClicked: chartsModeLoader.item.numberOfCharts = 2
        b4.onClicked: chartsModeLoader.item.numberOfCharts = 4
        b8.onClicked: chartsModeLoader.item.numberOfCharts = 8
        chartTypeCombo.onActivated: chartsModeLoader.item.chartViewType = chartTypeCombo.currentIndex
    }

    SystemTrayIcon {
        visible: true
        iconSource: "qrc:/graphic-assets/logos/Color logo - no background.png"

        onActivated: {
            root.show()
            root.raise()
            root.requestActivate()
        }
    }

    //! two main items in a row
    RowLayout {
        id: mainLayout
        anchors.fill: parent
        spacing: 5

        KStackView {
            id: mainStackView
            Layout.fillHeight: true
            Layout.fillWidth: true

            onCurrentItemChanged: mainMenuDrawer.close()

            Behavior on width {
                NumberAnimation {
                    duration: 350
                    easing.type: Easing.InOutQuad
                }
            }

            KLoader {
                id: marketScreenLoader
                source: "../mainscreens/MarketScreen.qml"
                active: true
                onLoaded: mainStackView.push(marketScreenLoader.item)
            }

            KLoader {
                id: chartsModeLoader
                source: "../mainscreens/ChartModeScreen.qml"
                active: true
            }
        }
    }

    Drawer {
        id: mainMenuDrawer
        edge: Qt.LeftEdge
        interactive: true
        height: root.height
        enabled: true
        dim: false

        RowLayout {
            anchors.fill: parent
            MainMenuView {
                id: mainMenu
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }

        onAboutToShow: {
//            menuSpacer.width = mainMenu.width
//            menuSpacer.visible = true
        }
        onAboutToHide: {
//            menuSpacer.width = 0
//            menuSpacer.visible = false
        }
        onOpened: {

        }
        onClosed: {

        }
    }
}
