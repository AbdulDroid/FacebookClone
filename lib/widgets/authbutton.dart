import 'package:flutter/material.dart';

class ButtonWithLoader extends StatefulWidget {
  final bool loading;
  final String text;
  final Function onPressed;
  final bool enabled;
  final Color color;
  const ButtonWithLoader(
      {@required this.text,
      this.loading = false,
      @required this.onPressed,
      this.enabled = true,
      @required this.color});
  @override
  _ButtonWithLoaderState createState() => _ButtonWithLoaderState();
}

class _ButtonWithLoaderState extends State<ButtonWithLoader> {
  @override
  Widget build(BuildContext context) {
    return !widget.loading
        ? RaisedButton(
            onPressed: widget.onPressed,
            color: widget.color,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 18.0,
              ),
              child: Text(
                widget.text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
                side: BorderSide(color: widget.color)),
          )
        : RaisedButton(
            onPressed: widget.onPressed,
            color: widget.color,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 18.0,
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  Container(width: 5),
                  Text(
                    widget.text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
                side: BorderSide(color: widget.color)),
          );
  }
}
