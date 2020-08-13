/***************************************************************************
* Copyright (c) 2020 Deachir <https://github.com/daechir>
*
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without restriction,
* including without limitation the rights to use, copy, modify, merge,
* publish, distribute, sublicense, and/or sell copies of the Software,
* and to permit persons to whom the Software is furnished to do so,
* subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included
* in all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
* OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
* OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
* ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
* OR OTHER DEALINGS IN THE SOFTWARE.
*
***************************************************************************/

import QtQuick 2.0
import SddmComponents 2.0
import "SimpleControls" as Simple

Rectangle {
	height: config.displayHeight
	width: config.displayWidth

	LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
	LayoutMirroring.childrenInherit: true

	TextConstants { id: textConstants }

	Connections {
		target: sddm
		function onLoginSucceeded () {}
		function onLoginFailed () {
			pw_entry.text = ""
			pw_entry.focus = true
		}
	}

	FontLoader {
		id: textFont; name: config.displayFont
	}

	Background {
		anchors.fill: parent
		source: config.background
		fillMode: Image.PreserveAspectCrop
		onStatusChanged: {
			if (status == Image.Error && source != config.defaultBackground) {
				source = config.defaultBackground
			}
		}
	}

	Rectangle {
		anchors.fill: parent
		color: "transparent"

		Rectangle {
			height: 40
			width: parent.width
			color: "transparent"
			anchors.bottom: parent.bottom
			anchors.bottomMargin: 10

			Row {
				id: entries
				height: parent.height
				width: parent.width * 0.33
				anchors.right: parent.right
				anchors.rightMargin: 30
				spacing: 10

				TextBox {
					id: user_entry
					width: parent.width * 0.33
					anchors.verticalCenter: parent.verticalCenter
					text: userModel.lastUser
					font.pixelSize: 14
					color: Qt.rgba(0, 0, 0, 0.2)
					borderColor: "transparent"
					focusColor: Qt.rgba(0, 0, 0, 0.25)
					hoverColor: Qt.rgba(0, 0, 0, 0.2)
					textColor: "white"
					KeyNavigation.backtab: session; KeyNavigation.tab: pw_entry
				}

				PasswordBox {
					id: pw_entry
					width: parent.width * 0.33
					anchors.verticalCenter: parent.verticalCenter
					font.pixelSize: 14
					color: Qt.rgba(0, 0, 0, 0.2)
					borderColor: "transparent"
					focusColor: Qt.rgba(0, 0, 0, 0.25)
					hoverColor: Qt.rgba(0, 0, 0, 0.2)
					textColor: "white"
					KeyNavigation.backtab: user_entry; KeyNavigation.tab: loginButton

					Keys.onPressed: {
						if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
							sddm.login(user_entry.text, pw_entry.text, session.index)
							event.accepted = true
						}
					}
				}

				Button {
					id: loginButton
					width: parent.width * 0.33
					anchors.verticalCenter: parent.verticalCenter
					text: textConstants.login
					font.pixelSize: 14
					font.bold: false
					color: Qt.rgba(0, 0, 0, 0.2)
					activeColor: Qt.rgba(0, 0, 0, 0.2)
					pressedColor: Qt.rgba(0, 0, 0, 0.25)
					onClicked: sddm.login(user_entry.text, pw_entry.text, session.index)
					KeyNavigation.backtab: pw_entry; KeyNavigation.tab: restart
				}
			}
		}
	}

	Rectangle {
		height: 40
		width: parent.width
		color: "transparent"
		anchors.top: parent.top
		anchors.topMargin: 10

		Simple.SimpleComboBox {
			id: session
			width: 160
			anchors.left: parent.left
			anchors.leftMargin: 20
			anchors.verticalCenter: parent.verticalCenter
			font.pixelSize: 14
			color: Qt.rgba(0, 0, 0, 0.2)
			dropDownColor: Qt.rgba(0, 0, 0, 0.2)
			borderColor: "transparent"
			textColor: "white"
			arrowIcon: "images/arrow-down.png"
			arrowColor: "transparent"
			model: sessionModel
			index: sessionModel.lastIndex
			KeyNavigation.backtab: shutdown; KeyNavigation.tab: user_entry
		}

		Button {
			id: restart
			anchors.right: shutdown.left
			anchors.rightMargin: 10
			anchors.verticalCenter: parent.verticalCenter
			text: textConstants.reboot
			font.pixelSize: 14
			font.bold: false
			color: Qt.rgba(0, 0, 0, 0.2)
			pressedColor: Qt.rgba(0, 0, 0, 0.25)
			activeColor: Qt.rgba(0, 0, 0, 0.2)
			onClicked: sddm.reboot()
			KeyNavigation.backtab: loginButton; KeyNavigation.tab: shutdown
		}

		Button {
			id: shutdown
			anchors.right: parent.right
			anchors.rightMargin: 20
			anchors.verticalCenter: parent.verticalCenter
			text: textConstants.shutdown
			font.pixelSize: 14
			font.bold: false
			color: Qt.rgba(0, 0, 0, 0.2)
			pressedColor: Qt.rgba(0, 0, 0, 0.25)
			activeColor: Qt.rgba(0, 0, 0, 0.2)
			onClicked: sddm.powerOff()
			KeyNavigation.backtab: restart; KeyNavigation.tab: session
		}
	}

	Component.onCompleted: {
		if (user_entry.text === "")
			user_entry.focus = true
		else
			pw_entry.focus = true
	}
}