import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class BaseViewModel extends ChangeNotifier {
  bool _busy = false;
  String _userId;
  String _email;
  bool get busy => _busy;

  String get userId => _userId;
  String get email => _email;

  Future getUserId() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    _userId = user.uid;
    _email = user.email;
  }

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}