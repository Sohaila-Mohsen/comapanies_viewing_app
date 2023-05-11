import 'package:flutter/material.dart';

class SignInController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!value.contains('@') || !value.contains('.')) {
      return 'Please enter valid email ex : "example@mail.com"';
    }
    return null;
  }

  passwordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Wrong password';
    }
    return null;
  }
}
