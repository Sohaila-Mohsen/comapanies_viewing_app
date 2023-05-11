import 'package:authentication_app/bloc/auth_cubit/auth_cubit.dart';
import 'package:authentication_app/bloc/checkbox_cubit/check_box_cubit.dart';
import 'package:authentication_app/core/components/custom_check_box.dart';
import 'package:authentication_app/core/style/app_colors/app_colors.dart';
import 'package:authentication_app/models/company.dart';
import 'package:authentication_app/views/edit_profile/edit_profile.dart';
import 'package:authentication_app/views/sign%20in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/style/app_text_style/app_textstyle.dart';
import '../../models/checkbox_model.dart';
import 'register_controller.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController registerController = RegisterController();

  RegisterScreen({Key? key}) : super(key: key);

  // Future<Position?> _getCurrentLocation() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error("Location services is disabeled");
  //   }
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied)
  //     permission = await Geolocator.requestPermission();
  //   if (permission == LocationPermission.denied)
  //     return Future.error("Permission denied");
  // }

  @override
  Widget build(BuildContext context) {
    double constraintsHight = MediaQuery.of(context).size.height;
    AuthCubit authCubit = AuthCubit.get(context);
    authCubit.getIndustries();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: registerController.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: constraintsHight / 15,
                ),
                SizedBox(
                    height: 150, child: Image.asset("assets/images/logo.png")),
                SizedBox(
                  height: constraintsHight / 60,
                ),
                Text(
                  "Create Account",
                  style: AppTextStyle.linkTextStyle(20, true),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(thickness: 2),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: registerController.companyName,
                  label: "Company Name",
                  validator: (value) =>
                      registerController.companyNameValidator(value),
                ),
                CustomTextField(
                  controller: registerController.companyAddress,
                  label: "Company Address",
                  validator: (value) =>
                      registerController.companyAddressValidator(value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Location"),
                    IconButton(
                        onPressed: () async {
                          await registerController.getCurrentPosition(context);
                        },
                        icon: Icon(
                          Icons.location_on,
                          color: AppColors.primaryColor,
                        ))
                  ],
                ),
                CustomTextField(
                  label: "Email",
                  controller: registerController.email,
                  validator: (value) =>
                      registerController.emailValidator(value),
                ),
                CustomTextField(
                  controller: registerController.name,
                  label: "Contact Person Name",
                  validator: (value) =>
                      registerController.contactPersonNameValidator(value),
                ),
                CustomTextField(
                  label: "Contact Person Phone Number",
                  controller: registerController.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      registerController.contactPersonNumberValidator(value),
                ),
                Text(
                  "Company Industry",
                  style: AppTextStyle.labelTextStyle(11),
                ),
                BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {},
                    builder: (context, snapshot) {
                      return BlocConsumer<CheckBoxCubit, CheckBoxState>(
                          builder: (context, state) {
                            return (authCubit.state
                                    is GetingIndustriesSuccessState)
                                ? CustomCheckBox(
                                    authCubit.industries,
                                    isMulti: true,
                                  )
                                : Container();
                          },
                          listener: (context, state) {});
                    }),
                Text(
                  "Company Size",
                  style: AppTextStyle.labelTextStyle(11),
                ),
                BlocConsumer<CheckBoxCubit, CheckBoxState>(
                    builder: (context, state) => CustomCheckBox(comapnySizes),
                    listener: (context, state) {}),
                CustomTextField(
                  controller: registerController.password,
                  label: "Password",
                  validator: (value) =>
                      registerController.passwordValidator(value),
                ),
                CustomTextField(
                  label: "Confirm Password",
                  validator: (value) =>
                      registerController.confirmPasswordValidator(value),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {},
                    builder: (context, snapshot) {
                      return ElevatedButton(
                        onPressed: () async {
                          if (registerController.formKey.currentState!
                              .validate()) {
                            List<String> industries = [];
                            authCubit.industries.selected.forEach((element) {
                              industries
                                  .add(authCubit.industries.choices[element]);
                            });
                            Company company = Company(
                                email: registerController.email.text,
                                size: (comapnySizes.selected.length > 0)
                                    ? comapnySizes
                                        .choices[comapnySizes.selected[0]]
                                    : null,
                                name: registerController.companyName.text,
                                address: registerController.companyAddress.text,
                                contactPhone: registerController.phone.text,
                                contactName: registerController.name.text,
                                industries: industries,
                                lat: registerController.lat,
                                lon: registerController.lon,
                                password: registerController.password.text);

                            await authCubit.register(company);
                            if (authCubit.state is RegisterSuccessState) {
                              debugPrint("register sucess from screen");
                              company = authCubit.company!;
                              const snackBar = SnackBar(
                                  content:
                                      Text("Account created successfully !"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile(company)),
                              );
                            } else {
                              const snackBar = SnackBar(
                                  content:
                                      Text("Something went wrong try again !"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                            authCubit.getIndustries();
                            //_getCurrentLocation();
                          }
                        },
                        child: (authCubit.state is RegisterLoadingState)
                            ? const CircularProgressIndicator()
                            : const Text("Register"),
                      );
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: AppTextStyle.grayTextStyle(12),
                    ),
                    TextButton(
                      child: Text("Login",
                          style: AppTextStyle.linkTextStyle(13, true)),
                      onPressed: () {
                        //_getCurrentLocation();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: constraintsHight / 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
