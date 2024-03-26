import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodion_projects/Screen/Blur%20Design/controller/blur_provider.dart';
import 'package:kodion_projects/Screen/Blur%20Design/widget/custom_container_widget.dart';

class BlurPage extends StatelessWidget {
  BlurPage({
    super.key,
  });

  final blurController = Get.put(BlurController());

  @override
  Widget build(BuildContext context) {
    print("Before click : ${blurController.isVisbile.value}");

    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink[50]!,
              Colors.blue[100]!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: Get.height * 0.15,
              left: Get.width * 0.04,
              child: CustomContainer(
                height: 150,
                width: 150,
                radiusValue: 100,
                firstColor: Colors.red[700]!,
                secondColor: Colors.yellow[400]!,
              ),
            ),
            Positioned(
              top: Get.height * 0.35,
              right: Get.width * 0.04,
              child: CustomContainer(
                height: 200,
                width: 200,
                radiusValue: 100,
                firstColor: Colors.teal[300]!,
                secondColor: Colors.purple[100]!,
              ),
            ),
            Positioned(
              top: Get.height * 0.7,
              left: Get.width * 0.05,
              child: CustomContainer(
                height: 150,
                width: 150,
                radiusValue: 100,
                firstColor: Colors.pinkAccent,
                secondColor: Colors.pink[600]!,
              ),
            ),

            //! Here we make transparent background with blur
            Positioned(
              left: 30,
              top: Get.height * 0.22,
              child: AnimatedContainer(
                height: Get.height * 0.6,
                width: Get.width * 0.8,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                duration: const Duration(seconds: 1),
                curve: Curves.bounceIn,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      color: Colors.white.withOpacity(0.0),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 30,
              top: Get.height * 0.22,
              child: AnimatedContainer(
                height: Get.height * 0.6,
                width: Get.width * 0.8,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                duration: const Duration(seconds: 1),
                curve: Curves.bounceIn,
                child: Form(
                  child: Column(
                    children: [
                      Obx(() => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller:
                                        blurController.nameController.value,
                                    readOnly: blurController.isEditing[0],
                                    decoration: const InputDecoration(
                                      label: Text("Name"),
                                    ),
                                  ),
                                ),
                                blurController.isVisbile.value == true
                                    ? Row(
                                        children: [
                                          const CircleAvatar(
                                            backgroundColor: Colors.white,
                                            child: Icon(Icons.copy),
                                          ),
                                          const SizedBox(width: 5),
                                          CircleAvatar(
                                            backgroundColor: Colors.white,
                                            child: InkWell(
                                                onTap: () {
                                                  blurController
                                                      .isVisbile.value = false;
                                                  print(
                                                      "Before click : ${blurController.isVisbile.value}");

                                                  blurController.isEditing[0] =
                                                      !blurController
                                                          .isEditing[0];
                                                },
                                                child: const Icon(
                                                    Icons.edit_document)),
                                          ),
                                        ],
                                      )
                                    : InkWell(
                                        onTap: () {
                                          blurController.isVisbile.value = true;
                                          blurController.isEditing[0] =
                                              !blurController.isEditing[0];
                                        },
                                        child: const CircleAvatar(
                                            child: Icon(Icons.save)),
                                      )
                              ],
                            ),
                          )),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller:
                                      blurController.emailController.value,
                                  readOnly: blurController.isEditing[1],
                                  decoration: const InputDecoration(
                                    label: Text("Email"),
                                  ),
                                ),
                              ),
                              const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(Icons.copy),
                              ),
                              const SizedBox(width: 5),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: InkWell(
                                    onTap: () {
                                      blurController.isEditing[1] =
                                          !blurController.isEditing[1];
                                    },
                                    child: const Icon(Icons.edit_document)),
                              )
                            ],
                          ),
                        ),
                      ),
                      Obx(() => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller:
                                        blurController.numberController.value,
                                    readOnly: blurController.isEditing[2],
                                    decoration: const InputDecoration(
                                      label: Text("Number"),
                                    ),
                                  ),
                                ),
                                const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.copy),
                                ),
                                const SizedBox(width: 5),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: InkWell(
                                      onTap: () {
                                        blurController.isEditing[2] =
                                            !blurController.isEditing[2];
                                      },
                                      child: const Icon(Icons.edit_document)),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
