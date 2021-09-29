import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weather_task/Models/UserModel.dart';
import 'package:weather_task/UpdateUserInformation/UpdateInfoBloc.dart';
import 'package:weather_task/UpdateUserInformation/UpdateInfoEvent.dart';
import 'package:weather_task/UpdateUserInformation/UpdateInfoState.dart';

import 'HomeScreen.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  UpdateInfoBloc? updateInfo;
  UserModel userModel = UserModel();
  FirebaseFirestore getUserInfo = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController firstName = TextEditingController();

  final TextEditingController lastName = TextEditingController();

  final TextEditingController phone = TextEditingController();

  final TextEditingController email = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    getUserInfo
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((userInfo) {
      userModel = UserModel.fromMap(userInfo.data());
    });
  }

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
    email.text = userModel.email.toString();
    firstName.text = userModel.firstName.toString();
    lastName.text = userModel.lastName.toString();
    phone.text = userModel.phone.toString();
    updateInfo = BlocProvider.of<UpdateInfoBloc>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () { Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage()),
          );},
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.purple,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Update Information',
          style: TextStyle(color: Colors.purple),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              BlocListener<UpdateInfoBloc, UpdateInfoState>(
                listener: (context, state) {
                  if (state is UpdateInfoSuccess) {
                    print('Update Information Done Successfully');
                  }
                },
                child: BlocBuilder<UpdateInfoBloc, UpdateInfoState>(
                  builder: (context, state) {
                    if (state is UpdateInfoLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is UpdateInfoFailed) {
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
                              updateInfo!.add(userInformationUpdated(
                                  email: email.text,
                                  firstName: firstName.text,
                                  lastName: lastName.text,
                                  phone: phone.text));
                            }
                          },
                          child: Text('Update')))),
            ],
          ),
        ),
      ),
    );
  }
}
