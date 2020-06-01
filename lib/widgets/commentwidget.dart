import 'package:facebook_clone/models/comment.dart';
import 'package:facebook_clone/constants/colors.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;
  final int position;
  CommentWidget(this.position, this.comment);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 3.0, right: 29.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          if (position % 2 == 0)
            Container(
              height: 37.0,
              width: 37.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                image: DecorationImage(
                    image: AssetImage("images/profile_image.png"),
                    fit: BoxFit.cover),
              ),
            )
          else
            Container(
              height: 37.0,
              width: 37.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                image: DecorationImage(
                    image: AssetImage("images/profile_image_alt.png"),
                    fit: BoxFit.cover),
              ),
            ),
          Container(
            width: 18.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      comment.senderName,
                      style: TextStyle(
                        color: blue,
                        fontWeight: FontWeight.w900,
                        fontSize: 15.0,
                      ),
                    ),
                    Container(
                      width: 5,
                    ),
                    Text(
                      comment.getTime(),
                      style: TextStyle(
                        color: textLighter,
                        fontWeight: FontWeight.normal,
                        fontSize: 11.0,
                      ),
                    )
                  ],
                ),
                Text(
                  comment.comment,
                  style: TextStyle(
                    color: textDark,
                    fontWeight: FontWeight.normal,
                    fontSize: 13.0,
                  ),
                  textAlign: TextAlign.left,
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
