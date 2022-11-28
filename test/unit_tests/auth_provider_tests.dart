import 'package:dzhalelov_auth/providers/auth_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test auth_provider', () {
    AuthProvider authProvider = AuthProvider();
    expect(authProvider.loggedInStatus, Status.guest);

    authProvider.signIn();
    expect(authProvider.loggedInStatus, Status.signIn);

    authProvider.signOut();
    expect(authProvider.loggedInStatus, Status.guest);

  });

}