import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = "";
  String output = "";
  String operator = "";
  double num1 = 0;
  double num2 = 0;
  bool isOperatorSelected = false;
  bool hasDecimal = false;

  void buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        input = "";
        output = "";
        operator = "";
        num1 = 0;
        num2 = 0;
        isOperatorSelected = false;
        hasDecimal = false;
      } else if (value == "=") {
        if (operator.isNotEmpty && input.isNotEmpty) {
          num2 = double.parse(input);
          switch (operator) {
            case "+":
              output = (num1 + num2).toString();
              break;
            case "-":
              output = (num1 - num2).toString();
              break;
            case "*":
              output = (num1 * num2).toString();
              break;
            case "/":
              output = num2 != 0 ? (num1 / num2).toString() : "Error";
              break;
          }
          input = output;
          isOperatorSelected = false;
          hasDecimal = input.contains(".");
        }
      } else if (value == "+" || value == "-" || value == "*" || value == "/") {
        if (input.isNotEmpty) {
          num1 = double.parse(input);
          operator = value;
          isOperatorSelected = true;
          input = "";
          hasDecimal = false;
        }
      } else if (value == ".") {
        if (!hasDecimal) {
          input += value;
          hasDecimal = true;
        }
      } else {
        input += value;
      }
    });
  }

  Widget buildButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => buttonPressed(text),
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(16),
              child: Text(
                input.isEmpty ? output : input,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [buildButton("7"), buildButton("8"), buildButton("9"), buildButton("/")],
              ),
              Row(
                children: [buildButton("4"), buildButton("5"), buildButton("6"), buildButton("*")],
              ),
              Row(
                children: [buildButton("1"), buildButton("2"), buildButton("3"), buildButton("-")],
              ),
              Row(
                children: [buildButton("0"), buildButton("."), buildButton("="), buildButton("+")],
              ),
              Row(
                children: [buildButton("C")],
              ),
            ],
          )
        ],
      ),
    );
  }
}
