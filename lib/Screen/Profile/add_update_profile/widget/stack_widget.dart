// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodion_projects/Custom/cutom_clipper_one.dart';
import 'package:kodion_projects/Custom/cutom_clipper_two.dart';

class StackWidget extends StatelessWidget {
  var userData;
  StackWidget({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: CutomClipperTwo(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: Color(0xFF49545F),
            ),
          ),
        ),
        ClipPath(
          clipper: CustomClipperOne(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.24,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: Color(0xFFB394C9),
            ),
          ),
        ),

        //! Back Button

        Positioned(
            left: 10,
            top: Get.height * 0.07,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.keyboard_arrow_left_outlined,
                size: 35,
                color: Colors.white,
              ),
            )),

        //! Regster Text

        Positioned(
          right: 20,
          top: Get.height * 0.2,
          child: Text(
            userData == null ? "Add Profile" : "Update Profile",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
