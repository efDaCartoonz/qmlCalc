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

    QStringList queueRequest;
    QStringList queueResult;
    QMap <QString, QList <double> *> mapOperands;
    QMap <QString, QList <int> *> mapOperations;
    QMap <QString, double> mapSuccessResults;
    QMap <QString, QString> mapErrorResults;

public slots:
    void saveWindowSize(int width, int height);
    void saveWindowPosition(int x, int y);
    void setCalcTimerInterval(QString value);

    void whenGetReqQueueCount(int count);
    void whenGetResQueueCount(int count);
    void whenAddNewSymbol(QString symbol);
    void whenDeleteLastSymbol();
    void whenClearExpression();

signals:
    void sendNewSymol(QString symbol);
    void sendClearCmd();
    void sendDeleteLast();

    void showRequestQueueCount(int count);
    void showResultQueueCount(int count);
    void showExpressionValue(QString value);
    void showExpressionClear(QString value);
    void showError(QString message);
    void showExpression(QString message);
    void showExpressionResult(QString message);
    void showExpressionError(QString message);
    void sendExpression(QString expression, QList <double> *operands, QList <int> *operations);
    void sendCalcInterval(int interval);

private:
    QSettings *settings;
    QMutex *mutex;
    QTimer *timer;
    QThread *threadCalcHelper, *threadQueueHelper;
    ThreadCalc *threadCalc;
    ThreadQueue *threadQueue;

private slots:
    void whenNeedShowExpressionValue(QString value);
    void whenNeedShowExpressionError(QString value);
    void whenNeedShowExpressionMessage(QString message);
    void whenNeedShowExpressionCount(int count);
    void whenNeedShowResultCount(int count);
};

#endif // APPCORE_H
