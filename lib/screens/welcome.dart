import 'package:chat_app/constant.dart';
import 'package:chat_app/widgets/background.dart';
import 'package:chat_app/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class welcome extends StatelessWidget {
   welcome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
body:ListView(
  children: [background(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Welcome to WECHAT,Start texting now',style: TextStyle(
          fontWeight: FontWeight.bold,
              fontSize: 20
        )
          ,),
       SvgPicture.asset('assets/icons/chat.svg',),
  SizedBox(
    height: 40,
  ),
  button(ontap: (){
   Navigator.pushNamed(context, 'login');
  },
      color: kPrimaryLightColor,
      textcolor: Colors.white,
      label: 'log in'),
        SizedBox(
          height: 30,
        ),
  button(ontap: (){

    Navigator.pushNamed(context,'register');
  },
      color: purp,
      textcolor: Colors.black,
      label: 'Sign Up')
      ],
    ),
  ),]
),

    );
  }
}
