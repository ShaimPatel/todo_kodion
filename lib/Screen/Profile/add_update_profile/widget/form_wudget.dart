import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kodion_projects/Screen/Profile/add_update_profile/controller/add_update_profile_provider.dart';
import 'package:kodion_projects/Screen/Profile/add_update_profile/widget/gender_dropdown_widget.dart';
import 'package:kodion_projects/Screen/Profile/add_update_profile/widget/skills_widget.dart';

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
            // Name Section
            nameEditFormField(context),
            const SizedBox(height: 10),
            // Email Section
            emailEditFormField(context),
            const SizedBox(height: 10),
            // Number Section
            numberEditFormField(context),
            const SizedBox(height: 10),
            // Gender Section
            const GenderDropDownWidget(),
            // Skills Section
            const SizedBox(height: 10),
            UserSkillsWidget(),
          ],
        ),
      ),
    );
  }

  //! Name TextEditFormField

  Widget nameEditFormField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: const TextSpan(
          children: [
            TextSpan(
                text: "Name",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
            TextSpan(text: " *", style: TextStyle(color: Colors.red)),
          ],
        )),
        const SizedBox(height: 5),
        TextFormField(
          decoration: const InputDecoration(
              fillColor: Color.fromARGB(255, 211, 162, 203),
              enabled: true,
              filled: true,
              counter: SizedBox(),
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
          maxLength: 25,
          minLines: 1,
          maxLines: 2,
          style: const TextStyle(
            color: Colors.black,
          ),
          validator: (text) {
            var reg = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
            if (text!.isEmpty) {
              return "Enter your name";
            } else if (reg.hasMatch(text)) {
              return "Enter a valid name";
            }
            return null;
          },
        ),
      ],
    );
  }

  //! Email TextEditFormField

  Widget emailEditFormField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: const TextSpan(
          children: [
            TextSpan(
                text: "Email",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
            TextSpan(text: " *", style: TextStyle(color: Colors.red)),
          ],
        )),
        const SizedBox(height: 5),
        TextFormField(
            decoration: const InputDecoration(
                fillColor: Color.fromARGB(255, 211, 162, 203),
                enabled: true,
                filled: true,
                counter: SizedBox(),
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
            maxLength: 60,
            style: const TextStyle(
              color: Colors.black,
            ),
            validator: (text) {
              const pattern =
                  r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&\s'"
                  r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                  r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                  r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                  r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                  r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                  r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])\s+)\])';
              final regex = RegExp(pattern);
              if (text!.isEmpty) {
                return "Enter your email";
              } else if (!regex.hasMatch(text)) {
                return "Enter a valid email address";
              }
              return null;
            }),
      ],
    );
  }

//! Number TextEditFormField

  Widget numberEditFormField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: const TextSpan(
          children: [
            TextSpan(
                text: "Number",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
            TextSpan(text: " *", style: TextStyle(color: Colors.red)),
          ],
        )),
        const SizedBox(height: 5),
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
          textInputAction: TextInputAction.next,
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
            } else if (value.length < 10) {
              return "Please enter a valid number";
            }
            return null;
          },
        ),
      ],
    );
  }
//! Gender DropDown
}
