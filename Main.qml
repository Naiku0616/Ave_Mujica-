// main.qml
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

ApplicationWindow {
    id: mainWindow
    width: 1400
    height: 900
    visible: true
    title: "Ave Mujica"
    minimumWidth: 1200
    minimumHeight: 800

    // 自定义字体加载
    FontLoader {
        id: aliceWonderlandFont
        source: "assets/fonts/AliceInWonderland-1GzL0-2.ttf"
    }

    // Ave Mujica 主题色彩定义
    property color primaryColor: "#0a0a0a"      // 主黑色
    property color secondaryColor: "#1a1a1a"    // 次黑色
    property color accentColor: "#c0a070"       // 古金色
    property color textColor: "#e0e0e0"         // 文字色
    property color highlightColor: "#8b0000"    // 暗红色

    // 当前选中的页面
    property string currentPage: "home"
    property string selectedMember: ""
    property string selectedAlbum: ""

    // 设置窗口背景
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#1a1a1a" }
            GradientStop { position: 1.0; color: primaryColor }
        }

        // 星星背景效果
        Item {
            anchors.fill: parent

            Repeater {
                model: 50

                Rectangle {
                    width: Math.random() * 2 + 1
                    height: width
                    radius: width / 2
                    color: Qt.rgba(1, 1, 1, Math.random() * 0.8 + 0.2)
                    x: Math.random() * parent.width
                    y: Math.random() * parent.height

                    OpacityAnimator on opacity {
                        from: 0.3
                        to: 1.0
                        duration: Math.random() * 2000 + 1000
                        loops: Animation.Infinite
                        running: true
                    }
                }
            }
        }
    }

    // 主内容区域
    Rectangle {
        anchors.fill: parent
        color: "transparent"

        // 顶部导航栏区域
        Rectangle {
            id: header
            width: parent.width
            height: 100
            color: "transparent"

            // Logo和标题
            Row {
                anchors.left: parent.left
                anchors.leftMargin: 40
                anchors.verticalCenter: parent.verticalCenter
                spacing: 20

                // Logo
                Image {
                    source: "assets/images/logo.png"
                    width: 60
                    height: 60
                    fillMode: Image.PreserveAspectFit
                }

                Label {
                    text: "AVE MUJICA"
                    color: accentColor
                    font.family: aliceWonderlandFont.name
                    font.pixelSize: 32
                    font.letterSpacing: 4
                }
            }

            // 导航按钮
            Row {
                anchors {
                    right: parent.right
                    rightMargin: 40
                    verticalCenter: parent.verticalCenter
                }
                spacing: 20

                Button {
                    text: "HOME"
                    onClicked: currentPage = "home"
                    background: Rectangle {
                        color: parent.down ? "#a89060" :
                               (currentPage === "home" ? highlightColor :
                               parent.hovered ? "#d4b483" : "#c0a070")
                        radius: 4
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#0a0a0a"
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Button {
                    text: "MEMBERS"
                    onClicked: currentPage = "members"
                    background: Rectangle {
                        color: parent.down ? "#a89060" :
                               (currentPage === "members" ? highlightColor :
                               parent.hovered ? "#d4b483" : "#c0a070")
                        radius: 4
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#0a0a0a"
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Button {
                    text: "MUSIC"
                    onClicked: currentPage = "music"
                    background: Rectangle {
                        color: parent.down ? "#a89060" :
                               (currentPage === "music" ? highlightColor :
                               parent.hovered ? "#d4b483" : "#c0a070")
                        radius: 4
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#0a0a0a"
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Button {
                    text: "ABOUT"
                    onClicked: currentPage = "about"
                    background: Rectangle {
                        color: parent.down ? "#a89060" :
                               (currentPage === "about" ? highlightColor :
                               parent.hovered ? "#d4b483" : "#c0a070")
                        radius: 4
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#0a0a0a"
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }

        // 侧边栏
        Rectangle {
            id: sidebar
            width: 250
            anchors {
                top: header.bottom
                bottom: parent.bottom
                left: parent.left
            }
            color: "#151515"

            Column {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 10

                Label {
                    text: "QUICK NAVIGATION"
                    color: accentColor
                    font.bold: true
                    font.pixelSize: 16
                    bottomPadding: 10
                    font.family: aliceWonderlandFont.name
                }

                // 快速导航按钮
                Repeater {
                    model: [
                        { name: "Latest News", page: "home", icon: "📰" },
                        { name: "Tour Dates", page: "home", icon: "🎪" },
                        { name: "Gallery", page: "members", icon: "🖼️" },
                        { name: "Merch Store", page: "about", icon: "🛍️" }
                    ]

                    Rectangle {
                        width: parent.width
                        height: 45
                        color: "transparent"
                        radius: 4

                        Row {
                            anchors.fill: parent
                            anchors.margins: 8
                            spacing: 12

                            Text {
                                text: modelData.icon
                                color: accentColor
                                font.pixelSize: 16
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Label {
                                text: modelData.name
                                color: textColor
                                font.pixelSize: 14
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: parent.color = "#222222"
                            onExited: parent.color = "transparent"
                            onClicked: {
                                currentPage = modelData.page
                                console.log("Navigated to: " + modelData.name)
                            }
                        }
                    }
                }

                Item { height: 20; width: 1 }

                Label {
                    text: "SOCIAL MEDIA"
                    color: accentColor
                    font.bold: true
                    font.pixelSize: 16
                    bottomPadding: 10
                    font.family: aliceWonderlandFont.name
                }

                // 社交媒体链接
                Repeater {
                    model: ["YouTube", "Twitter", "Instagram", "Official Site"]

                    Rectangle {
                        width: parent.width
                        height: 35
                        color: "transparent"

                        Label {
                            text: modelData
                            anchors.verticalCenter: parent.verticalCenter
                            color: textColor
                            font.pixelSize: 13
                            opacity: 0.8

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    parent.color = accentColor
                                    parent.opacity = 1.0
                                }
                                onExited: {
                                    parent.color = textColor
                                    parent.opacity = 0.8
                                }
                                onClicked: console.log("Open: " + modelData)
                            }
                        }
                    }
                }
            }
        }

        // 主内容区域 - 支持页面切换
        Rectangle {
            id: contentArea
            anchors {
                top: header.bottom
                bottom: parent.bottom
                left: sidebar.right
                right: parent.right
                margins: 20
            }
            color: "transparent"

            // 月亮装饰
            Rectangle {
                width: 80
                height: 80
                radius: width / 2
                color: "transparent"
                anchors {
                    top: parent.top
                    right: parent.right
                    margins: 20
                }

                // 月亮主体
                Rectangle {
                    width: 60
                    height: 60
                    radius: width / 2
                    color: "#f0f0f0"
                    anchors.centerIn: parent

                    // 月亮阴影
                    Rectangle {
                        width: 50
                        height: 50
                        radius: width / 2
                        color: primaryColor
                        anchors {
                            left: parent.left
                            verticalCenter: parent.verticalCenter
                            leftMargin: -10
                        }
                    }
                }
            }

            // 页面切换逻辑
            Loader {
                id: pageLoader
                anchors.fill: parent
                sourceComponent: {
                    switch(currentPage) {
                    case "home": return homePage
                    case "members": return membersPage
                    case "music": return musicPage
                    case "about": return aboutPage
                    default: return homePage
                    }
                }
            }

            // 首页组件
            Component {
                id: homePage

                Column {
                    anchors.fill: parent
                    spacing: 20

                    // 欢迎卡片
                    Rectangle {
                        width: parent.width
                        height: 150
                        color: "#1a1a1a"
                        radius: 8

                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"
                            border.color: accentColor
                            border.width: 1
                            radius: parent.radius
                        }

                        Row {
                            anchors.fill: parent
                            anchors.margins: 25
                            spacing: 25

                            Rectangle {
                                width: 80
                                height: 80
                                radius: 40
                                color: accentColor
                                anchors.verticalCenter: parent.verticalCenter

                                Label {
                                    text: "♫"
                                    anchors.centerIn: parent
                                    color: primaryColor
                                    font.pixelSize: 32
                                }
                            }

                            Column {
                                anchors.verticalCenter: parent.verticalCenter
                                spacing: 8

                                Label {
                                    text: "WELCOME TO AVE MUJICA"
                                    color: accentColor
                                    font.pixelSize: 22
                                    font.bold: true
                                    font.family: aliceWonderlandFont.name
                                }

                                Label {
                                    text: "Where myth meets music in eternal symphony"
                                    color: textColor
                                    font.pixelSize: 16
                                    opacity: 0.8
                                }

                                Label {
                                    text: "Experience the world where music transcends reality"
                                    color: textColor
                                    font.pixelSize: 14
                                    opacity: 0.6
                                }
                            }
                        }
                    }

                    // 新闻和更新
                    Grid {
                        width: parent.width
                        columns: 2
                        spacing: 15

                        Repeater {
                            model: [
                                { title: "New Album Announcement", desc: "World's End coming soon", date: "2024", icon: "🎵" },
                                { title: "World Tour 2024", desc: "Global concert series announced", date: "Coming Soon", icon: "🌍" },
                                { title: "Behind the Myth", desc: "Exclusive documentary series", date: "Now Streaming", icon: "🎬" },
                                { title: "Fan Art Contest", desc: "Submit your Ave Mujica artwork", date: "Open", icon: "🎨" }
                            ]

                            Rectangle {
                                width: (parent.width - parent.spacing) / 2
                                height: 120
                                color: "#1a1a1a"
                                radius: 6

                                Rectangle {
                                    anchors.fill: parent
                                    color: "transparent"
                                    border.color: "#333333"
                                    border.width: 1
                                    radius: parent.radius
                                }

                                Column {
                                    anchors.fill: parent
                                    anchors.margins: 15
                                    spacing: 8

                                    Row {
                                        spacing: 12

                                        Text {
                                            text: modelData.icon
                                            color: accentColor
                                            font.pixelSize: 20
                                            anchors.verticalCenter: parent.verticalCenter
                                        }

                                        Column {
                                            anchors.verticalCenter: parent.verticalCenter
                                            spacing: 2

                                            Label {
                                                text: modelData.title
                                                color: textColor
                                                font.pixelSize: 16
                                                font.bold: true
                                            }

                                            Label {
                                                text: modelData.date
                                                color: accentColor
                                                font.pixelSize: 12
                                            }
                                        }
                                    }

                                    Label {
                                        text: modelData.desc
                                        color: textColor
                                        font.pixelSize: 13
                                        opacity: 0.7
                                        wrapMode: Text.WordWrap
                                    }
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: parent.color = "#222222"
                                    onExited: parent.color = "#1a1a1a"
                                    onClicked: console.log("Clicked: " + modelData.title)
                                }
                            }
                        }
                    }
                }
            }

            // 成员页面组件
            Component {
                id: membersPage

                Column {
                    anchors.fill: parent
                    spacing: 20

                    Label {
                        text: "THE MEMBERS OF AVE MUJICA"
                        color: accentColor
                        font.pixelSize: 24
                        font.bold: true
                        font.family: aliceWonderlandFont.name
                    }

                    Grid {
                        width: parent.width
                        columns: 3
                        spacing: 20

                        Repeater {
                            model: [
                                { name: "Amoris", role: "Drums", img: "assets/images/members/amoris.png" },
                                { name: "Mortis", role: "Guitar", img: "assets/images/members/mortis.png" },
                                { name: "Timoris", role: "Bass", img: "assets/images/members/timoris.png" },
                                { name: "Oblivionis", role: "Keyboard", img: "assets/images/members/oblivionis.png" },
                                { name: "Doloris", role: "Vocal", img: "assets/images/members/doloris.png" }
                            ]

                            Rectangle {
                                width: (parent.width - parent.spacing * 2) / 3
                                height: 280
                                color: "#1a1a1a"
                                radius: 8

                                Column {
                                    anchors.fill: parent
                                    anchors.margins: 15
                                    spacing: 10

                                    // 成员立绘
                                    Rectangle {
                                        width: parent.width
                                        height: 180
                                        color: "transparent"

                                        Image {
                                            source: modelData.img
                                            anchors.fill: parent
                                            fillMode: Image.PreserveAspectFit
                                        }
                                    }

                                    // 成员信息
                                    Column {
                                        width: parent.width
                                        spacing: 5

                                        Label {
                                            text: modelData.name
                                            color: accentColor
                                            font.pixelSize: 18
                                            font.bold: true
                                            font.family: aliceWonderlandFont.name
                                            width: parent.width
                                            horizontalAlignment: Text.AlignHCenter
                                        }

                                        Label {
                                            text: modelData.role
                                            color: textColor
                                            font.pixelSize: 14
                                            opacity: 0.8
                                            width: parent.width
                                            horizontalAlignment: Text.AlignHCenter
                                        }
                                    }
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: parent.color = "#222222"
                                    onExited: parent.color = "#1a1a1a"
                                    onClicked: {
                                        selectedMember = modelData.name
                                        console.log("Selected member: " + modelData.name)
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // 音乐页面组件
            Component {
                id: musicPage

                Column {
                    anchors.fill: parent
                    spacing: 20

                    Label {
                        text: "DISCOGRAPHY"
                        color: accentColor
                        font.pixelSize: 24
                        font.bold: true
                        font.family: aliceWonderlandFont.name
                    }

                    Grid {
                        width: parent.width
                        columns: 2
                        spacing: 30

                        Repeater {
                            model: [
                                { title: "World's End", year: "2024", img: "assets/images/albums/worlds_end.png", tracks: 12 },
                                { title: "Mythos", year: "2025", img: "assets/images/albums/mythos.png", tracks: 10 },
                                { title: "Eternal Night", year: "2026", img: "assets/images/albums/eternal_night.png", tracks: 8 }
                            ]

                            Rectangle {
                                width: (parent.width - parent.spacing) / 2
                                height: 200
                                color: "#1a1a1a"
                                radius: 8

                                Row {
                                    anchors.fill: parent
                                    anchors.margins: 15
                                    spacing: 20

                                    // 专辑封面
                                    Rectangle {
                                        width: 150
                                        height: 150
                                        color: "transparent"

                                        Image {
                                            source: modelData.img
                                            anchors.fill: parent
                                            fillMode: Image.PreserveAspectFit
                                        }
                                    }

                                    // 专辑信息
                                    Column {
                                        anchors.verticalCenter: parent.verticalCenter
                                        spacing: 10
                                        width: parent.width - 170

                                        Label {
                                            text: modelData.title
                                            color: accentColor
                                            font.pixelSize: 22
                                            font.bold: true
                                            font.family: aliceWonderlandFont.name
                                        }

                                        Label {
                                            text: "Released: " + modelData.year
                                            color: textColor
                                            font.pixelSize: 14
                                        }

                                        Label {
                                            text: "Tracks: " + modelData.tracks
                                            color: textColor
                                            font.pixelSize: 14
                                        }

                                        Button {
                                            text: "LISTEN NOW"
                                            background: Rectangle {
                                                color: parent.down ? "#a89060" :
                                                       parent.hovered ? "#d4b483" : accentColor
                                                radius: 4
                                            }
                                            contentItem: Text {
                                                text: parent.text
                                                color: "#0a0a0a"
                                                font.bold: true
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                            }
                                            onClicked: {
                                                selectedAlbum = modelData.title
                                                console.log("Playing: " + modelData.title)
                                            }
                                        }
                                    }
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: parent.color = "#222222"
                                    onExited: parent.color = "#1a1a1a"
                                }
                            }
                        }
                    }
                }
            }

            // 关于页面组件
            Component {
                id: aboutPage

                Column {
                    anchors.fill: parent
                    spacing: 20

                    Label {
                        text: "ABOUT AVE MUJICA"
                        color: accentColor
                        font.pixelSize: 24
                        font.bold: true
                        font.family: aliceWonderlandFont.name
                    }

                    Rectangle {
                        width: parent.width
                        height: 400
                        color: "#1a1a1a"
                        radius: 8

                        Row {
                            anchors.fill: parent
                            anchors.margins: 30
                            spacing: 40

                            // 乐队Logo大图
                            Rectangle {
                                width: 300
                                height: 300
                                color: "transparent"
                                anchors.verticalCenter: parent.verticalCenter

                                Image {
                                    source: "assets/images/logo.png"
                                    anchors.fill: parent
                                    fillMode: Image.PreserveAspectFit
                                }
                            }

                            // 乐队介绍
                            Column {
                                width: parent.width - 340
                                anchors.verticalCenter: parent.verticalCenter
                                spacing: 15

                                Label {
                                    text: "The Symphony of Myth and Reality"
                                    color: accentColor
                                    font.pixelSize: 20
                                    font.bold: true
                                    font.family: aliceWonderlandFont.name
                                }

                                Label {
                                    text: "Ave Mujica is a conceptual metal band that weaves
intricate tales of mythology, philosophy, and human emotion through their powerful symphonic soundscapes.
Each member represents a different aspect of the human experience, creating a
complete narrative tapestry."
                                    color: textColor
                                    font.pixelSize: 14
                                    wrapMode: Text.WordWrap
                                    lineHeight: 1.4
                                }

                                Label {
                                    text: "Formed in the twilight between reality and fantasy, the
band invites listeners to explore worlds beyond imagination, where
music becomes the gateway to forgotten realms and ancient truths."
                                    color: textColor
                                    font.pixelSize: 14
                                    wrapMode: Text.WordWrap
                                    lineHeight: 1.4
                                }

                                Grid {
                                    width: parent.width
                                    columns: 2
                                    spacing: 10

                                    Repeater {
                                        model: [
                                            "Conceptual Storytelling",
                                            "Symphonic Metal Foundation",
                                            "Theatrical Performances",
                                            "Mythological Themes",
                                            "Orchestral Arrangements",
                                            "Philosophical Lyrics"
                                        ]

                                        Label {
                                            text: "• " + modelData
                                            color: textColor
                                            font.pixelSize: 13
                                            opacity: 0.8
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
