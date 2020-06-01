import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CloudStorageService {
  Future<CloudStorageResult> uploadImage({
    @required File image,
  }) async {
    var fileName = 'message_image_${DateTime.now().millisecondsSinceEpoch}';
    final StorageReference storageReference =
        FirebaseStorage.instance.ref().child('images/$fileName');

    StorageUploadTask task = storageReference.putFile(image);
    StorageTaskSnapshot snapshot = await task.onComplete;
    var downloadUrl = await snapshot.ref.getDownloadURL();

    if (task.isComplete) {
      var url = downloadUrl.toString();
      return CloudStorageResult(
        imageUrl: url,
      );
    }
    return null;
  }
}

class CloudStorageResult {
  final String imageUrl;

  CloudStorageResult({this.imageUrl,});
}
