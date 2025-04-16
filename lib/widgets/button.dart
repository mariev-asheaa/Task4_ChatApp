import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class button extends StatelessWidget {
   button({super.key,required this.ontap,required this.label,required this.color,required this.textcolor});
String label;
Color color,textcolor;
VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: ontap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
          height: 60,
          width: 350,
            decoration: BoxDecoration(
                color: color,
                    borderRadius: BorderRadius.circular(20)
            ),

         child: Center(
                child: Text(label,
                style: TextStyle(
                    color: textcolor,
                  fontSize: 25
                ),
                ),

              ),
            ),
          ],
        ),
      );

  }
}
