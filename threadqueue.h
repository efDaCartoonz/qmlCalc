#ifndef THREADQUEUE_H
#define THREADQUEUE_H

#include <QObject>

class ThreadQueue : public QThread
{
public:
    ThreadQueue();
};

#endif // THREADQUEUE_H