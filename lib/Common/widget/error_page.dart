import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.3,
      width: Get.width,
      child: Column(
        children: [
          Image(
            image: const AssetImage(
              "assets/images/No data-cuate.png",
            ),
            fit: BoxFit.cover,
            height: Get.height * 0.4,
            width: Get.width * 0.8,
          ),
          const SizedBox(height: 10),
          const Text(
            "No data avilable.",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
