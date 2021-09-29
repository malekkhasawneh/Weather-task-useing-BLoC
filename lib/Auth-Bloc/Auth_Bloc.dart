import 'package:bloc/bloc.dart';
import 'package:weather_task/Auth-Bloc/Auth_Event.dart';
import 'package:weather_task/Auth-Bloc/Auth_State.dart';
import 'package:weather_task/UserRepository/User-Repository.dart';

class AuthBloc extends Bloc<AuthEvent,AuthBlocState>{
  UserRepository? repository;
  AuthBloc({this.repository}) : super(InitialAuthBlocState());

  Stream<AuthBlocState> mapEventToState(
      AuthEvent event,
      )async*{
if(event is isLoaded){
  try{
    var isLogin = await repository!.isLogin();

    if(isLogin!){
      var user = await repository!.currentUser();
      yield AuthenticateBlocState(user: user!);
    }else{
      yield UnAuthenticateBlocState();
    }
  }catch(error){
   yield UnAuthenticateBlocState();
  }
}
  }

}