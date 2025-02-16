import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ostad_prac/Widget/waterBtn.dart';

class Watertraker extends StatefulWidget {
   Watertraker({super.key});

  @override
  State<Watertraker> createState() => _WatertrakerState();
}

class _WatertrakerState extends State<Watertraker> {
  @override
  int _tekeWater = 0;
  final int _goal = 2000;

  void _addWater (int amount){
    setState(() {
      if(_tekeWater <_goal){
        _tekeWater = (_tekeWater+amount).clamp(0, _goal);
      }
    });
  }
  void _reset (){
    setState(() {
      _tekeWater = 0;
    });
  }

@override
  Widget build(BuildContext context) {
    double progress = (_tekeWater/_goal).clamp(0.0, 1.0);
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Track'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      backgroundColor: Colors.blue[100],
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 10,
                        offset: Offset(5, 5))
                  ]),
              child: Column(
                children: [
                  Text(
                    "Today's Water",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  Text(
                    "${_tekeWater} ml",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.blue),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 130,
                  height: 130,
                  child: CircularProgressIndicator(
                    value: 1,
                    color: Colors.blue,
                    backgroundColor: Colors.grey[400],
                    strokeWidth: 10,
                  ),
                ),
                Text(
                  "${(progress * 100).toInt()}%",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Wrap(
              children: [
                waterBtn(
                  buttonName: '200',
                  icon: Icons.local_drink, onTab:()=> _addWater(200),
                ),
                waterBtn(
                  buttonName: '100',
                  icon: Icons.local_drink,onTab:()=> _addWater(100)
                ),
                waterBtn(
                  buttonName: '50',
                  icon: Icons.local_drink,onTab:()=> _addWater(50)
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed:  _reset,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: Size(double.infinity, 40)),
                label: Text(
                  'Reset',
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(
                  Icons.lock_reset,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
