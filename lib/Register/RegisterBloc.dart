import 'package:bloc/bloc.dart';
import 'package:weather_task/UserRepository/User-Repository.dart';

import 'RegisterEvent.dart';
import 'RegisterState.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepository? repository;

  RegisterBloc({this.repository}) : super(InitialRegister());

  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is userRegistered) {
      yield RegisterLoading();
      try {
        var user = await repository!.register(
            email: event.email,
            password: event.password,
            firstName: event.firstName,
            lastName: event.lastName,
            phone: event.password);
        yield RegisterSuccess(user: user!);
      } catch (e) {
        yield RegisterFailed(error: e.toString());
      }
    }
  }
}
