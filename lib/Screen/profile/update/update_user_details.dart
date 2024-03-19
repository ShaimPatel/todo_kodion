// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kodion_projects/Common%20widget/custome_textFeaild.dart';
import 'package:kodion_projects/Custom%20Page/my_custom_clipper1.dart';
import 'package:kodion_projects/Custom%20Page/my_custom_clipper2.dart';
import 'package:kodion_projects/DataBase/database_helper.dart';
import 'package:kodion_projects/Screen/profile/update/Controller/user_update_controller.dart';
import 'package:kodion_projects/Screen/profile/update/widget/form_widget.dart';

class UserUpdateDataPage extends StatelessWidget {
  var userData;

  UserUpdateDataPage({
    super.key,
    required this.userData,
  });
  var updateController = Get.put(UserUpdateController());

  @override
  Widget build(BuildContext context) {
    //! Referesing the page
    updateController.getUserDetails(userData);
    print(" Calling :: ${updateController.getUserDetails(userData)}");

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
            FromWidegtPage(),
            //todo:  Button Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: Obx(
                    () => updateController.isClicked.isFalse
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF49545F),
                            ),
                            onPressed: () async {
                              if (updateController.globalKey.currentState!
                                  .validate()) {
                                await DataBaseHelper.dataBaseHelper
                                    .updateUserDetails({
                                  DataBaseHelper.userName: updateController
                                      .nameController.value.text,
                                  DataBaseHelper.userEmail: updateController
                                      .emailController.value.text,
                                  DataBaseHelper.userNumber: updateController
                                      .numberController.value.text
                                      .toString(),
                                  DataBaseHelper.userGender:
                                      updateController.dropdownvalue!.value,
                                  DataBaseHelper.userSkills:
                                      updateController.selectedItem.join(',')
                                }, userData['id']);

                                updateController.nameController.value.clear();
                                updateController.emailController.value.clear();
                                updateController.numberController.value.clear();
                                Get.back();
                                Get.snackbar(
                                    "UserData Update Successfully ", "",
                                    backgroundColor: Colors.green.shade100);
                              }
                            },
                            child: Text(
                              "update".toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
