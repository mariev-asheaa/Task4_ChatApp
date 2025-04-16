import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  register({required String email,required String password}) async {
    emit(Registerloading());
    try {
     UserCredential credential= await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
     emit(Registersucces());
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
   emit(Registerfailur(errormessage: 'The password provided is too weak'));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        emit(Registerfailur(errormessage: 'The account already exists for that email.'));
      }
    }
    catch(e){
      emit(Registerfailur(errormessage: 'something went wrong'));
    }
  }
}
