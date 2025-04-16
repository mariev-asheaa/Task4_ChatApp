
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import '../constant.dart';

class social extends StatelessWidget {
   var image;
   social({super.key,required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        height: 50,
        width: 70,
        decoration: BoxDecoration(
            color: kPrimaryLightColor,
            border:Border.all(
                width:10,
                color: kPrimaryLightColor
            ),
            shape:BoxShape.circle
        ),
        child:  SvgPicture.asset(image,color: Colors.white,),
      ),
    );
  }
}
