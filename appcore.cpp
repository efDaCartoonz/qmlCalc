#include "appcore.h"

AppCore::AppCore(QObject *parent, QSettings *settings) : QObject(parent) {
    this->settings = settings;
}

void AppCore::saveWindowSize(int width, int height) {
    settings->setValue("window/width", width);
    settings->setValue("window/height", height);
}

void AppCore::saveWindowPosition(int x, int y) {
    settings->setValue("window/x", x);
    settings->setValue("window/y", y);
}

