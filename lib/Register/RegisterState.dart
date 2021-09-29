import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterState extends Equatable {
  RegisterState();

  List<Object> get props => [];
}

class InitialRegister extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final User user;
  RegisterSuccess({required this.user});
}

class RegisterFailed extends RegisterState {
  final String error;
  RegisterFailed({required this.error});
}
