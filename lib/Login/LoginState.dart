import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginState extends Equatable{
  LoginState();

  @override
  List<Object?> get props => [];
}
class InitialLogin extends LoginState{}
class LoginLoading extends LoginState{}
class LoginSuccess extends LoginState{
  final User user;
  LoginSuccess({required this.user});
}
class LoginFailed extends LoginState{
  final String error;
  LoginFailed({required this.error});
}