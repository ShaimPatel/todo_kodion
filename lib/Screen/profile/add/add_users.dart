import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodion_projects/Common%20widget/custome_textFeaild.dart';
import 'package:kodion_projects/Custom%20Page/my_custom_clipper1.dart';
import 'package:kodion_projects/Custom%20Page/my_custom_clipper2.dart';
import 'package:kodion_projects/DataBase/database_helper.dart';
import 'package:kodion_projects/Screen/profile/add/controller/add_user_provider.dart';

class RegisterationPage extends StatelessWidget {
  const RegisterationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddUserController());
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
                    child: const Text("Add Profile",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )))
              ],
            ),
            const SizedBox(height: 15),
            //! Input Fields
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Form(
                key: controller.globalKeyAddUser,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! Name
                    CustomTextField(
                      labelName: 'Name',
                      textEditingController: controller.nameAddController.value,
                      inputType: TextInputType.text,
                      prefixIcon: const Icon(Icons.person),
                      textInputAction: TextInputAction.next,
                      customValidate: (text) {
                        if (text.isEmpty) {
                          return "Enter your Name";
                        }
                      },
                    ),
                    //! Email
                    CustomTextField(
                      labelName: 'Email',
                      textEditingController:
                          controller.emailAddController.value,
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
                          controller.numberAddController.value,
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
                                          value: controller
                                                  .dropdownvalueaddUser!
                                                  .value
                                                  .isEmpty
                                              ? null
                                              : controller
                                                  .dropdownvalueaddUser!.value,
                                          items: [
                                            ...controller.addUsergenderList
                                                .map((element) {
                                              return DropdownMenuItem(
                                                  enabled: true,
                                                  value: element,
                                                  child:
                                                      Text(element.toString()));
                                            }),
                                          ],
                                          onChanged: (newValue) {
                                            controller.dropdownvalueaddUser!
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
                        Obx(
                          () => InkWell(
                            onTap: () {
                              controller.showMultiSelect();
                            },
                            child: Container(
                              padding: controller.selectedItemAddUser.isEmpty
                                  ? const EdgeInsets.all(25.0)
                                  : const EdgeInsets.symmetric(horizontal: 5),
                              // height: 50,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFB394C9),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.black87, width: 1)),
                              child: Wrap(
                                spacing: 10,
                                children: controller.selectedItemAddUser.value
                                    .map(
                                      (e) => Chip(
                                        deleteButtonTooltipMessage:
                                            "Remove skills",
                                        label: Text(e),
                                        onDeleted: () {
                                          controller.selectedItemAddUser
                                              .remove(e);
                                        },
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        )
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
                    if (controller.globalKeyAddUser.currentState!.validate()) {
                      await DataBaseHelper.dataBaseHelper.insert({
                        DataBaseHelper.userName:
                            controller.nameAddController.value.text,
                        DataBaseHelper.userEmail:
                            controller.emailAddController.value.text,
                        DataBaseHelper.userNumber: controller
                            .numberAddController.value.text
                            .toString(),
                        DataBaseHelper.userGender:
                            controller.dropdownvalueaddUser!.value,
                        DataBaseHelper.userSkills:
                            controller.selectedItemAddUser.join(','),
                      });

                      controller.nameAddController.value.clear();
                      controller.emailAddController.value.clear();
                      controller.numberAddController.value.clear();
                      Get.back();
                      Get.snackbar("User Successfully registered", "",
                          backgroundColor: Colors.green.shade100);
                    }
                  },
                  child: Text(
                    "Submit".toUpperCase(),
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
