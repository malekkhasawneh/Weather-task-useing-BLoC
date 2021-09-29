import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UpdateInfoState extends Equatable {
  UpdateInfoState();

  List<Object> get props => [];
}

class InitialUpdateInfo extends UpdateInfoState {}

class UpdateInfoLoading extends UpdateInfoState {}

class UpdateInfoSuccess extends UpdateInfoState {
  final User user;
  UpdateInfoSuccess({required this.user});
}

class UpdateInfoFailed extends UpdateInfoState {
  final String error;
  UpdateInfoFailed({required this.error});
}
