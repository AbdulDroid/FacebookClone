import 'dart:io';

import 'package:facebook_clone/models/message.dart';
import 'package:facebook_clone/services/cloudstorageservice.dart';
import 'package:facebook_clone/services/dialog_service.dart';
import 'package:facebook_clone/services/firestoreservice.dart';
import 'package:facebook_clone/utils/imageselector.dart';
import 'package:facebook_clone/utils/locator.dart';
import 'package:facebook_clone/utils/navigator.dart';
import 'package:facebook_clone/viewmodel/basemodel.dart';
import 'package:flutter/material.dart';

class CreateMessageViewModel extends BaseViewModel {
  final NavigatorService _navigatorService = locator<NavigatorService>();
  final DialogService _dialogService = locator<DialogService>();
  final ImageSelectorService _imageSelectorService =
      locator<ImageSelectorService>();
  final FireStoreService _fireStoreService = locator<FireStoreService>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();
  bool createBusy = false;

  File _image;
  File get image => _image;

  void goBack() => _navigatorService.pop();

  Future showDialog({@required title, @required msg}) async {
    await _dialogService.showDialog(
      title: title,
      description: msg,
    );
  }

  Future selectImage(bool fromCamera) async {
    var tempImage;
    if (fromCamera)
      tempImage = await _imageSelectorService.selectImageFromCamera();
    else
      tempImage = await _imageSelectorService.selectImageFromGallery();
    if (tempImage != null) {
      _image = tempImage;
      notifyListeners();
    }
  }

  Future addMessage({@required String message}) async {
    setBusy(true);
    createBusy = true;
    CloudStorageResult storageResult;
    getUserId();

    storageResult = await _cloudStorageService.uploadImage(
      image: _image,
    );

    var result = await _fireStoreService.addMessage(Message(
      userId,
      userId == 'ing4YCI6gvRTbFtgH1HASoiFZTR2'
          ? 'Abdulrahman Abdul'
          : email,
      message,
      storageResult.imageUrl,
    ));
    createBusy = false;
    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Message Create Failure',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Message Added',
        description: 'Your message has been sent successfully',
      );
    }

    _navigatorService.pop();
  }
}
