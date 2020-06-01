import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;

class Comment {
  String id;
  String senderName;
  String messageId;
  String userId;
  Timestamp time;
  String comment;

  Comment(
    this.senderName,
    this.userId,
    this.comment,
    this.messageId,
  );

  Comment.fromObject(Map<String, dynamic> map, String docId) {
    this.id = docId;
    this.senderName = map['sender_name'];
    this.userId = map['user_id'];
    this.messageId = map['message_id'];
    this.time = map['time'];
    this.comment = map['comment'];
  }

  Map<String, dynamic> toJson() {
    return {
      'sender_name': senderName,
      'message_id': messageId,
      'user_id': userId,
      'time': Timestamp.fromDate(DateTime.now()),
      'comment': comment,
    };
  }

  String getTime() {
    final mTime =
        DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch);
    final diff = DateTime.now().difference(mTime);
    return timeago.format(DateTime.now().subtract(diff), locale: 'en');
  }
}
