#ifndef APPCORE_H
#define APPCORE_H

#include <QObject>

class AppCore : public QObject
{
    Q_OBJECT
public:
    explicit AppCore(QObject *parent = 0);

signals:
    void sendToQml(int count);

public slots:
    void receiveFromQml();

private:
    int count;
};

#endif // APPCORE_H
