import 'dart:math';

class User {
  String id;
  String email;
  bool isVerifiedEmail;
  String picture;
  String token;

  User({
    required this.id,
    required this.email,
    required this.isVerifiedEmail,
    required this.picture,
    required this.token
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        email: json['email'],
        isVerifiedEmail: json['verified_email'],
        picture: json['picture'],
        token: '');
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'verified_email': isVerifiedEmail,
    'picture' : picture,
  };

  @override
  String toString() {
    return "(User: id: $id; email: $email; isVerifiedEmail: $isVerifiedEmail; picture: $picture; token: $token)";
  }

}
