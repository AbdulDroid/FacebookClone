import 'package:facebook_clone/constants/routes.dart';
import 'package:facebook_clone/models/message.dart';
import 'package:facebook_clone/services/dialog_service.dart';
import 'package:facebook_clone/services/firestoreservice.dart';
import 'package:facebook_clone/utils/locator.dart';
import 'package:facebook_clone/utils/navigator.dart';
import 'package:facebook_clone/viewmodel/basemodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends BaseViewModel {
  final FireStoreService _fireStoreService = locator<FireStoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigatorService _navigatorService = locator<NavigatorService>();
  List<Message> _messages;

  List<Message> get messages => _messages;

  void listenToMessages() {
    getUserId();
    setBusy(true);
    _fireStoreService.realTimeMessages().listen((messageData) {
      List<Message> freshMessages = messageData;
      if (freshMessages != null && freshMessages.length > 0) {
        _messages = freshMessages;
        notifyListeners();
      }
      setBusy(false);
    });
  }

  Future updateLikes({@required String messageId}) async {
    setBusy(true);

    var result = await _fireStoreService.updateLikes(messageId, userId);
    setBusy(false);
    if (result is String) {
      await _dialogService.showDialog(
        title: 'Like Failure',
        description: result,
      );
    }
  }

  Future navigateToCreatePage() =>
      _navigatorService.navigateTo(NewMessageRoute);

  Future logout() async {
    await FirebaseAuth.instance.signOut();
    _navigatorService.navigateKillingOld(LoginRoute);
  }
}
