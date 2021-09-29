import 'package:bloc/bloc.dart';
import 'package:weather_task/UserRepository/User-Repository.dart';

import 'LoginEvent.dart';
import 'LoginState.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  UserRepository? repository;
  LoginBloc({this.repository}) : super(InitialLogin());

  Stream<LoginState>mapEventToState(
      LoginEvent event,
      )async*{
    if(event is UserLoginEvent)
    {
      yield LoginLoading();
      try{
        var user=await repository!.Login(event.email,event.password);
        yield LoginSuccess(user: user!);

      }
      catch(e){
        yield LoginFailed(error: e.toString());
      }
    }
  }

}