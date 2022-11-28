import 'dart:async';
import 'package:dzhalelov_auth/services/firebase/firebase_auth_service.dart';
import 'package:flutter/material.dart';

enum Status {
  signIn,
  signedOut,
  guest,
}

class AuthProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.guest;

  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  Future checkStatus(FirebaseAuthService firebaseAuthService) async {
    bool status = await firebaseAuthService.signInState();
    if (status) {
      _loggedInStatus = Status.signIn;
    } else {
      _loggedInStatus = Status.signedOut;
    }
  }

  Future register() async {
    _loggedInStatus = Status.signIn;
  }

  Future signIn() async {
    _loggedInStatus = Status.signIn;
  }

  Future signOut() async {
    _loggedInStatus = Status.guest;
  }

  notify(){
    notifyListeners();
  }

}