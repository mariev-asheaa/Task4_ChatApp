part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class Loginsucces extends AuthState {}

final class Loginfailur extends AuthState {
  String errormessage;
  Loginfailur({required this.errormessage});
}
final class Registerloading extends AuthState {}
final class Registersucces extends AuthState {}
final class Registerfailur extends AuthState {
  String errormessage;
  Registerfailur({required this.errormessage});
}

