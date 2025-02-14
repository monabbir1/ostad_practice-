import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class button extends StatelessWidget {
  String text;
  Color ? color;
  final VoidCallback onTab;
   button({
    super.key, required this.text,this.color, required this.onTab
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(onPressed: onTab,
            style: ElevatedButton.styleFrom(
                backgroundColor: color ?? Colors.grey[800],
                padding: EdgeInsets.all(25),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                )
            ),
            child: Text(text,style: TextStyle(color: Colors.white,fontSize: 20),)),
      ),
    );
  }
}
