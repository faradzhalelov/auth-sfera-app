import 'package:firedart/firedart.dart';

class FirebaseStoreService {
  final CollectionReference _usersCollection =
  Firestore.instance.collection('users');

  Future getUsers() async {
    final users = await _usersCollection.get();
    return users;
  }

  Future addToCollection(String key, String value) async {
      await _usersCollection.add({key : value,});
  }

  Future editInCollection(String document, String key, String value) async {
    await _usersCollection
        .document(document)
        .update({key : value,});
  }

  Future deleteFromCollection(String document) async {
    await _usersCollection
        .document(document)
        .delete();
  }
}