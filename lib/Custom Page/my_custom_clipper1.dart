import 'package:flutter/cupertino.dart';

class MyCustomClipper extends CustomClipper<Path> {
  //todo: For this method is getting the path..
  //!The getClip method is called whenever the custom clip needs to be updated and this method has a Size parameter that gives widget height and width values.
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width / 0.5, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
