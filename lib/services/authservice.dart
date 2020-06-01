import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthenticationService {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<bool> isLoggedIn() async {
    var user = await _firebaseAuth.currentUser();
    return user != null;
  }
  
  Future loginWithEmail({@required String email, @required String password}) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail({@required String email, @required String password}) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }
}