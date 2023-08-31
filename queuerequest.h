#ifndef QUEUEREQUEST_H
#define QUEUEREQUEST_H

#include <QObject>

class QueueRequest : public QObject
{
    Q_OBJECT
public:
    explicit QueueRequest(QObject *parent = 0);

signals:

public slots:
};

#endif // QUEUEREQUEST_H