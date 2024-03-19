import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelName;
  String? initialValue;
  final TextEditingController textEditingController;
  final TextInputType inputType;
  final Icon prefixIcon;
  final TextInputAction textInputAction;
  var customValidate;
  CustomTextField(
      {super.key,
      required this.labelName,
      required this.textEditingController,
      required this.inputType,
      required this.prefixIcon,
      required this.textInputAction,
      required this.customValidate,
      this.initialValue});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelName,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          style: const TextStyle(fontSize: 14),
          textInputAction: widget.textInputAction,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.textEditingController,
          keyboardType: widget.inputType,
          initialValue: widget.initialValue,
          validator: widget.customValidate,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            filled: true,
            fillColor: const Color(0xFFB394C9),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
