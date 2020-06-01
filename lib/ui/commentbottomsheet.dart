import 'package:facebook_clone/constants/colors.dart';
import 'package:facebook_clone/viewmodel/commentsheetviewmodel.dart';
import 'package:facebook_clone/widgets/commentwidget.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';

class CommentBottomSheet extends StatefulWidget {
  final String messageId;
  CommentBottomSheet(this.messageId);
  @override
  _CommentBottomSheetState createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  bool filled = false;
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CommentBottomSheetViewModel>.withConsumer(
      viewModelBuilder: () => CommentBottomSheetViewModel(),
      onModelReady: (model) => model.listenToComments(widget.messageId),
      builder: (context, model, _) => Container(
        padding: EdgeInsets.only(
          top: 20,
          bottom: 27,
          left: 21,
          right: 27,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                'Comments',
                style: TextStyle(
                  color: textDark,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            (model.comments != null && model.comments.length != 0)
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 280.0,
                      ),
                      child: ListView.separated(
                        itemBuilder: (context, pos) {
                          return CommentWidget(pos, model.comments[pos]);
                        },
                        separatorBuilder: (context, index) => Container(height: 15.0,),
                        itemCount: model.comments.length,
                        shrinkWrap: true,
                      ),
                    ),
                  )
                : Container(
                    height: 140.0,
                    child: Center(
                      child: Text(
                        'No Comments',
                        style: TextStyle(
                          color: textLighter,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        filled = true;
                      } else {
                        filled = false;
                      }
                      setState(() {
                        filled = filled;
                      });
                    },
                    autofocus: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: stroke),
                          borderRadius: BorderRadius.circular(30.0)),
                      hintStyle: TextStyle(
                        color: textLighter,
                        fontSize: 13.0,
                        fontWeight: FontWeight.normal,
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.all(15.0),
                      hintText: 'Write Comment',
                      filled: true,
                      fillColor: backgroundLight,
                    ),
                    style: TextStyle(
                      color: textDark,
                      fontSize: 13.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Container(
                  width: 8.0,
                ),
                !model.addBusy
                    ? IconButton(
                        icon: ImageIcon(
                          AssetImage(
                            filled
                                ? 'images/ic_send_active.png'
                                : 'images/ic_send_inactive.png',
                          ),
                          size: 29.0,
                          color: filled ? blue : Color(0xFFAEB3BC),
                        ),
                        onPressed: () {
                            if (filled) {
                              model.addComment(_controller.text);
                              _controller.text = '';
                            }
                        },
                      )
                    : SizedBox(
                        height: 29.0,
                        width: 29.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
