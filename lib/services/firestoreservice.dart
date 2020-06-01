import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/models/comment.dart';
import 'package:facebook_clone/models/message.dart';
import 'package:flutter/services.dart';

class FireStoreService {
  final CollectionReference _messageCollectionReference =
      Firestore.instance.collection('messages');
  final CollectionReference _commentCollectionReference =
  Firestore.instance.collection('comments');
  // Create the controller that will broadcast the posts
  final StreamController<List<Message>> _messagesController =
      StreamController<List<Message>>.broadcast();

  final StreamController<List<Comment>> _commentsController = 
    StreamController<List<Comment>>.broadcast();

  Stream realTimeMessages() {
    // Register the handler for when the messages data changes
    _messageCollectionReference.orderBy('time', descending: true).snapshots().listen((mShots) {
      if (mShots.documents.isNotEmpty) {
        var messages = mShots.documents
            .map((mShot) => Message.fromObject(mShot.data, mShot.documentID))
            .where((element) => element.message != null)
            .toList();

        // Add the messages onto the controller
        _messagesController.add(messages);
      }
    });
    // Return the stream underlying our _postsController.
    return _messagesController.stream;
  }

  Stream realTimeComments(String messageId) {
    _commentCollectionReference.where('message_id', isEqualTo: messageId).orderBy('time', descending: false).snapshots().listen((cShots) {
      if(cShots.documents.isNotEmpty) {
        var comments = cShots.documents
        .map((cShot) => Comment.fromObject(cShot.data, cShot.documentID))
        .where((element) => element.comment != null)
        .toList();

        _commentsController.add(comments);
      }
    });

    return _commentsController.stream;
  }

  Future updateLikes(String messageId, String userId) async {
    try {
      var msg = await _messageCollectionReference.document(messageId)
      .get();
      var msgData = msg.data;
      if (!msg['likes'].contains(userId))
      await _messageCollectionReference
          .document(messageId)
          .updateData({'likes': FieldValue.arrayUnion([userId])});
      else _messageCollectionReference.document(messageId)
      .updateData({'likes': FieldValue.arrayRemove([userId])});
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future addMessage(Message message) async{
    try {
      await _messageCollectionReference.add(message.toJson());
    } catch(e) {
      if(e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future addComment(Comment comment) async {
    try {
      await _commentCollectionReference.add(comment.toJson());
    } catch(e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
}
