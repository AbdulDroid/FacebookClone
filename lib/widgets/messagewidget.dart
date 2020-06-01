import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_clone/constants/colors.dart';
import 'package:facebook_clone/models/message.dart';
import 'package:facebook_clone/ui/commentbottomsheet.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final int position;
  final Function onLike;
  const MessageWidget({
    @required this.message,
    @required this.position,
    @required this.onLike,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0.5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18.0,
          vertical: 12.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Row(
                children: <Widget>[
                  if (position % 2 == 0)
                    Container(
                      height: 33.0,
                      width: 33.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        image: DecorationImage(
                            image: AssetImage('images/profile_image_alt.png'),
                            fit: BoxFit.cover),
                        border: Border.all(
                          color: blue,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                      ),
                    )
                  else
                    Container(
                      height: 33.0,
                      width: 33.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        image: DecorationImage(
                            image: AssetImage('images/profile_image.png'),
                            fit: BoxFit.cover),
                        border: Border.all(
                          color: blue,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  Container(
                    width: 18,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        message.senderName,
                        style: TextStyle(
                          color: textDark,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        message.getTime(),
                        style: TextStyle(
                          color: textLighter,
                          fontSize: 11.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 7,
                right: 7,
              ),
              child: Text(
                message.message,
                softWrap: true,
                style: TextStyle(
                  color: textDark,
                  fontSize: 13.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Container(
              height: 234.0,
              margin: EdgeInsets.only(
                top: 10,
              ),
              padding: EdgeInsets.zero,
              child: CachedNetworkImage(
                imageUrl: message.imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 12.0, top: 20.0),
              child: Row(
                children: <Widget>[
                  FlatButton(
                    onPressed: onLike,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Image(
                            image: AssetImage('images/ic_like.png'),
                            height: 25,
                            width: 28,
                            color: red,
                          ),
                          Container(
                            width: 10,
                          ),
                          Text(
                            getLikeText(message.likes),
                            style: TextStyle(
                              color: red,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 17,
                  ),
                  Expanded(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          side: BorderSide(
                              color: strokeDarker,
                              style: BorderStyle.solid,
                              width: 1)),
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          isDismissible: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => CommentBottomSheet(message.id),
                        );
                      },
                      color: backgroundDark,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Write Comment',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.normal,
                              color: textLighter,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String getLikeText(int value) {
    if (value == 1) {
      return '$value like';
    } else {
      return '$value likes';
    }
  }
}
