import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodion_projects/DataBase/database_helper.dart';
import 'package:kodion_projects/Screen/profile/add/widget/multiselect_widegt.dart';
import 'dart:developer' as developer;

class AddUserController extends GetxController {
  Rx<TextEditingController> nameAddController = TextEditingController().obs;
  Rx<TextEditingController> emailAddController = TextEditingController().obs;
  Rx<TextEditingController> numberAddController = TextEditingController().obs;
  GlobalKey<FormState> globalKeyAddUser = GlobalKey();

  RxList<String> addUsergenderList = ['Male', "Female", "Other"].obs;
  RxString? dropdownvalueaddUser = ''.obs;

  RxList selectedItemAddUser = [].obs;
  RxList selectedItem = [].obs;

  getUserDetails(userData) async {
    String userSkillsAsString = userData['userSkills'];
    List<dynamic> userSkillsList = userSkillsAsString.split(',');
    nameAddController.value.text = userData['userName'];
    emailAddController.value.text = userData['userEmail'];
    numberAddController.value.text = userData['userNumber'];
    dropdownvalueaddUser!.value = userData['userGender'];
    selectedItemAddUser.value = userSkillsList;
    print(selectedItemAddUser.value);
  }

//! For adding the Value or removing the value ..
  void itemChange(RxString itemValue, RxBool isSelected) {
    print("Itemdata:: $itemValue");
    if (isSelected.value) {
      selectedItemAddUser.add(itemValue.value);
    } else {
      selectedItemAddUser.remove(itemValue.value);
    }
  }

  void cancleItem() {
    Get.back();
  }

  void addData() {
    Get.back(result: selectedItemAddUser);
    developer.log(selectedItemAddUser.toString());
    print(selectedItemAddUser.toString());
  }

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
