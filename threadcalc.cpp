#include "threadcalc.h"
#include "appcore.h"

ThreadCalc::ThreadCalc(QObject *parent, QMutex *mutex) {
    this->mutex = mutex;
    this->parent = parent;
}

void ThreadCalc::run() {
    this->exec();
}

void ThreadCalc::whenTimerTimeout() {
    QString expression;
    QList <double> *operands;
    QList <int> *operations;
    int expressionCount = 0;
    mutex->lock();
    AppCore *appCore = static_cast <AppCore *> (this->parent);
    expressionCount = appCore->queueRequest.length();
    if (expressionCount > 0) {
        expression = appCore->queueRequest.first();
        operands = appCore->mapOperands.value(expression);
        operations = appCore->mapOperations.value(expression);
        appCore->queueRequest.removeFirst();
        appCore->mapOperands.remove(expression);
        appCore->mapOperations.remove(expression);
    }
    mutex->unlock();
    if (expressionCount > 0) {
        expressionCount--;
        int resultCount = 0;
        double result = operands->at(0);
        bool isError = false;
        for (int i = 0; i < operations->length(); i++) {
            try {
                result = calc.calculateExpression(operations->at(i), result, operands->at(i+1));
            }
            catch (std::exception &e) {
                mutex->lock();
                appCore->queueResult.append(expression);
                appCore->mapErrorResults.insert(expression, QString(e.what()));
                resultCount = appCore->queueResult.length();
                mutex->unlock();
                isError = true;
                break;
            }
        }
        if (!isError) {
            mutex->lock();
            appCore->queueResult.append(expression);
            appCore->mapSuccessResults.insert(expression, result);
            resultCount = appCore->queueResult.length();
            mutex->unlock();
        }
//        emit finishCalc();
        emit showResultCount(resultCount);
    }
    emit showExpressionCount(expressionCount);
}
