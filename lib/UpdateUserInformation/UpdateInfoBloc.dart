import 'package:bloc/bloc.dart';
import 'package:weather_task/UpdateUserInformation/UpdateInfoEvent.dart';
import 'package:weather_task/UpdateUserInformation/UpdateInfoState.dart';
import 'package:weather_task/UserRepository/User-Repository.dart';


class UpdateInfoBloc extends Bloc<UpdateInfoEvent, UpdateInfoState> {
  UserRepository? repository;

  UpdateInfoBloc({this.repository}) : super(InitialUpdateInfo());

  Stream<UpdateInfoState> mapEventToState(UpdateInfoEvent event,) async* {
    if (event is userInformationUpdated) {
      yield UpdateInfoLoading();
      try {
        var user = await repository!.updateUserInfo(firstName: event.firstName,
            lastName: event.lastName,
            email: event.email,
            phone: event.phone);
        yield
        UpdateInfoSuccess(user: user!);
      } catch (error) {
        yield UpdateInfoFailed(error: error.toString());
      }
    }
  }
}
