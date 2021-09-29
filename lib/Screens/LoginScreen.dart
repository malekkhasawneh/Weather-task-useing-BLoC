import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_task/Login/LoginBloc.dart';
import 'package:weather_task/Login/LoginEvent.dart';
import 'package:weather_task/Login/LoginState.dart';
import 'package:weather_task/Screens/HomeScreen.dart';
import 'package:weather_task/Screens/RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  bool isHide = true;

  @override
  Widget build(BuildContext context) {
    var userLoginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Login',
          style: TextStyle(color: Colors.purple),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 130),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage()),
                      );
                    }
                  },
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is LoginFailed) {
                        return Center(
                          child: Text(state.error.toString()),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Container(
                    height: 100,
                    width: 100,
                    child: CircleAvatar(
                        backgroundImage: Image.asset(
                      'images/itgLogo.jpg',
                    ).image),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: TextFormField(
                    validator: (input) {
                      if (input!.isEmpty || !input.contains('@')) {
                        return 'Invalid Email';
                      }
                      return null;
                    },
                    controller: email,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      labelText: "Email",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.purple,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: TextFormField(
                    validator: (input) {
                      if (input!.isEmpty || input.length < 6) {
                        return 'Password is too short';
                      }
                      return null;
                    },
                    controller: password,
                    obscureText: isHide,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isHide = !isHide;
                          });
                        },
                        icon: isHide == true
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
                      labelText: "Password",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.purple,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Container(
                    width: 170,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.purple),
                        onPressed: () {
                          userLoginBloc.add(UserLoginEvent(
                              email: email.text, password: password.text));
                        },
                        child: Text('login')),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 40),
                  child: Row(
                    children: [
                      Text(
                        'You Don\'t Have Account Yet ? ',
                        style: TextStyle(color: Colors.purple),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()),
                            );
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.green),
                          ))
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
