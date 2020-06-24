import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'package:math_expressions/math_expressions.dart';

class CalculatorBrain extends ChangeNotifier {
  String userInput = '';
  String userAnswer = '0';
  double result = 0;

  final List<String> _buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  UnmodifiableListView get buttons {
    return UnmodifiableListView(_buttons);
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void del() {
    if (userInput.length > 0) {
      if (userInput[userInput.length - 1] == 'S') {
        userInput = userInput.substring(0, userInput.length - 3);
      } else {
        userInput = userInput.substring(0, userInput.length - 1);
      }
    }
    notifyListeners();
  }

  void inputBtn(int index) {
    if (isOperator(_buttons[index]) &&
        userInput.length > 0 &&
        isOperator(userInput[userInput.length - 1])) {
      userInput =
          userInput.substring(0, userInput.length - 1) + _buttons[index];
    } else {
      userInput += _buttons[index];
    }
    notifyListeners();
  }

  void calculate() {
    String inputExpression = userInput.toString();

    inputExpression = inputExpression.replaceAll('x', '*');

    Variable ans = Variable('ANS');
    Parser p = Parser();
    try {
      p.parse(inputExpression);
    } catch (e) {
      userAnswer = 'Bad Expression';
      notifyListeners();
      return;
    }

    Expression exp = p.parse(inputExpression);

    ContextModel cm = ContextModel();
    cm.bindVariable(ans, Number(result));

    try {
      exp.evaluate(EvaluationType.REAL, cm);
    } catch (e) {
      userAnswer = 'Bad Expression';
      notifyListeners();
      return;
    }

    double eval = exp.evaluate(EvaluationType.REAL, cm);
    result = eval;

    userAnswer = result.toString();

    notifyListeners();
  }

  void reset() {
    userInput = '';
    userAnswer = '0';
    result = 0;
    notifyListeners();
  }
}
