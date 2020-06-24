import 'package:flutter/material.dart';
import 'package:neumorphic_calculator/widgets/button.dart';
import 'package:neumorphic_calculator/calculator_brain.dart';
import 'package:provider/provider.dart';
import 'package:neumorphic_calculator/utils/constants.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  CalculatorBrain calculatorBrain = CalculatorBrain();

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorBrain>(
      builder: (context, calculatorBrain, child) {
        return Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView(
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      children: <Widget>[
                        Text(
                          calculatorBrain.userInput,
                          style: kDisplayTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.centerRight,
                      child: Text(
                        calculatorBrain.userAnswer,
                        style: kDisplayTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: calculatorBrain.buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MyButton(
                        onTap: () {
                          calculatorBrain.reset();
                        },
                        buttonText: calculatorBrain.buttons[index],
                        textColor: Colors.red[700],
                      );
                    } else if (index == 1) {
                      return MyButton(
                        onTap: () {
                          calculatorBrain.del();
                        },
                        buttonText: calculatorBrain.buttons[index],
                        textColor: Colors.yellow[900],
                      );
                    } else if (index == calculatorBrain.buttons.length - 1) {
                      return MyButton(
                        onTap: () {
                          calculatorBrain.calculate();
                        },
                        buttonText: calculatorBrain.buttons[index],
                        textColor: Colors.deepPurple[700],
                      );
                    } else {
                      return MyButton(
                        onTap: () {
                          calculatorBrain.inputBtn(index);
                        },
                        buttonText: calculatorBrain.buttons[index],
                        textColor: calculatorBrain
                                .isOperator(calculatorBrain.buttons[index])
                            ? Colors.deepPurple[700]
                            : Colors.grey[700],
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
