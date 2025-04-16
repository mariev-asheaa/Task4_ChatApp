import 'package:chat_app/constant.dart';
import 'package:chat_app/cubits/register_cubit.dart';
import 'package:chat_app/widgets/Social.dart';
import 'package:chat_app/widgets/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  late String email;
  late String password;
  GlobalKey<FormState>formkey = GlobalKey();

//itialise a key for authentication
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is Registerloading) {
            isloading = true;

          }
          else if (state is Registersucces) {
            isloading = false;
            Navigator.pushNamed(context, 'chat');
          }
          else if(state is Registerfailur){
            isloading = false;
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content:
                Text(state.errormessage)
                ));
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: isloading,
            //show the loading circle on the screen
            child: Scaffold(
              backgroundColor: primarycolor,
              body: Form(
                key: formkey,
                child: background(
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(90),
                            child: SvgPicture.asset(
                              'assets/icons/signup.svg', height: 300,),

                          ),

                        ],
                      ),
                      const Center(
                        child: Text('Start Chating Now!', style: TextStyle(
                            fontSize: 40,
                            color: Color(0xff283618)
                        ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        textformfield(
                          icon: const Icon(Icons.person),
                          hinttext: 'Name',),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        textformfield(
                          onchanged: (data) {
                            email = data;
                          },
                          icon: const Icon(Icons.email),
                          hinttext: 'Email',),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        textformfield(
                          obsecure: true,
                          onchanged: (data) {
                            password = data;
                          },
                          icon: const Icon(Icons.lock),
                          suffix: const Icon(Icons.visibility),
                          hinttext: 'Password',),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      button(
                        color: kPrimaryLightColor,
                        textcolor: Colors.white,
                        ontap: () async {
                          if (formkey.currentState!.validate()) {
                            BlocProvider.of<RegisterCubit>(context).register(
                                email: email, password: password);
                          }
                        },
                        label: 'Register',
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'already have an account?',
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              //enhance the performance by back to the last screen
                              //instead of build a new one
                            },
                            child: const Text(
                              ' LogIn',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff324e14)
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Center(child: Text('OR', style: TextStyle(
                          color: kPrimaryLightColor, fontSize: 20),)),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          social(image: 'assets/icons/facebook.svg'),
                          social(image: 'assets/icons/google-plus.svg'),
                          social(image: 'assets/icons/twitter.svg')
                        ],
                      )
                    ],
                  ),
                ),
              ),

            ),
          );
        },
      ),
    );
  }
}
