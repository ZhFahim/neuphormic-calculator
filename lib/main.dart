import 'package:flutter/material.dart';
import 'package:neumorphic_calculator/screens/calculator_screen.dart';
import 'package:provider/provider.dart';
import 'package:neumorphic_calculator/calculator_brain.dart';

void main() {
  runApp(
    ChangeNotifierProvider<CalculatorBrain>(
      create: (context) => CalculatorBrain(),
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.grey[300],
          body: Calculator(),
        ),
      ),
    ),
  );
}
