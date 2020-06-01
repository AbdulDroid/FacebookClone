import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;

class Message {
  String id;
  String userId;
  String senderName;
  Timestamp time;
  String message;
  String imageUrl;
  int likes;

  Message(
    this.userId,
    this.senderName,
    this.message,
    this.imageUrl,
  );

  Message.fromObject(Map<String, dynamic> map, String docId) {
    this.id = docId;
    this.userId = map['user_id'];
    this.senderName = map['sender_name'];
    this.time = map['time'];
    this.message = map['message'];
    this.imageUrl = map['image_url'];
    this.likes = map['likes'].length;
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'sender_name': senderName,
      'time': Timestamp.fromDate(DateTime.now()),
      'message': message,
      'image_url': imageUrl,
      'likes': [],
    };
  }
  

  String getTime() {
    final mTime = DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch);
    final diff = DateTime.now().difference(mTime);
    return timeago.format(DateTime.now().subtract(diff), locale: 'en');
  }
  
}
