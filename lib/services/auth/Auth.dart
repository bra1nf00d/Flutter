import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth extends ChangeNotifier {
  final _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? user;
  bool isAuth = false;

  Auth();

  Future signIn() async {
    user = await _googleSignIn.signIn();
    notifyListeners();
  }

  Future signOut() async {
    _googleSignIn.disconnect();
    user = null;
    notifyListeners();
  }
}