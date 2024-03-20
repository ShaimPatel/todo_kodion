import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodion_projects/Screen/Profile/add_update_profile/controller/add_update_profile_provider.dart';

class FormWidget extends StatelessWidget {
  FormWidget({super.key});
  final controller = Get.put(AddUpdateUserProfileController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Form(
        key: controller.globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //! Name
            const Text("Name",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
            const SizedBox(height: 2),
            TextFormField(
              decoration: const InputDecoration(
                  fillColor: Color.fromARGB(255, 211, 162, 203),
                  enabled: true,
                  filled: true,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 5)),
              cursorColor: Colors.black,
              controller: controller.nameController.value,
              enabled: true,
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.name,
              minLines: 1,
              maxLines: 2,
              style: const TextStyle(
                color: Colors.black,
              ),
              validator: (text) {
                if (text!.isEmpty) {
                  return "Enter your name";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            const Text("Email",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
            const SizedBox(height: 2),
            TextFormField(
                decoration: const InputDecoration(
                    fillColor: Color.fromARGB(255, 211, 162, 203),
                    enabled: true,
                    filled: true,
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.mail),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 5)),
                cursorColor: Colors.black,
                controller: controller.emailController.value,
                enabled: true,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                minLines: 1,
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.black,
                ),
                validator: (text) {
                  const pattern =
                      r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                  final regex = RegExp(pattern);
                  if (text!.isEmpty) {
                    return "Enter your email";
                  } else if (!regex.hasMatch(text)) {
                    return "Enter a valid email address";
                  }
                  return null;
                }),
            const SizedBox(height: 10),
            const Text("Number",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
            const SizedBox(height: 2),
            TextFormField(
              decoration: const InputDecoration(
                  fillColor: Color.fromARGB(255, 211, 162, 203),
                  enabled: true,
                  filled: true,
                  counter: SizedBox(),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 5)),
              cursorColor: Colors.black,
              controller: controller.numberController.value,
              enabled: true,
              textInputAction: TextInputAction.done,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              maxLength: 10,
              minLines: 1,
              maxLines: 2,
              style: const TextStyle(
                color: Colors.black,
              ),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "Enter your number";
                }
                return null;
              },
            ),
            //!Gender
            Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Gender",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  fillColor: Color.fromARGB(255, 211, 162, 203),
                                  enabled: true,
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Image(
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                        "assets/icons/gender.png",
                                      ),
                                      height: 2,
                                      width: 2,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5)),
                              isExpanded: true,
                              autovalidateMode: AutovalidateMode.always,
                              isDense: true,
                              validator: (value) {
                                return value == null
                                    ? "Choose your gender"
                                    : null;
                              },
                              value: controller.dropdownvalue!.value.isEmpty
                                  ? null
                                  : controller.dropdownvalue!.value,
                              items: [
                                ...controller.genderList.map((element) {
                                  return DropdownMenuItem(
                                      enabled: true,
                                      value: element,
                                      child: Text(element.toString()));
                                }),
                              ],
                              onChanged: (newValue) {
                                controller.dropdownvalue!.value =
                                    newValue.toString();
                              }),
                        ),
                      ],
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
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 5),
                Obx(
                  () => InkWell(
                    onTap: () {
                      controller.showMultiSelect();
                    },
                    child: Container(
                      padding: controller.selectedItemData.isEmpty
                          ? const EdgeInsets.all(25.0)
                          : const EdgeInsets.symmetric(horizontal: 5),
                      // height: 50,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 211, 162, 203),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black87, width: 1)),
                      child: Wrap(
                        spacing: 10,
                        children: controller.selectedItemData.value
                            .map(
                              (e) => Chip(
                                deleteButtonTooltipMessage: "Remove skills",
                                label: Text(e),
                                onDeleted: () {
                                  controller.selectedItemData.remove(e);
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.isSkillsSelected.value,
                    child: const Text(
                      "select your skills",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
