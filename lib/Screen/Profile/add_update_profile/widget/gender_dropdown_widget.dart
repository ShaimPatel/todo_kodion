import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodion_projects/Screen/Profile/add_update_profile/controller/add_update_profile_provider.dart';

class GenderDropDownWidget extends StatefulWidget {
  const GenderDropDownWidget({super.key});

  @override
  State<GenderDropDownWidget> createState() => _GenderDropDownWidgetState();
}

class _GenderDropDownWidgetState extends State<GenderDropDownWidget> {
  final controller = Get.put(AddUpdateUserProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: const TextSpan(
              children: [
                TextSpan(
                    text: "Gender",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                TextSpan(text: " *", style: TextStyle(color: Colors.red)),
              ],
            )),
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      isDense: true,
                      validator: (value) {
                        if (value == null) {
                          return "Select your gender";
                        } else {
                          return null;
                        }
                      },
                      value: controller.dropdownvalue!.isEmpty
                          ? null
                          : controller.dropdownvalue!.value.toString(),
                      items: [
                        ...controller.genderList.map((element) {
                          return DropdownMenuItem(
                              enabled: true,
                              value: element,
                              child: Text(element.toString()));
                        }),
                      ],
                      onChanged: (newValue) {
                        controller.dropdownvalue!.value = newValue.toString();
                      }),
                ),
              ],
            ),
          ],
        ));
  }
}
