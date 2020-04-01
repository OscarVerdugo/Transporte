import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final Function onTap;
  final color;
  final double width;
  final double height;
  final Widget child;
  
  ButtonWidget({Key key, @required this.onTap, this.color = 0xFF29DF96,this.height = 50.0, this.width = 200.0,@required this.child})
      : super(key: key);

  @override 
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Container(
        width: widget.width,
        height: widget.height,
        // padding: EdgeInsets.symmetric(horizontal:30.0,vertical:10.0),
        child: Center(child: widget.child),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      elevation: 0.0,
      color: Color(widget.color),
      textColor: Colors.white ,
      onPressed: widget.onTap,
    );
}
}
    // Container(
    //     child: InkWell(
    //   child: Container(
    //     width: 200.0,
    //     height: 50.0,
    //     decoration: BoxDecoration(
    //         gradient:
    //             LinearGradient(colors: [Color(0xFF29DF96), Color(0xFF30EDA1)]),
    //         borderRadius: BorderRadius.circular(6.0),
    //         boxShadow: [
    //           BoxShadow(
    //               color: Color(0xFF000000).withOpacity(0.3),
    //               offset: Offset(0.0, 8.0),
    //               blurRadius: 8.0)
    //         ]),
    //     child: Material(
    //         color: Colors.transparent,
    //         child: InkWell(
    //           onTap: widget.onTap,
    //             child: Center(
    //           child: Text(
    //             widget.text.toUpperCase(),
    //             style: TextStyle(color: Colors.white,fontFamily: "Segoe UI",fontSize:24.0,letterSpacing:1.0,fontWeight: FontWeight.w500),
    //           ),
    //         ))),
    //   ),
    // ))