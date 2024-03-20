import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodion_projects/Screen/Profile/add_update_profile/controller/add_update_profile_provider.dart';

class UserSkillsWidget extends StatelessWidget {
  UserSkillsWidget({super.key});

  final controller = Get.put(AddUpdateUserProfileController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
            text: const TextSpan(
          children: [
            TextSpan(
                text: "Skills",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
            TextSpan(text: " *", style: TextStyle(color: Colors.red)),
          ],
        )),
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
        const SizedBox(height: 10),
        Obx(
          () => Visibility(
            visible: (controller.isSkillsSelected.value &&
                    controller.selectedItemData.isEmpty) ==
                true,
            child: const Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Text(
                "Select your skills",
                style: TextStyle(
                  color: Color.fromARGB(255, 187, 39, 29),
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
