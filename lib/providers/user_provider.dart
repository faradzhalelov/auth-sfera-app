import 'package:dzhalelov_auth/domain/model/user_model.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{

  User _user = User(
      email: '',
      isVerifiedEmail: false,
      picture: '',
      id: '',
      token: ''
  );

  User get user => _user;

  void setUser (User user){
    _user = user;
    notifyListeners();
  }

}