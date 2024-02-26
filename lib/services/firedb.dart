import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireDB {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> createNewUser(
    String name,
    String email,
    String photoUrl,
    String uid,
  ) async {
    final User? currentUser = _auth.currentUser;

    if (await doesUserExist(currentUser!.uid)) {
      return;
    }

    // Create a new user document in the "users" collection.
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .set({
      "name": name,
      "email": email,
      "photoUrl": photoUrl,
      "money": 0,
    });
  }
}

Future<bool> doesUserExist(String userId) async {
  final DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection("users").doc(userId).get();

  return userDoc.exists;
}
