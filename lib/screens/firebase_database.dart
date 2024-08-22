import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.reference();

  Future<void> storeUserData(String uid, String email) async {
    await _dbRef.child('users').child(uid).set({
      'email': email,
      'created_at': DateTime.now().toString(),
    });
  }
}
