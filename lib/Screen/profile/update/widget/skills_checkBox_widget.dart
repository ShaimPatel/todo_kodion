// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodion_projects/Screen/profile/update/Controller/user_update_controller.dart';

class SkillsCheckBoxWidget extends StatelessWidget {
  RxList<String> items;
  SkillsCheckBoxWidget({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final skillController = Get.put(UserUpdateController());
    return Obx(() => AlertDialog(
          title: const Text("Select Skills"),
          content: SingleChildScrollView(
            child: ListBody(
              children: items.value
                  .map((item) => CheckboxListTile(
                        value: skillController.selectedItem.contains(item),
                        title: Text(item.toString()),
                        controlAffinity: ListTileControlAffinity.trailing,
                        onChanged: (isChecked) => skillController.itemChange(
                          item.obs,
                          isChecked!.obs,
                        ),
                      ))
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
                onPressed: skillController.cancleItem,
                child: const Text("Cancle")),
            TextButton(
                onPressed: skillController.addData, child: const Text("Add"))
          ],
        ));
  }
}
