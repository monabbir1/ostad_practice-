import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class waterBtn extends StatelessWidget {
  String buttonName;
  IconData? icon;
  VoidCallback onTab;
   waterBtn({
    super.key,required this.buttonName,this.icon, required this.onTab
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(onPressed: onTab,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            minimumSize: Size(double.infinity, 40)
        ),
        label: Text("+ ${buttonName} ml",style: TextStyle(color: Colors.white),),icon: Icon(icon,color: Colors.white,),),
    );
  }
}