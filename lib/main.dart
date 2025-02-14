import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ostad_prac/WaterTrakar.dart';
import 'package:ostad_prac/main.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Watertraker(),
    );
  }
}
