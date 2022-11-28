import 'package:dzhalelov_auth/domain/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {

  Future<void> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('userId',user.id);
    prefs.setString('email',user.email);
    prefs.setBool('isVerifiedEmail',user.isVerifiedEmail);
    prefs.setString('email',user.picture);
    prefs.setString('token', user.token);

  }

  Future<User> getUser ()  async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String userId = prefs.getString('userID') ?? '';
    String email = prefs.getString('email') ?? '';
    bool isVerifiedEmail = prefs.getBool('isVerifiedEmail') ?? false;
    String picture = prefs.getString('picture') ?? '';
    String token = prefs.getString('token') ?? '';

    return User(
      id: userId,
      email: email,
      isVerifiedEmail: isVerifiedEmail,
      picture: picture,
      token: token,
        );

  }

  void removeUser() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('userId');
    prefs.remove('email');
    prefs.remove('isVerifiedEmail');
    prefs.remove('picture');
    prefs.remove('token');

  }

  Future setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token!;
  }

}