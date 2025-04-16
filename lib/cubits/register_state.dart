part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}
final class Registerloading extends RegisterState {}
final class Registersucces extends RegisterState {}
final class Registerfailur extends RegisterState {
  String errormessage;
  Registerfailur({required this.errormessage});
}