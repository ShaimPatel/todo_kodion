import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodion_projects/DataBase/database_helper.dart';
import 'package:kodion_projects/Screen/profile/add/widget/multiselect_widegt.dart';

class AddUserController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> numberController = TextEditingController().obs;
  GlobalKey<FormState> globalKey = GlobalKey();

  RxList<String> genderList = ['Male', "Female", "Other"].obs;
  RxString? dropdownvalue = ''.obs;

  RxList selectedItem = [].obs;

  showMultiSelect() async {
    RxList<String> skillsList =
        ['Java', 'Flutter', 'Kotlin', '.Net', 'Php', 'Angular', 'Node.js'].obs;

    final RxList? results = await showDialog(
        context: navigationKey.currentState!.context,
        builder: (BuildContext context) {
          return MultiSelectWidget(items: skillsList);
        });
    if (results != null) {
      print("results : $results");
      selectedItem.value = results;
    }
  }
}
