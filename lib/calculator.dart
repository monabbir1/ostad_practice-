import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ostad_prac/Widget/button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _output = '0';
  String _input = '';
  String operand = '';
  double num1=0;
  double num2=0;
  void buttonPressed(String value){
    setState(() {
      if(value == 'C'){
        _output = '0';
        _input = '';
        operand = '';
        num1=0;
        num2=0;
      }
      else if(value == "="){
        num2 = double.parse(_input);
        if(operand == '+'){
          _output = (num1+num2).toString();
        }else if (operand == '-'){
          _output = (num1-num2).toString();
        }else if (operand == 'x'){
          _output = (num1*num2).toString();
        }else if (operand == '/'){
          _output = (num2 !=0)?(num1/num2).toString():"Error";
        }  _input = _output;
      }
      else if (['+','-','*','/'].contains(value)){
        num1 = double.parse(_input);
        operand = value;
        _input = '';
      }else{
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
        title: Text(
          'Calculator',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(15),
              child: Text(_output,style: TextStyle(color: Colors.white,fontSize: 40),),
            ),
          ),
          Row(
            children: [
              button(text: '7', onTab:()=> buttonPressed('7'),),
              button(text: '8', onTab:()=> buttonPressed('8'),),
              button(text: '9',onTab:()=> buttonPressed('9'),),
              button(text: '/',color: Colors.teal,onTab:()=> buttonPressed('/'),),
            ],
          ),
          Row(
            children: [
              button(text: '4',onTab:()=> buttonPressed('4'),),
              button(text: '5',onTab:()=> buttonPressed('5'),),
              button(text: '6',onTab:()=> buttonPressed('6'),),
              button(text: 'x',color: Colors.teal,onTab:()=> buttonPressed('*'),),
            ],
          ),
          Row(
            children: [
              button(text: '1',onTab:()=> buttonPressed('1'),),
              button(text: '2',onTab:()=> buttonPressed('2'),),
              button(text: '3',onTab:()=> buttonPressed('3'),),
              button(text: '-',color: Colors.teal,onTab:()=> buttonPressed('-'),),
            ],
          ),
          Row(
            children: [
              button(text: 'C',color: Colors.red,onTab:()=> buttonPressed('C'),),
              button(text: '0',onTab:()=> buttonPressed('0'),),
              button(text: '=',color: Colors.green,onTab:()=> buttonPressed('='),),
              button(text: '+',color: Colors.teal,onTab:()=> buttonPressed('+'),),
            ],
          ),
        ],
      ),
    );
  }
}

