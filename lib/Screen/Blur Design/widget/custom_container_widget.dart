import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double height;
  final double width;
  final double radiusValue;
  final Color firstColor;
  final Color secondColor;

  const CustomContainer(
      {super.key,
      required this.height,
      required this.width,
      required this.radiusValue,
      required this.firstColor,
      required this.secondColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [firstColor, secondColor],
        ),
        color: Colors.amber,
        borderRadius: BorderRadius.circular(radiusValue),
      ),
    );
  }
}
