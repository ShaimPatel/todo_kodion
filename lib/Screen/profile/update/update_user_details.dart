// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kodion_projects/Common%20widget/custome_textFeaild.dart';
import 'package:kodion_projects/Custom%20Page/my_custom_clipper1.dart';
import 'package:kodion_projects/Custom%20Page/my_custom_clipper2.dart';
import 'package:kodion_projects/DataBase/database_helper.dart';
import 'package:kodion_projects/Screen/profile/add/controller/user_skills_provider.dart';
import 'package:kodion_projects/Screen/profile/update/Controller/user_update_controller.dart';

class UserUpdateDataPage extends StatelessWidget {
  var userData;

  UserUpdateDataPage({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    final updateController = Get.put(UserUpdateController());
    updateController.getUserDetails(userData);
    print(userData["userSkills"]);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                //todo : 1st Clipper
                ClipPath(
                  clipper: MyCustomClipper(),
                  child: Container(
                    height: 200,
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                      color: Color(0xFFB394C9),
                    ),
                  ),
                ),
                //todo : 2st Clipper

                ClipPath(
                  clipper: MyCustomClipper2(),
                  child: Container(
                    height: 160,
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                      color: Color(0xFF49545F),
                    ),
                  ),
                ),

                //todo : 3 BackButton

                Positioned(
                    left: 20,
                    top: 50,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    )),

                //todo : Text
                Positioned(
                    right: 20,
                    top: MediaQuery.of(context).size.height * 0.20,
                    child: const Text("Update Profile",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )))
              ],
            ),
            const SizedBox(height: 15),
            //! Input Fields
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Form(
                key: updateController.globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! Name
                    Obx(
                      () => CustomTextField(
                        labelName: 'Name',
                        textEditingController:
                            updateController.nameController.value,
                        inputType: TextInputType.text,
                        prefixIcon: const Icon(Icons.person),
                        textInputAction: TextInputAction.next,
                        customValidate: (text) {
                          if (text.isEmpty) {
                            return "Enter your Name";
                          }
                        },
                      ),
                    ),
                    //! Email
                    CustomTextField(
                      labelName: 'Email',
                      textEditingController:
                          updateController.emailController.value,
                      inputType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.mail),
                      textInputAction: TextInputAction.next,
                      customValidate: (text) {
                        if (text.isEmpty) {
                          return "Enter your email";
                        }
                      },
                    ),
                    //! Number
                    CustomTextField(
                      labelName: 'Number',
                      textEditingController:
                          updateController.numberController.value,
                      inputType: TextInputType.number,
                      prefixIcon: const Icon(Icons.phone),
                      textInputAction: TextInputAction.done,
                      customValidate: (text) {
                        if (text.isEmpty) {
                          return "Enter your number";
                        }
                      },
                    ),
                    //!Gender
                    Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Gender",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              height: 55,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFB394C9),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.black87, width: 1)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.male),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: DropdownButton(
                                          isExpanded: true,
                                          underline: const SizedBox(),
                                          value: updateController
                                                  .dropdownvalue!.value.isEmpty
                                              ? null
                                              : updateController
                                                  .dropdownvalue!.value,
                                          items: updateController.genderList
                                              .map((element) {
                                            return DropdownMenuItem(
                                                enabled: true,
                                                value: element,
                                                child:
                                                    Text(element.toString()));
                                          }).toList(),
                                          onChanged: (newValue) {
                                            updateController.dropdownvalue!
                                                .value = newValue.toString();
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),

                    //! Skills
                    const SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Skills",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        InkWell(
                            onTap: () {
                              updateController.showMultiSelect();
                            },
                            child: Obx(
                              () => Container(
                                padding: const EdgeInsets.all(20.0),

                                // height: 50,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: const Color(0xFFB394C9),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.black87, width: 1)),
                                child: Wrap(
                                  children: updateController.selectedItem
                                      .map(
                                        (e) => Chip(
                                          label: Text(e),
                                          onDeleted: () {
                                            updateController.selectedItem
                                                .remove(e);
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //todo:  Button Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SizedBox(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF49545F),
                  ),
                  onPressed: () async {
                    if (updateController.globalKey.currentState!.validate()) {
                      await DataBaseHelper.dataBaseHelper.insert({
                        DataBaseHelper.userName:
                            updateController.nameController.value.text,
                        DataBaseHelper.userEmail:
                            updateController.emailController.value.text,
                        DataBaseHelper.userNumber: updateController
                            .numberController.value.text
                            .toString(),
                        DataBaseHelper.userGender:
                            updateController.dropdownvalue!.value,
                      });

                      updateController.nameController.value.clear();
                      updateController.emailController.value.clear();
                      updateController.numberController.value.clear();
                      Get.back();
                      Get.snackbar("User Successfully registered", "",
                          backgroundColor: Colors.green.shade100);
                    }
                  },
                  child: Text(
                    "update".toUpperCase(),
                    style: const TextStyle(fontSize: 18, color: Colors.white),
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
