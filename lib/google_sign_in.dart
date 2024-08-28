import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/youtube.force-ssl',
    ],
  );

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future logout() async {
    await googleSignIn.disconnect();
    _user = null;
    notifyListeners();
  }
}
