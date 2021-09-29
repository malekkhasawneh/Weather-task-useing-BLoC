import 'package:equatable/equatable.dart';

class UpdateInfoEvent extends Equatable {
  const UpdateInfoEvent();

  @override
  List<Object?> get props => [];
}

class userInformationUpdated extends UpdateInfoEvent {
  String email, firstName, lastName, phone;

  userInformationUpdated(
      {required this.email,
        required this.firstName,
        required this.lastName,
        required this.phone});
}
