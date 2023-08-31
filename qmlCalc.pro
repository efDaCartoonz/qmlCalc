TEMPLATE = app

QT += qml quick widgets
CONFIG += c++11

INSTALLS += target

SOURCES += main.cpp \
    appcore.cpp \
    calculator.cpp \
    threadcalc.cpp \
    threadqueue.cpp

RESOURCES += qml.qrc


# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    appcore.h \
    calculator.h \
    threadcalc.h \
    threadqueue.h
