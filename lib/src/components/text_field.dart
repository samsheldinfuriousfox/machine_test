import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TextFieldType1 extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? hintText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  final Widget? suffixIcon, prefixIcon;
  const TextFieldType1(
    this.textEditingController, {
    Key? key,
    this.hintText,
    this.obscureText,
    this.suffixIcon,
    this.inputFormatters,
    this.validator,
    this.prefixIcon,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: validator,
      textAlignVertical: TextAlignVertical.center,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      //  cursorColor: Colors.white,
      obscuringCharacter: "•",
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        fillColor: Colors.white,
        filled: true,
        prefixIcon: prefixIcon,
        hintStyle: Get.textTheme.subtitle1?.copyWith(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(vertical: 13),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
      ),
    );
  }
}
