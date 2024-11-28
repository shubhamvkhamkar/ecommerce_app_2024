import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProviders with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;

  bool get isAuthenticated => _user != null;

  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners();
    } catch (error) {
      throw 'No User Found';
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }

  void checkAuthStatus() {
    _user = _auth.currentUser;
    notifyListeners();
  }
}

