import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchUserProvider extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;
}
