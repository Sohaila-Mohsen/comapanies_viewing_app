import 'package:authentication_app/core/style/app_text_style/app_textstyle.dart';
import 'package:authentication_app/models/company.dart';
import 'package:flutter/material.dart';

import '../../core/components/custom_text_field.dart';
import 'edit_profile_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  final Company company;
  final EditProfileController editProfileController = EditProfileController();
  ChangePasswordScreen(this.company, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Form(
            key: editProfileController.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Center(
                  child: Text("Change Password",
                      style: AppTextStyle.linkTextStyle(25, true)),
                ),
                const SizedBox(height: 20),
                const Divider(thickness: 2),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: editProfileController.password,
                  label: "Old Password",
                  validator: (value) =>
                      editProfileController.passwordValidator(value),
                ),
                CustomTextField(
                  controller: editProfileController.newPasssword,
                  label: "New Password",
                  validator: (value) =>
                      editProfileController.newPasswordValidator(value),
                ),
                CustomTextField(
                  controller: editProfileController.confirmNewPasssword,
                  label: "Confirm new Password",
                  validator: (value) =>
                      editProfileController.confirmNewPassswordValidator(value),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (editProfileController.formKey.currentState!
                          .validate()) {
                        if (editProfileController.password.text ==
                            company.password) {
                          const snackBar = SnackBar(
                              content: Text("Password changed successfully !"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pop(context);
                        } else {
                          const snackBar =
                              SnackBar(content: Text("Old password is wrong"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    child: const Text("Change"),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
