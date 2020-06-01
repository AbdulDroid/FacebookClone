import 'package:facebook_clone/constants/colors.dart';
import 'package:facebook_clone/viewmodel/homeviewmodel.dart';
import 'package:facebook_clone/widgets/messagewidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:provider_architecture/provider_architecture.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.listenToMessages(),
      builder: (context, model, _) => WillPopScope(
        onWillPop: () async {
          var platform = Theme.of(context).platform;
          if (platform == TargetPlatform.android) {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          } else if (platform == TargetPlatform.iOS) {
            exit(0);
          }
          return true;
        },
              child: Scaffold(
          backgroundColor: backgroundLight,
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 82.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 29.0, right: 19.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Facebook',
                        style: TextStyle(
                          fontSize: 20,
                          color: blue,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          model.logout();
                        },
                                              child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 6.0, horizontal: 25.0),
                          decoration: BoxDecoration(
                            color: buttonBlackLight,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text(
                            'Clone Mode',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 19.0, left: 27.0, right: 28.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 37.0,
                        width: 37.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
                          image: DecorationImage(
                              image: AssetImage("images/profile_image.png"),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        width: 14.0,
                      ),
                      Expanded(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            side: BorderSide(
                              color: strokeDarker,
                              style: BorderStyle.solid,
                            ),
                          ),
                          color: backgroundLight,
                          onPressed: () => model.navigateToCreatePage(),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 6.0, top: 9.0, bottom: 9.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Write something',
                                style: TextStyle(
                                  fontSize: 17.0,
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
                ),
                (model.messages != null && model.messages.length != 0)
                    ? ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, pos) {
                          return /* Container(
                      height: 422,
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 0.2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                      ),
                    ) */
                              MessageWidget(
                            message: model.messages[pos],
                            onLike:() => model.updateLikes(
                                messageId: model.messages[pos].id),
                            position: pos,
                          );
                        },
                        separatorBuilder: (context, pos) {
                          return Container(
                            height: 21,
                          );
                        },
                        itemCount: model.messages.length)
                    : Container(
                        height: 500,
                        child: Center(
                          child: Text('No messages, Write Sommething to start'),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
