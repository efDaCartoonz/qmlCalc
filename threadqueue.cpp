#include "threadqueue.h"
#include "appcore.h"

ThreadQueue::ThreadQueue(QObject *parent, QMutex *mutex) {
    this->mutex = mutex;
    this->parent = parent;
    checkPosition = 0;
    listOperands = new QList <double>;
    listOperations = new QList <int>;
}

void ThreadQueue::run() {
    this->exec();
}

void ThreadQueue::whenAddNewSymbol(QString symbol) {
    if (symbol == "=") {
        if (expressionValue.length() > checkPosition) {
            QString number = expressionValue.mid(checkPosition);
            listOperands->append(number.toDouble());
        }
        if (listOperations->length() > 0 and listOperations->length() == listOperands->length() - 1) {
            AppCore *appCore = static_cast <AppCore *> (this->parent);
            int queueCount = 0;
            expressionValue = QString("%1:%2").arg(QDateTime::currentDateTime().toString("yyyyMMddhhmmss"), expressionValue);
            mutex->lock();
            appCore->queueRequest.append(expressionValue);
            appCore->mapOperands.insert(expressionValue, listOperands);
            appCore->mapOperations.insert(expressionValue, listOperations);
            queueCount = appCore->queueRequest.length();
            mutex->unlock();
            emit showExpressionMessage(QString("Выражение %1 добавлено в очередь").arg(expressionValue.split(":").at(1)));
            emit showExpressionCount(queueCount);
            listOperands = new QList <double>;
            listOperations = new QList <int>;
            expressionValue = "";
            checkPosition = 0;
        }
        else if (listOperations->length() > 0 and listOperations->length() == listOperands->length()) {
            emit showExpressionError("Не указано последнее число в выражении после операции");
        }
        else {
            emit showExpressionError("Нечего вычислять");
        }
    }
    else if (symbol == "+" or symbol == "-" or symbol == "*" or symbol == "/") {
        QString previousSymb = expressionValue.right(1);
        if (previousSymb == "+" or previousSymb == "-" or previousSymb == "*" or previousSymb == "/") {
            emit showExpressionError("Между операциями вычисления должно быть число");
        }
        else {
            if (expressionValue.length() == 0) {
                expressionValue = "0";
            }
            QString number = expressionValue.mid(checkPosition);
            listOperands->append(number.toDouble());
            if (symbol == "+") listOperations->append(ADDIT);
            else if (symbol == "-") listOperations->append(SUBTRACT);
            else if (symbol == "*") listOperations->append(MULTIPLY);
            else if (symbol == "/") listOperations->append(DIVIDE);
            expressionValue += symbol;
            checkPosition = expressionValue.length();
        }
    }
    else if (symbol == ".") {
        QString number = expressionValue.mid(checkPosition) + symbol;
        if (number != "0." and number != "." and number.toDouble() == 0.0) {
            emit showExpressionError("У числа уже есть дробный разделитель");
        }
        else {
            expressionValue += symbol;
        }
    }
    else {
        expressionValue += symbol;
        if (expressionValue.length() - checkPosition > 9) {
            emit showExpressionWarning(QString("Число %1 слишком длинное, возможна потеря точности при вычислении").arg(expressionValue.mid(checkPosition)));
        }
    }
    emit showExpressionValue(expressionValue);
}

void ThreadQueue::whenNeedDeleteLastSymbol() {
    QString lastSymbol = expressionValue.right(1);
    if (lastSymbol == "+" or lastSymbol == "-" or lastSymbol == "*" or lastSymbol == "/") {
        checkPosition -= QString::number(listOperands->last()).length() + 1;
        listOperands->removeLast();
        listOperations->removeLast();
    }
    expressionValue = expressionValue.mid(0, expressionValue.length()-1);
    emit showExpressionValue(expressionValue);
}

void ThreadQueue::whenNeedClearExpression() {
    expressionValue = "";
    listOperands->clear();
    listOperations->clear();
    checkPosition = 0;
    emit showExpressionValue(expressionValue);
}
