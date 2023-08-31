#ifndef QUEUERESULT_H
#define QUEUERESULT_H

#include <QObject>

class QueueResult : public QObject
{
    Q_OBJECT
public:
    explicit QueueResult(QObject *parent = 0);

signals:

public slots:
};

#endif // QUEUERESULT_H