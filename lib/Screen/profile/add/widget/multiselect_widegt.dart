// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:kodion_projects/Screen/profile/add/controller/add_user_provider.dart';

class MultiSelectWidget extends StatelessWidget {
  RxList<String> items;
  MultiSelectWidget({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final skillController = Get.put(AddUserController());
    return Obx(() => AlertDialog(
          title: const Text("Select Skills"),
          content: SingleChildScrollView(
            child: ListBody(
              children: items.value
                  .map((item) => CheckboxListTile(
                        value:
                            skillController.selectedItemAddUser.contains(item),
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
