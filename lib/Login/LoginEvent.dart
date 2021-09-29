import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable{
  const LoginEvent();
  @override
  List<Object?> get props => [];

}
class UserLoginEvent extends LoginEvent{
  String email,password;
  UserLoginEvent({required this.email,required this.password});
}