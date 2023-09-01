#ifndef CALCULATOR_H
#define CALCULATOR_H

#include <iostream>

enum Operations {
    ADDIT = 0,
    SUBTRACT,
    MULTIPLY,
    DIVIDE,
};

class Calculator
{
public:
    Calculator();
    static double calculateExpression(int typeOper, double operand1, double operand2); // метод для вычисления
};

#endif // CALCULATOR_H
