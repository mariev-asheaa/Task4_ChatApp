part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
class loginEvent extends AuthEvent{
  String email;
  String password;
  loginEvent({required this.email,required this.password});
}

class registerEvent extends AuthEvent{}
