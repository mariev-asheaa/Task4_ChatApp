import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if(event is loginEvent){
        try {
          UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email,
              password: event.password
          );
          emit(Loginsucces());
        }
        on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            print('No user found for that email.');
            emit(Loginfailur(errormessage: 'User not found'));
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
            emit(Loginfailur(errormessage: 'Wrong password'));
          }
        }
        catch(e){
          emit(Loginfailur(errormessage: 'There was an error'));
        }
      }
      });
  }
  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    print(Transition);
  }
}
