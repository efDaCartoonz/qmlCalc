#include "appcore.h"

AppCore::AppCore(QObject *parent, QSettings *settings) : QObject(parent) {
    this->settings = settings;
    mutex = new QMutex;

    timer = new QTimer;
    timer->setInterval(settings->value("calc/interval", 10).toInt() * 1000);

    threadQueueHelper = new QThread;
    threadQueue = new ThreadQueue(this, mutex);
    connect(threadQueueHelper, SIGNAL(started()), threadQueue, SLOT(run()));
    connect(threadQueue, SIGNAL(finished()), threadQueueHelper, SLOT(terminate()));
    connect(this, SIGNAL(sendNewSymol(QString)), threadQueue, SLOT(whenAddNewSymbol(QString)));
    connect(this, SIGNAL(sendDeleteLast()), threadQueue, SLOT(whenNeedDeleteLastSymbol()));
    connect(this, SIGNAL(sendClearCmd()), threadQueue, SLOT(whenNeedClearExpression()));
    connect(threadQueue, SIGNAL(showExpressionValue(QString)), SLOT(whenNeedShowExpressionValue(QString)));
    connect(threadQueue, SIGNAL(showExpressionError(QString)), SLOT(whenNeedShowExpressionError(QString)));
    connect(threadQueue, SIGNAL(showExpressionMessage(QString)), SLOT(whenNeedShowExpressionMessage(QString)));
    connect(threadQueue, SIGNAL(showExpressionCount(int)), SLOT(whenNeedShowExpressionCount(int)));
    threadQueue->moveToThread(threadQueueHelper);
    threadQueueHelper->start();

    threadCalcHelper = new QThread;
    threadCalc = new ThreadCalc(this, mutex);
    connect(threadCalcHelper, SIGNAL(started()), threadCalc, SLOT(run()));
    connect(threadCalc, SIGNAL(finished()), threadCalcHelper, SLOT(terminate()));
    connect(this, SIGNAL(sendCalcInterval(int)), threadCalc, SLOT(whenNeedChangeInterval(int)));
    connect(threadCalc, SIGNAL(showResultCount(int)), SLOT(whenNeedShowResultCount(int)));
    connect(threadCalc, SIGNAL(showExpressionCount(int)), SLOT(whenNeedShowExpressionCount(int)));
    connect(timer, SIGNAL(timeout()), threadCalc, SLOT(whenTimerTimeout()));
    threadCalc->moveToThread(threadCalcHelper);
    threadCalcHelper->start();

    timer->start();
}

void AppCore::saveWindowSize(int width, int height) {
    settings->setValue("window/width", width);
    settings->setValue("window/height", height);
}

void AppCore::saveWindowPosition(int x, int y) {
    settings->setValue("window/x", x);
    settings->setValue("window/y", y);
}

void AppCore::setCalcTimerInterval(QString value) {
    int interval = value.toInt();
    if (interval < 1) {
        emit showError("Недопустимое значение для интервала задержки вычисления");
    }
    else {
        settings->setValue("calc/interval", interval);
        timer->stop();
        timer->setInterval(interval * 1000);
        timer->start();
    }
}

void AppCore::whenGetReqQueueCount(int count) {
    emit showRequestQueueCount(count);
}

void AppCore::whenGetResQueueCount(int count) {
    emit showResultQueueCount(count);
}

void AppCore::whenAddNewSymbol(QString symbol) {
    emit sendNewSymol(symbol);
}

void AppCore::whenDeleteLastSymbol() {
    emit sendDeleteLast();
}

void AppCore::whenClearExpression() {
    emit sendClearCmd();
}

void AppCore::whenNeedShowExpressionValue(QString value) {
    emit showExpressionValue(value);
}

void AppCore::whenNeedShowExpressionError(QString value) {
    emit showError(value);
}

void AppCore::whenNeedShowExpressionMessage(QString message) {
    emit showExpression(message);
}

void AppCore::whenNeedShowExpressionCount(int count) {
    emit showRequestQueueCount(count);
}

void AppCore::whenNeedShowResultCount(int count) {
    emit showResultQueueCount(count);
    QString expression = queueResult.first();
    if (mapErrorResults.keys().contains(expression)) {
        emit showError(QString("При вычислении %1 возникла ошибка: %2").arg(expression, mapErrorResults.value(expression)));
        mapErrorResults.remove(expression);
    }
    else if (mapSuccessResults.keys().contains(expression)) {
        emit showExpressionResult(QString("%1 = %2").arg(expression, QString::number(mapSuccessResults.value(expression))));
        mapSuccessResults.remove(expression);
    }
    queueResult.removeFirst();
    emit showRequestQueueCount(queueResult.length());
}

