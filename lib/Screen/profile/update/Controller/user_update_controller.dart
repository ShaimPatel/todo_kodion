import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodion_projects/DataBase/database_helper.dart';
import 'dart:developer' as developer;

import 'package:kodion_projects/Screen/profile/update/widget/skills_checkBox_widget.dart';

class UserUpdateController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> numberController = TextEditingController().obs;
  GlobalKey<FormState> globalKey = GlobalKey();

  RxList<String> genderList = ['Male', "Female", "Other"].obs;
  RxString? dropdownvalue = ''.obs;
  RxList selectedItem = [].obs;
  RxList selectedItemData = [].obs;

  RxBool isChecked = false.obs;
  RxBool isClicked = false.obs;

  //! Get UserDetails
  getUserDetails(userData) async {
    String userSkillsAsString = userData['userSkills'];
    List<dynamic> userSkillsList = userSkillsAsString.split(',');
    nameController.value.text = userData['userName'];
    emailController.value.text = userData['userEmail'];
    numberController.value.text = userData['userNumber'];
    dropdownvalue!.value = userData['userGender'];
    selectedItem.value = userSkillsList;
    print(selectedItem.value);
  }

//! For adding the Value or removing the value ..
  void itemChange(RxString itemValue, RxBool isSelected) {
    print("Itemdata:: $itemValue");
    if (isSelected.value) {
      selectedItem.add(itemValue.value);
    } else {
      selectedItem.remove(itemValue.value);
    }
  }

  void cancleItem() {
    Get.back();
  }

  void addData() {
    Get.back(result: selectedItem);
    developer.log(selectedItem.toString());
    print(selectedItem.toString());
  }

  showMultiSelect() async {
    RxList<String> skillsList =
        ['Java', 'Flutter', 'Kotlin', '.Net', 'Php', 'Angular', 'Node.js'].obs;

    final RxList? results = await showDialog(
        context: navigationKey.currentState!.context,
        builder: (BuildContext context) {
          return SkillsCheckBoxWidget(items: skillsList);
        });
    if (results != null) {
      selectedItemData.value = results;
    }
  }
}
