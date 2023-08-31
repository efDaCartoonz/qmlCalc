#ifndef APPCORE_H
#define APPCORE_H

#include <QObject>
#include <QSettings>
#include <QFileInfo>
#include <QTextCodec>
#include <QDebug>

class AppCore : public QObject
{
    Q_OBJECT
public:
    explicit AppCore(QObject *parent, QSettings *settings);

public slots:
    void saveWindowSize(int width, int height);
    void saveWindowPosition(int x, int y);

signals:
    void sendToQml(int count);

private:
    QSettings *settings;

};

#endif // APPCORE_H
