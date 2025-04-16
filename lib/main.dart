
import 'package:chat_app/constant.dart';
import 'package:chat_app/screens/chatpage.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/screens/register.dart';
import 'package:chat_app/screens/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Chat()
  );
}

class Chat extends StatelessWidget {
   Chat({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
   'chat':(context)=>chatpage(),
        'login':(context)=>login(),
        'register':(context)=>register()
      },
      theme: ThemeData(
        primaryColor: primarycolor,
          scaffoldBackgroundColor: Colors.white
      ),
      debugShowCheckedModeBanner: false,
home: welcome(),
    );
  }

}
