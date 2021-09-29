import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable{
  AuthEvent();

  List<Object> get props => [];
}
class isLoaded extends AuthEvent{}