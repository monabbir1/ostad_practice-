import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      home: Home(),);
  }
}
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Name'
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Age'
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Salary'
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){}, child: Text('Add Employee'))
          ],
        ),
      ),
    );
  }
}
