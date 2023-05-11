import 'dart:io';

import 'package:authentication_app/bloc/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:authentication_app/models/company.dart';
import 'package:authentication_app/utils/sp_helper/cache_helper.dart';
import 'package:authentication_app/views/sign%20in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController password = TextEditingController();
  final TextEditingController newPasssword = TextEditingController();
  final TextEditingController confirmNewPasssword = TextEditingController();
  EditProfileCubit? editProfileCubit;

  passwordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  newPasswordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password should be at least 8 characters';
    }
    return null;
  }

  confirmNewPassswordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value != newPasssword.text) {
      return 'Doesn\'t match password';
    }
    return null;
  }

  static Future<File?> pickImage(source) async {
    try {
      var image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return null;
      }
      final imageTemp = File(image.path);
      return imageTemp;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      return null;
    }
  }

  static logout(Company company, context) {
    SharedPreferencesHelper.removeData(key: "email");
    SharedPreferencesHelper.removeData(key: "password");
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => SignInScreen()), (route) => false);
  }
}
