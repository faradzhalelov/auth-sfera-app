import 'package:dzhalelov_auth/domain/model/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test user.toJson method', () {
    final user = User(
        id: 'id',
        email: 'email',
        isVerifiedEmail: true,
        picture: 'picture',
        token: 'token');
    var userJson = user.toJson();

    expect(userJson, {
      "id" : "id",
      "email" : "email",
      "verified_email" : true,
      "picture" : "picture",
      "token" : "token"
    });
  });


}