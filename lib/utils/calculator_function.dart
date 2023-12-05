import 'package:math_expressions/math_expressions.dart';

class CalculatorFunctions {
  String expression = "";
  String result = "";

  void performButtonAction(String buttonText) {
    if (buttonText == "C") {
      expression = "";
      result = "";
    } else if (buttonText == '⌫') {
      if (expression.isEmpty) {
        return;
      }
      expression = expression.substring(0, expression.length - 1);
    } else if (buttonText == '=') {
      try {
        Parser parser = Parser();
        Expression exp = parser.parse(expression);
        ContextModel context = ContextModel();
        final evaluatedExpression = exp.evaluate(
          EvaluationType.REAL,
          context,
        );
        result =
            '${isInteger(evaluatedExpression) ? (evaluatedExpression as num).ceil() : '$evaluatedExpression'}';
        expression = result;
      } catch (e) {
        result = 'Error $e';
      }
    } else {
      expression += buttonText;
    }
  }
}

// Create a function that determines if a router is an integer or null
bool isInteger(num value) => value is int || value == value.roundToDouble();
