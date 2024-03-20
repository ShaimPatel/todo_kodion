import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodion_projects/Screen/DataBase/database_helper.dart';
import 'package:kodion_projects/Screen/Profile/add_update_profile/controller/add_update_profile_provider.dart';
import 'package:kodion_projects/Screen/Profile/add_update_profile/widget/form_wudget.dart';
import 'package:kodion_projects/Screen/Profile/add_update_profile/widget/stack_widget.dart';

class AddUpdateUserProfilePage extends StatelessWidget {
  var userData;
  AddUpdateUserProfilePage({super.key, required this.userData});

  final controller = Get.put(AddUpdateUserProfileController());

  @override
  Widget build(BuildContext context) {
    userData == null ? null : controller.getUserDetails(userData);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            StackWidget(userData: userData),
            const SizedBox(height: 15),
            //! Input Fields
            FormWidget(),
            const SizedBox(height: 20),
            //todo:  Button Section
            SizedBox(
              width: Get.width * 0.6,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF49545F),
                ),
                onPressed: () async {
                  if (controller.globalKey.currentState!.validate()) {
                    userData == null
                        ? await DataBaseHelper.dataBaseHelper.insert({
                            DataBaseHelper.userName:
                                controller.nameController.value.text,
                            DataBaseHelper.userEmail:
                                controller.emailController.value.text,
                            DataBaseHelper.userNumber: controller
                                .numberController.value.text
                                .toString(),
                            DataBaseHelper.userGender:
                                controller.dropdownvalue!.value,
                            DataBaseHelper.userSkills:
                                controller.selectedItem.join(','),
                          })
                        : await DataBaseHelper.dataBaseHelper
                            .updateUserDetails({
                            DataBaseHelper.userName:
                                controller.nameController.value.text,
                            DataBaseHelper.userEmail:
                                controller.emailController.value.text,
                            DataBaseHelper.userNumber: controller
                                .numberController.value.text
                                .toString(),
                            DataBaseHelper.userGender:
                                controller.dropdownvalue!.value,
                            DataBaseHelper.userSkills:
                                controller.selectedItem.join(',')
                          }, userData['id']);

                    Get.back();
                    Get.snackbar("User Successfully registered", "",
                        backgroundColor: Colors.green.shade100);
                  }
                },
                child: Text(
                  userData == null
                      ? "Submit".toUpperCase()
                      : "Update".toUpperCase(),
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
