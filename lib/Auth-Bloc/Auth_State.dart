import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBlocState extends Equatable {
  AuthBlocState();

  List<Object> get props => [];
}

class InitialAuthBlocState extends AuthBlocState {}

class AuthenticateBlocState extends AuthBlocState {
  final User user;

  AuthenticateBlocState({required this.user});
}

class UnAuthenticateBlocState extends AuthBlocState {}
