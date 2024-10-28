import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthServices {
  GoogleAuthServices._();

  static final GoogleAuthServices googleAuthServices = GoogleAuthServices._();

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        return 'Cancelled';
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await firebaseAuth.signInWithCredential(credential);

      return 'Success';
    } catch (e) {
      if (e is FirebaseAuthException) {
      } else {}
      log(e.toString());
      return 'Failed';
    }
  }

  User? currentUser() {
    User? user = firebaseAuth.currentUser;
    return user;
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();

      await googleSignIn.signOut();
    } catch (e) {
      log(e.toString());
    }
  }
}
