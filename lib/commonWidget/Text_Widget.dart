import 'package:flutter/cupertino.dart';

class Textwidget extends StatelessWidget {
  final String title;
  final double fontsize;
  FontWeight? fontWeight;
  Color? color;

  Textwidget({required this.title, required this.fontsize,this.fontWeight,this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: fontsize,fontWeight: fontWeight,color: color),
    );
  }
}
