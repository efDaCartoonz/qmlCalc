#ifndef THREADQUEUE_H
#define THREADQUEUE_H

#include <QObject>
#include <QThread>
#include <QMutex>
#include <QMap>
#include <QDateTime>
#include "calculator.h"

class ThreadQueue : public QThread
{
    Q_OBJECT

public:
    explicit ThreadQueue(QObject *parent, QMutex *mutex);

public slots:
    void run();                            // запуск обработчика событий
    void whenAddNewSymbol(QString symbol); // получен сигнал о вводе нового симвода
    void whenNeedDeleteLastSymbol();       // получен сигнал о удалении последнего символа
    void whenNeedClearExpression();        // получен сигнал о удалении всей строки выражения

signals:
    void showExpressionValue(QString);   // отобразить текущее выражение
    void showExpressionError(QString);   // отобразить сообщение об ошибке
    void showExpressionWarning(QString); // отобразить сообщение с предупреждением
    void showExpressionMessage(QString); // отобразить выражение, помещённое в очередь запросов
    void showExpressionCount(int);       // отобразить длину очереди запросов

private:
    int checkPosition;             // позиция первого симола последнего числа в строке

    QString expressionValue;       // строка выражения
    QList <double> *listOperands;  // список операндов
    QList <int> *listOperations;   // список операций

    QObject *parent; // для доступа к контейнерам очередей
    QMutex *mutex;   // для обеспечении безопасности при работе с данными
};

#endif // THREADQUEUE_H
