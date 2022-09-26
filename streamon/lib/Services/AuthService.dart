import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../Entities/LocalUser.dart';
import '../Providers/UserManagement.dart';

class AuthService {
  signOutListener(BuildContext context) {
    if (!context
        .read<UserManagement>()
        .listening) {
      context
          .read<UserManagement>()
          .listening = true;
      FirebaseAuth.instance.userChanges().listen((User? user) {
        context
            .read<UserManagement>()
            .user = user;
        if (user == null) {
          context
              .read<UserManagement>()
              .localUser = null;
        }
      });
    }
  }

  Future<bool> signUp(String firstName, String email,
      String phone, String password) async {
    //TODO: SERVICE FOR AUTH
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseFirestore.instance.collection('users').add({
        'userid': userCredential.user?.uid,
        'firstName': firstName.toLowerCase().replaceFirst(
            firstName
                .split("")
                .first, firstName
            .split("")
            .first
            .toUpperCase()),
        'phone': phone,
        'email': email,
        'password': password
      });
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        throw ('The account already exists for that email');
      }
    } catch (e) {
      throw (e);
    }
    return Future.value(false);
  }

  Future<bool> signIn(String email, String password,
      BuildContext context) async {
    //TODO: SERVICE FOR AUTH
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      QuerySnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('users')
          .where('userid', isEqualTo: userCredential.user!.uid)
          .get();
      print(userData.docs.first.data());
      context
          .read<UserManagement>()
          .localUser =
          LocalUser.fromJson(userData.docs.first.data());
      context
          .read<UserManagement>()
          .user = userCredential.user;
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw ('Wrong password provided for that user.');
      }
    }
    return Future.value(false);
  }

  Future<List<LocalUser>> getUsers() async {
    QuerySnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
        .instance
        .collection('users')
        .get();
    return userData.docs.map((e) => LocalUser.fromJson(e.data())).toList();
  }
}
