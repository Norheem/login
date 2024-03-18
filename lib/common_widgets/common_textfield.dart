import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String hint;
  final String label;
  final bool visibility;
  final Widget? suffix;
  final Widget? prefix;
  final TextEditingController controller;
  final Key? formKey;
  final String? Function(String?)? validator;
  const CommonTextField({
    super.key,
    this.formKey,
    required this.hint,
    this.visibility = false,
    required this.controller,
    this.suffix,
    this.prefix,
    required this.label,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: visibility,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        suffixIcon: suffix,
        prefixIcon: prefix,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  // static String? usernameValidator(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter a username';
  //   } else if (value.length < 4) {
  //     return 'Username must be at least 4 characters';
  //   }
  //   return null;
  // }

  // static String? fullnameValidator(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter your full name';
  //   } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
  //     return 'Invalid characters in your full name';
  //   }
  //   return null;
  // }

  // static String? emailValidator(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter your email address';
  //   } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
  //       .hasMatch(value)) {
  //     return 'Invalid email address';

  //     // } else if (!value.contains('@')) {
  //     //   return 'Invalid email address, please enter a valid email address';
  //   }
  //   return null;
  // }

  // static String? passwordValidator(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter a password';
  //   } else if (value.length < 6) {
  //     return 'Password must be at least 6 characters';
  //   }
  //   return null;
  // }

  // static String? confirmPasswordValidator(String? value, String password) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please confirm your password';
  //   } else if (value != password) {
  //     return 'Passwords do not match';
  //   }
  //   return null;
  // }
}
