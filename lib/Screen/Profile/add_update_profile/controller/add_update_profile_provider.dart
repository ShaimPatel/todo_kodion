import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;

import 'package:kodion_projects/Common/global_data.dart';
import 'package:kodion_projects/Screen/Profile/add_update_profile/widget/multiselect_widegt.dart';

class AddUpdateUserProfileController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> numberController = TextEditingController().obs;
  GlobalKey<FormState> globalKey = GlobalKey();

  RxList<String> genderList = ['Male', "Female", "Other"].obs;
  RxString? dropdownvalue = ''.obs;

  RxList selectedItemData = [].obs;
  RxList selectedItem = [].obs;

  RxBool isSkillsSelected = false.obs;

  getUserDetails(userData) async {
    String userSkillsAsString = userData['userSkills'];
    List<dynamic> userSkillsList = userSkillsAsString.split(',');
    nameController.value.text = userData['userName'];
    emailController.value.text = userData['userEmail'];
    numberController.value.text = userData['userNumber'];
    dropdownvalue!.value = userData['userGender'];
    selectedItemData.value = userSkillsList;
    print(selectedItemData.value);
  }

//! For adding the Value or removing the value ..
  void itemChange(RxString itemValue, RxBool isSelected) {
    print("Itemdata:: $itemValue");
    if (isSelected.value) {
      selectedItemData.add(itemValue.value);
    } else {
      selectedItemData.remove(itemValue.value);
    }
  }

  void cancleItem() {
    Get.back();
  }

  void addData() {
    Get.back(result: selectedItemData);
    developer.log(selectedItemData.toString());
    print(selectedItemData.toString());
  }

  showMultiSelect() async {
    RxList<String> skillsList =
        ['Java', 'Flutter', 'Kotlin', '.Net', 'Php', 'Angular', 'Node.js'].obs;

    final RxList? results = await showDialog(
        context: GlobalData.navigatorStateKey.currentState!.context,
        builder: (BuildContext context) {
          return MultiSelectWidget(items: skillsList);
        });
    if (results != null) {
      print("results : $results");
      selectedItem.value = results;
    }
  }
}
