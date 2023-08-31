
#include "calculator.h"

Calculator::Calculator() {

}

double Calculator::calculateExpression(int typeOper, double operand1, double operand2) {
    double result;
    switch(typeOper) {
    case ADDIT:
        result = operand1 + operand2;
        break;
    case SUBTRACT:
        result = operand1 - operand2;
        break;
    case MULTIPLY:
        result = operand1 * operand2;
        break;
    case DIVIDE:
        if (operand2 == 0) {
            throw std::overflow_error("Деление на ноль");
        }
        else {
            result = operand1 / operand2;
        }
        break;
    default:
        throw std::invalid_argument("Недопустимый тип операции");
    }
    return result;
}
