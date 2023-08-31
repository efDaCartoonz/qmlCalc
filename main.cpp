#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "appcore.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF-8"));
    QFileInfo fileInfo(qApp->applicationFilePath());
    QSettings *settings = new QSettings(QString("%1/%2.ini").arg(fileInfo.absolutePath(), fileInfo.baseName()), QSettings::IniFormat);
    settings->setIniCodec(QTextCodec::codecForLocale());

    AppCore *appCore = new AppCore(nullptr, settings);

    QQmlContext *context = engine.rootContext();
    context->setContextProperty("appCore", appCore);
    context->setContextProperty("winWidth", settings->value("window/width", 640));
    context->setContextProperty("winHeight", settings->value("window/height", 480));
    context->setContextProperty("winX", settings->value("window/x", 0));
    context->setContextProperty("winY", settings->value("window/y", 0));
    context->setContextProperty("calcInterval", settings->value("calc/interval", 10));

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
