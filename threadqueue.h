#ifndef THREADQUEUE_H
#define THREADQUEUE_H

#include <QObject>
#include <QThread>
#include <QMutex>
#include <QMap>
#include "calculator.h"

class ThreadQueue : public QThread
{
    Q_OBJECT

public:
    explicit ThreadQueue(QObject *parent, QMutex *mutex);

public slots:
    void run();
    void whenAddNewSymbol(QString symbol);
    void whenNeedDeleteLastSymbol();
    void whenNeedClearExpression();

signals:
    void showExpressionValue(QString);
    void showExpressionError(QString);
    void showExpressionMessage(QString);
    void showExpressionCount(int);

private:
    int checkPosition;

    QString expressionValue;
    QList <double> *listOperands;
    QList <int> *listOperations;

    QMutex *mutex;
    QObject *parent;
};

#endif // THREADQUEUE_H
