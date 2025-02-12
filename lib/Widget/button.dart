import 'package:flutter/material.dart';

class button extends StatelessWidget {
  String text;
  Color ? color;
  Color ? textColor;
  final VoidCallback onTab;
  button({
    super.key,
    required this.text,this.color,this.textColor, required this.onTab
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
            child: Text(text,style:TextStyle(color: textColor ?? Colors.white,fontSize: 20),)),
      ),
    );
  }
}
