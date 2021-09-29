import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_task/Auth-Bloc/Auth_Bloc.dart';
import 'package:weather_task/Auth-Bloc/Auth_State.dart';
import 'package:weather_task/Login/LoginBloc.dart';
import 'package:weather_task/Register/RegisterBloc.dart';
import 'package:weather_task/Screens/SplashScreen.dart';
import 'package:weather_task/UpdateUserInformation/UpdateInfoBloc.dart';
import 'UserRepository/User-Repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  UserRepository? repository;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AuthBloc(repository:repository )),
        BlocProvider(create: (context) => RegisterBloc(repository: repository)),
        BlocProvider(create: (context) => LoginBloc(repository: repository)),
        BlocProvider(create: (context) => UpdateInfoBloc(repository: repository)),],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Start()),
    );
  }
}

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc,AuthBlocState>(builder:(context,state){
      return SplachScreen();
    });
  }
}
