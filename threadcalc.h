#ifndef THREADCALC_H
#define THREADCALC_H

#include <QObject>
#include <QThread>
#include <QMutex>
#include <QMap>
#include "calculator.h"

class ThreadCalc : public QThread
{
    Q_OBJECT

public:
    explicit ThreadCalc(QObject *parent, QMutex *mutex);

public slots:
    void run();
    void whenTimerTimeout();

signals:
    void showExpressionResult(QString expression, double result);
    void showExpressionError(QString expression, QString strError);
    void showExpressionCount(int count);
    void showResultCount(int count);
    void finishCalc();

private:
    QMutex *mutex;
    QObject *parent;

    Calculator calc;
//    QTimer *timer;

private slots:
};

#endif // THREADCALC_H
