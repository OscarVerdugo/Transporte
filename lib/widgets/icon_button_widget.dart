import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({Key key,@required this.child,this.color = 0xFF29DF96,@required this.onTap,this.scolor = 0xFF29DF96}) : super(key: key);

  final Widget child;
  final color;
  final scolor;
  final Function onTap;



  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Color(this.color), // button color
        child: InkWell(
          splashColor: Color(this.scolor), // inkwell color
          child: SizedBox(width: 60, height: 60, ),
          onTap:this.onTap,
        ),
      ),
    );
  }
}
