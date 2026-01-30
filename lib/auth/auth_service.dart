import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Future<User?> login({required String email, required String password}) async {
    final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return cred.user;
  }

  Future<User?> signUp({
    required String username,
    required String email,
    required String password,
    required DateTime dob,
    required String gender,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final user = cred.user;
    if (user == null) return null;

    await _firestore.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'username': username,
      'email': email,
      'dob': dob.toIso8601String(),
      'gender': gender,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return user;
  }

  Future<void> logout() async => await _auth.signOut();
}
