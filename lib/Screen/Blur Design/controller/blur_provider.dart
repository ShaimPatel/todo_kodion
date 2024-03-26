import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlurController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> numberController = TextEditingController().obs;

  RxBool isVisbile = true.obs;
  RxList<bool> isEditing = [true, true, true].obs;
}
