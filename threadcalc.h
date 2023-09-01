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
    void run();              // запуск обработчика событий
    void whenTimerTimeout(); // инициализация вычисления

signals:
    void showExpressionResult(QString expression, double result);    // отобразить сообщение о успешном результате вычисления
    void showExpressionError(QString expression, QString strError);  // отобразить сообщение о ошибке при вычислении
    void showExpressionCount(int count);                             // отобразить длину очереди запросов
    void showResultCount(int count);                                 // отобразить длину очереди результатов

private:
    QObject *parent; // для доступа к контейнерам очередей
    QMutex *mutex;   // для обеспечении безопасности при работе с данными

private slots:
};

#endif // THREADCALC_H
