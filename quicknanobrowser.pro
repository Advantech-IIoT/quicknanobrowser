requires(qtConfig(accessibility))

TEMPLATE = app
TARGET = quicknanobrowser

HEADERS = utils.h
SOURCES = main.cpp

OTHER_FILES += ApplicationRoot.qml \
               BrowserDialog.qml \
               BrowserWindow.qml \
               DownloadView.qml \
               FindBar.qml \
               FullScreenNotification.qml

RESOURCES += resources.qrc

QT += qml quick webengine

qtHaveModule(widgets) {
    QT += widgets # QApplication is required to get native styling with QtQuickControls
}

# output directory
OBJECTS_DIR = _obj
MOC_DIR = _autogen
DESTDIR = output

# qt virtualkeyboard
static {
    QT += svg
    QTPLUGIN += qtvirtualkeyboardplugin
}

target.path = $$[QT_INSTALL_EXAMPLES]/webengine/quicknanobrowser
INSTALLS += target
