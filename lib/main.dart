import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ostad_prac/Widget/button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _output = "0";
  String _input = "";
  String operand = "";
  double num1 = 0;
  double num2 = 0;
  void ButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _input = "";
        operand = "";
        num1 = 0;
        num2 = 0;
      } else if (value == "=") {
        num2 = double.parse(_input);
        if (operand == '+') {
          _output = (num1 + num2).toString();
        } else if (operand == '-') {
          _output = (num1 - num2).toString();
        } else if (operand == '*') {
          _output = (num1 * num2).toString();
        } else if (operand == '/') {
          _output = (num2 != 0) ? (num1 / num2).toString() : "Error";
        }
        _input = _output;
      } else if (['+', '-', '*', '/'].contains(value)) {
        num1 = double.parse(_input);
        _input = '';
      } else {
        _input += value;
        _output = _input;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Calculator'),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(15),
              child: Text(
                _output,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: [
              button(text: '7', onTab:()=> ButtonPressed('7'),),
              button(text: '8', onTab:()=> ButtonPressed('8'),),
              button(text: '9', onTab:()=> ButtonPressed('9'),),
              button(
                text: '/',
                color: Colors.amber,onTab:()=> ButtonPressed('/'),
              ),
            ],
          ),
          Row(
            children: [
              button(text: '4', onTab:()=> ButtonPressed('4'),),
              button(text: '5', onTab:()=> ButtonPressed('5'),),
              button(text: '6', onTab:()=> ButtonPressed('6'),),
              button(
                text: 'x',
                color: Colors.amber, onTab:()=> ButtonPressed('*'),
              ),
            ],
          ),
          Row(
            children: [
              button(text: '1', onTab:()=> ButtonPressed('1'),),
              button(text: '2', onTab:()=> ButtonPressed('2'),),
              button(text: '3', onTab:()=> ButtonPressed('3'),),
              button(
                text: '-',
                color: Colors.amber, onTab:()=> ButtonPressed('-'),
              ),
            ],
          ),
          Row(
            children: [
              button(
                text: 'C', onTab:()=> ButtonPressed('C'),
                color: Colors.red,
              ),
              button(text: '0', onTab:()=> ButtonPressed('0'),),
              button(
                text: '=', onTab:()=> ButtonPressed('='),
                color: Colors.green,
              ),
              button(
                text: '+', onTab:()=> ButtonPressed('+'),
                color: Colors.amber,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
