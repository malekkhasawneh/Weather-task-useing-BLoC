import 'package:equatable/equatable.dart';

class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class userRegistered extends RegisterEvent {
  String email, password, firstName, lastName, phone;

  userRegistered(
      {required this.email,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.phone});
}
