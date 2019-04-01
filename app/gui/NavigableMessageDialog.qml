import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.2

import SystemProperties 1.0

NavigableDialog {
    id: dialog

    property alias text: dialogLabel.dialogText

    property string helpText
    property string helpUrl : "https://github.com/moonlight-stream/moonlight-docs/wiki/Troubleshooting"

    onOpened: {
        // Force keyboard focus on the label so keyboard navigation works
        dialogLabel.forceActiveFocus()
    }

    RowLayout {
        spacing: 10

        Image {
            source: (standardButtons & Dialog.Yes) ?
                        "qrc:/res/baseline-help_outline-24px.svg" :
                        "qrc:/res/baseline-error_outline-24px.svg"
            sourceSize {
                // The icon should be square so use the height as the width too
                width: 50
                height: 50
            }
        }

        Label {
            property string dialogText

            id: dialogLabel
            text: dialogText + (SystemProperties.hasBrowser ? (" " + helpText) : "")
            wrapMode: Text.WordWrap

            // Cap the width so the dialog doesn't grow horizontally forever. This
            // will cause word wrap to kick in.
            Layout.maximumWidth: 400

            Keys.onReturnPressed: {
                accept()
            }
        }
    }

    footer: DialogButtonBox {
        id: dialogButtonBox
        standardButtons: dialog.standardButtons

        onHelpRequested: {
            Qt.openUrlExternally(helpUrl)
            close()
        }
    }
}
