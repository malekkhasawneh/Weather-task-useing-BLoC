import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_task/Models/UserModel.dart';

class UserRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore userInfo = FirebaseFirestore.instance;

  UserRepository({required this.auth, required this.userInfo});

  /*Register User*/
  Future<User?> register(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String phone}) async {
    try {
      var createUser = await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        setUserInformation(
            id: value.user!.uid,
            userFirstName: firstName,
            userLastName: lastName,
            userEmail: email,
            userPhone: phone);
      });
      return createUser.user;
    } catch (error) {
      print(error.toString());
    }
  }

  /*Set User Information*/
  Future<User?> setUserInformation({
    required String id,
    required String userFirstName,
    required String userLastName,
    required String userEmail,
    required String userPhone,
  }) async {
    await userInfo.collection('users').doc(id).set({
      'id': id,
      'firstName': userFirstName,
      'lastName': userLastName,
      'email': userEmail,
      'phone': userPhone,
    });
  }

  /*User Login*/
  Future<User?> Login(String userEmail, String userPassword) async {
    try {
      var userLogin = await auth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);
      return userLogin.user;
    } catch (error) {
      print(error.toString());
    }
  }

  /*Update User Info*/
  Future<User?> updateUserInfo({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    UserModel userInfo = await UserModel(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update(userInfo.toMap());
    auth.currentUser!.updateEmail(email);
  }

  /*User Logout*/

  Future<void> logout() async {
    await auth.signOut();
  }

/*Get Current User*/

  Future<User?> currentUser() async {
    return await auth.currentUser;
  }

  Future<bool?> isLogin() async {
    var currentUser = await auth.currentUser;
    return currentUser != null;
  }
}
