import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: Get.height * 0.3,
        width: Get.width,
        child: Column(
          children: [
            Image(
              image: const AssetImage(
                "assets/images/No data-cuate.png",
              ),
              fit: BoxFit.cover,
              height: Get.height * 0.2,
              width: Get.width * 0.8,
            ),
            const SizedBox(height: 20),
            Text(
              "no data available".toUpperCase(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
