import 'package:chat_app/bloc/auth_bloc.dart';
import 'package:chat_app/constant.dart';
import 'package:chat_app/screens/register.dart';
import 'package:chat_app/widgets/background.dart';
import 'package:chat_app/widgets/button.dart';
import 'package:chat_app/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class login extends StatefulWidget {
  login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  //variables in stateful widget must be after _state
  late String email;

  late String password;

  GlobalKey<FormState>formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
             if (state is Loginsucces) {
                isloading = false;
              Navigator.pushNamed(context, 'chat',arguments: email);
            }
            else if(state is Loginfailur){
                isloading = false;
              ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content:
                  Text(state.errormessage)
                  ));
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: primarycolor,
              body: Form(
                key: formkey,
                child: background(
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(120),
                            child: SvgPicture.asset('assets/icons/login.svg'),
                          ),

                        ],
                      )
                      ,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('We Chat', style: TextStyle(

                              fontSize: 40,
                              color: Color(0xff283618)
                          ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        textformfield(
                          onchanged: (data) {
                            email = data;
                          },
                          icon: const Icon(
                            Icons.email, color: kPrimaryLightColor,),
                          hinttext: 'Your Email',),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        textformfield(
                          obsecure: true,
                          onchanged: (data) {
                            password = data;
                          },
                          suffix: const Icon(Icons.visibility),
                          icon: const Icon(
                            Icons.lock, color: kPrimaryLightColor,),
                          hinttext: 'Password',
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      button(
                        color: kPrimaryLightColor,
                        textcolor: Colors.white,
                        ontap: () async {
                          if (formkey.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context).add(loginEvent(email: email, password: password));
                          }
                          else{}
                        },
                        label: 'Log In',
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'don\'t have an account?',
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return register();
                                  }
                                  ));
                            },
                            child: const Text(
                              '  SignIn',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
              ),

            );
          },
        ),
    );
  }
}
