import 'package:facebook_clone/constants/colors.dart';
import 'package:facebook_clone/viewmodel/createviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class CreateMessage extends StatefulWidget {
  @override
  _CreateMessageState createState() => _CreateMessageState();
}

class _CreateMessageState extends State<CreateMessage> {
  bool complete = false;
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CreateMessageViewModel>.withConsumer(
      viewModelBuilder: () => CreateMessageViewModel(),
      builder: (context, model, _) => Scaffold(
        backgroundColor: backgroundLight,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(19.0, 52.0, 19.0, 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      autofocus: false,
                      onTap: () => model.goBack(),
                      child: Image(
                        image: AssetImage("images/ic_back.png"),
                        height: 34.0,
                        width: 34.0,
                      ),
                    ),
                    !model.createBusy
                        ? ((complete == true && model.image != null)
                            ? IconButton(
                                icon: ImageIcon(
                                  AssetImage("images/ic_send_active.png"),
                                  color: blue,
                                  size: 29.0,
                                ),
                                onPressed: () => model.addMessage(
                                    message: messageController.text),
                              )
                            : IconButton(
                                icon: ImageIcon(
                                  AssetImage("images/ic_send_inactive.png"),
                                  color: Color(0xFFAEB3BC),
                                  size: 29.0,
                                ),
                                onPressed: () => model.showDialog(
                                  title: 'Incomplete Data',
                                  msg:
                                      'Please add text and select image to continue!',
                                ),
                              ))
                        : SizedBox(
                            height: 29.0,
                            width: 29.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                            ),
                          )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 26.0, left: 8.0, right: 9.0),
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
                      child: TextField(
                        controller: messageController,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              complete = true;
                            });
                          }
                        },
                        minLines: 4,
                        maxLines: 6,
                        autofocus: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          filled: true,
                          fillColor: backgroundLight,
                          hintText: "Write something",
                          hintStyle: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.normal,
                            color: textLighter,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.normal,
                          color: textDark,
                        ),
                        cursorColor: strokeDarker,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: PopupMenuButton<String>(
                  onSelected: (value) => model.selectImage(value == 'Camera'),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 11.0, right: 24.0),
                    child: Image(
                      image: AssetImage("images/ic_camera.png"),
                      height: 28.0,
                      width: 28.0,
                      color: Color(0xFFAEB3BC),
                    ),
                  ),
                  itemBuilder: (context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem(
                      child: Center(
                        child: Text(
                          "Camera",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      value: 'Camera',
                    ),
                    const PopupMenuDivider(
                      height: 0.5,
                    ),
                    const PopupMenuItem(
                      child: Center(
                        child: Text(
                          "Gallery",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      value: 'Gallery',
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12.0),
                padding: EdgeInsets.zero,
                height: 234.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: model.image == null
                          ? AssetImage("")
                          : FileImage(model.image),
                      fit: BoxFit.cover),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
