import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodion_projects/Common%20widget/custome_textFeaild.dart';
import 'package:kodion_projects/Screen/profile/update/Controller/user_update_controller.dart';

class FromWidegtPage extends StatelessWidget {
  FromWidegtPage({super.key});

  var updateController = Get.put(UserUpdateController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Form(
        key: updateController.globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //! Name
            // CustomTextField(
            //   labelName: 'Name',
            //   textEditingController: updateController.nameController.value,
            //   inputType: TextInputType.text,
            //   prefixIcon: const Icon(Icons.person),
            //   textInputAction: TextInputAction.next,
            //   customValidate: (text) {
            //     if (text.isEmpty) {
            //       return "Enter your Name";
            //     }
            //   },
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Name",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  style: const TextStyle(fontSize: 14),
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: updateController.nameController.value,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    return null;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    filled: true,
                    fillColor: Color(0xFFB394C9),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
            //! Email
            CustomTextField(
              labelName: 'Email',
              textEditingController: updateController.emailController.value,
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
              textEditingController: updateController.numberController.value,
              inputType: TextInputType.number,
              prefixIcon: const Icon(Icons.phone),
              textInputAction: TextInputAction.next,
              customValidate: (text) {
                if (text.isEmpty) {
                  return "Enter your number";
                }
              },
            ),
            //!Gender
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Gender",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Obx(
                  () => Container(
                    height: 55,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: const Color(0xFFB394C9),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black87, width: 1)),
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
                                    : updateController.dropdownvalue!.value,
                                items:
                                    updateController.genderList.map((element) {
                                  return DropdownMenuItem(
                                      enabled: true,
                                      value: element,
                                      child: Text(element.toString()));
                                }).toList(),
                                onChanged: (newValue) {
                                  updateController.dropdownvalue!.value =
                                      newValue.toString();
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),

            //! Skills
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Skills",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Obx(
                  () => InkWell(
                    onTap: () {
                      updateController.showMultiSelect();
                    },
                    child: Container(
                      padding: updateController.selectedItem.isEmpty
                          ? const EdgeInsets.all(25.0)
                          : const EdgeInsets.symmetric(horizontal: 5),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: const Color(0xFFB394C9),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black87, width: 1)),
                      child: Wrap(
                        spacing: 10,
                        children: updateController.selectedItem
                            .map(
                              (e) => Chip(
                                deleteButtonTooltipMessage: "Remove skills",
                                label: Text(e),
                                onDeleted: () {
                                  updateController.selectedItem.remove(e);
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
    );
  }
}
