import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weather_task/Register/RegisterBloc.dart';
import 'package:weather_task/Register/RegisterEvent.dart';
import 'package:weather_task/Register/RegisterState.dart';
import 'package:weather_task/Screens/LoginScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterBloc? userRegisterBloc;

  final TextEditingController firstName = TextEditingController();

  final TextEditingController lastName = TextEditingController();

  final TextEditingController phone = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController rePassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool passwordIsHide = true;
  bool rePasswordIsHide = true;

  File? imageFile;

  String? imageUrl;

  getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> showMyDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Take Picture'),
            actions: [
              ListTile(
                title: Text('From Gallery'),
                onTap: () {
                  getFromGallery();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('From Camera'),
                onTap: () {
                  getFromCamera();
                  Navigator.pop(context);
                },
              ),
            ],
            scrollable: true,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    userRegisterBloc = BlocProvider.of<RegisterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Register',
          style: TextStyle(color: Colors.purple),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              BlocListener<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterSuccess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen()),
                    );
                  }
                },
                child: BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    if (state is RegisterLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is RegisterFailed) {
                      return Center(
                        child: Text(state.error.toString()),
                      );
                    }
                    return Container();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.25), // border color
                    shape: BoxShape.circle,
                  ),
                  child: imageFile == null
                      ? CircleAvatar(
                          backgroundImage:
                              Image.asset('images/userLogo.png').image)
                      : CircleAvatar(
                          backgroundImage: Image.file(
                            File(imageFile!.path),
                            width: 300,
                            height: 300,
                            errorBuilder: (
                              BuildContext context,
                              Object error,
                              StackTrace? stackTrace,
                            ) {
                              return Icon(
                                Icons.image,
                                size: 45,
                              );
                            },
                          ).image,
                        ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    showMyDialog(context);
                  },
                  icon: Icon(
                    Icons.image,
                    color: Colors.purple,
                  )),
              Padding(
                padding: EdgeInsets.only(top: 25),
                child: TextFormField(
                  controller: firstName,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "First Name",
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
                  controller: lastName,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "Last Name",
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
                  obscureText: passwordIsHide,
                  controller: password,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordIsHide = !passwordIsHide;
                        });
                      },
                      icon: passwordIsHide == true
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
                padding: EdgeInsets.only(top: 15),
                child: TextFormField(
                  validator: (input) {
                    if (input != password.text) {
                      return 'password does not match';
                    }
                    return null;
                  },
                  obscureText: true,
                  controller: rePassword,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          rePasswordIsHide = !rePasswordIsHide;
                        });
                      },
                      icon: rePasswordIsHide == true
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                    labelText: "Re-Password",
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
                  controller: phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: "Phone",
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
                          style:
                              ElevatedButton.styleFrom(primary: Colors.purple),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              return;
                            } else {
                              userRegisterBloc!.add(userRegistered(
                                  email: email.text,
                                  password: password.text,
                                  firstName: firstName.text,
                                  lastName: lastName.text,
                                  phone: phone.text));
                            }
                          },
                          child: Text('Register')))),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 25),
                child: Row(
                  children: [
                    Text(
                      'You Have Account ? ',
                      style: TextStyle(color: Colors.purple),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text(
                          'Login',
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
    );
  }
}
