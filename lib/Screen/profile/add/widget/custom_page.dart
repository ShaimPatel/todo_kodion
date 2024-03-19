// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kodion_projects/Custom%20Page/my_custom_clipper1.dart';
import 'package:kodion_projects/Custom%20Page/my_custom_clipper2.dart';

class CustomPage extends StatelessWidget {
  var userData;
  CustomPage({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //todo : 1st Clipper
        ClipPath(
          clipper: MyCustomClipper(),
          child: Container(
            height: 200,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: Color(0xFFB394C9),
            ),
          ),
        ),
        //todo : 2st Clipper

        ClipPath(
          clipper: MyCustomClipper2(),
          child: Container(
            height: 160,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: Color(0xFF49545F),
            ),
          ),
        ),

        //todo : 3 BackButton

        Positioned(
            left: 20,
            top: 50,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
            )),

        //todo : Text
        Positioned(
            right: 20,
            top: MediaQuery.of(context).size.height * 0.20,
            child: Text(userData == null ? "Add Profile" : "Update Profile",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )))
      ],
    );
  }
}
