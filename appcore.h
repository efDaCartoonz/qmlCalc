#ifndef APPCORE_H
#define APPCORE_H

#include <QObject>
#include <QSettings>
#include <QFileInfo>
#include <QTextCodec>
#include <QDebug>
#include <QTimer>

#include "threadqueue.h"
#include "threadcalc.h"


class AppCore : public QObject
{
    Q_OBJECT
public:
    explicit AppCore(QObject *parent, QSettings *settings);

    QStringList queueRequest; // очередь запросов
    QStringList queueResult;  // очередь результатов
    QMap <QString, QList <double> *> mapOperands; // дополнительные данные о операндах вычисления
    QMap <QString, QList <int> *> mapOperations;  // дополнительные данные о операциях вычисления
    QMap <QString, double> mapSuccessResults;     // дополнительные данные о успешных вычислениях
    QMap <QString, QString> mapErrorResults;      // дополнительные данные о ошибочных вычислениях

public slots:
    void saveWindowSize(int width, int height); // сохранить в файл настройки размер окна
    void saveWindowPosition(int x, int y);      // сохранить в файл настройки положение окна
    void setCalcTimerInterval(QString value);   // изменить и сохранить интервал вычислений
    void whenAddNewSymbol(QString symbol); // получен сигнал о вводе нового символа в выражение
    void whenDeleteLastSymbol();           // получен сигнал о удалении посленего символа выражения
    void whenClearExpression();            // получен сигнал о очистке строки выражения

signals:
    void sendNewSymol(QString symbol); // добавить новый символ в выражение
    void sendClearCmd();               // очистить текущее выражение
    void sendDeleteLast();             // удалить последний символ в выражении
    void showRequestQueueCount(int count);       // отобразить длину очереди запросов
    void showResultQueueCount(int count);        // отобразить длину очереди ответов
    void showExpressionValue(QString value);     // отобразить текущее выражение
    void showExpressionWarning(QString message); // отобразить сообщение с предупреждением
    void showError(QString message);             // отобразить сообщение об ошибке
    void showExpressionInQueue(QString message); // отобразить выражение, помещённое в очередь запросов
    void showExpressionResult(QString message);  // отобразить результат вычисления

private:
    QSettings *settings; // настройки приложения (размер и положение окна и интервал вычислений)
    QMutex *mutex;       // защита контейнеров очередей от одновременного изменения потоками
    QTimer *timer;       // инициализатор вычисления
    QThread *threadCalcHelper, *threadQueueHelper;
    ThreadCalc *threadCalc;   // поток вычисления
    ThreadQueue *threadQueue; // поток формирования очереди запроса

private slots:
    void whenNeedShowExpressionValue(QString value);     // получен сигнал о отображении выражения на экран
    void whenNeedShowExpressionWarning(QString message); // получен сигнал о отображении сообщения с предупреждением
    void whenNeedShowExpressionError(QString value);     // получен сигнал о отображении сообщения об ошибке
    void whenNeedShowExpressionMessage(QString message); // получен сигнал о отображении выражения, помещённого в очередь запросов
    void whenNeedShowExpressionCount(int count); // получен сигнал о отображении размера очереди запросов
    void whenNeedShowResultCount(int count);     // получен сигнал о отображении размера очереди результатов
};

#endif // APPCORE_H
