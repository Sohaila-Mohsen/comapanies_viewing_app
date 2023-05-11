import 'dart:io';
import 'package:authentication_app/bloc/auth_cubit/auth_cubit.dart';
import 'package:authentication_app/views/edit_profile/edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../bloc/checkbox_cubit/check_box_cubit.dart';
import '../../bloc/edit_profile_cubit/edit_profile_cubit.dart';
import '../../core/components/Popup_menue.dart';
import '../../core/components/custom_check_box.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/style/app_colors/app_colors.dart';
import '../../core/style/app_text_style/app_textstyle.dart';
import '../../models/checkbox_model.dart';
import '../../models/company.dart';
import 'change_password_screen.dart';
import '../register/register_controller.dart';

//sohaila
//so
//01121108555
//so@gmail.com
//Mm@ssshbzn521
class EditProfile extends StatelessWidget {
  RegisterController registerController = RegisterController();
  Company company;
  PickedFile? _imageFile;
  EditProfile(this.company, {Key? key}) : super(key: key) {
    debugPrint("recieved data :: ${company.toJson()}");
    registerController.companyName.text = (company.name) ?? "";
    registerController.companyAddress.text = (company.address) ?? "";
    registerController.email.text = (company.email) ?? "";
    registerController.name.text = (company.contactName) ?? "";
    registerController.phone.text = (company.contactPhone) ?? "";
  }

  @override
  Widget build(BuildContext context) {
    double constraintsHight = MediaQuery.of(context).size.height;
    EditProfileCubit editProfileCubit = EditProfileCubit.get(context);
    editProfileCubit.getIndustries();
    return Scaffold(
      appBar: AppBar(
          actions: [
            PopupMenue(icon: Icon(Icons.menu, color: Colors.white), menueList: [
              PopupMenuItem(
                  child: Text("Change Password"),
                  onTap: () => Future(
                        () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => ChangePasswordScreen(company)),
                        ),
                      )),
              PopupMenuItem(
                  child: Text("Logout"),
                  onTap: () => Future(
                        () => EditProfileController.logout(company, context),
                      )),
            ])
          ],
          title: SizedBox(
              height: 100, child: Image.asset("assets/images/logo.png")),
          centerTitle: true),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Form(
            key: registerController.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      BlocConsumer<EditProfileCubit, EditProfileState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return CircleAvatar(
                              radius: 60,
                              backgroundColor: AppColors.primaryColor,
                              child: (editProfileCubit.imageFile != null)
                                  ? CircleAvatar(
                                      radius: 58,
                                      backgroundImage: FileImage(File(
                                          editProfileCubit.imageFile.path)),
                                    )
                                  : const Icon(Icons.apartment,
                                      size: 70, color: Colors.white));
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: PopupMenue(
                          icon: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.add,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          menueList: [
                            PopupMenuItem(
                              child: Text("From camera"),
                              onTap: () async {
                                final image =
                                    await EditProfileController.pickImage(
                                        ImageSource.camera);
                                if (image != null)
                                  editProfileCubit.uploadImage(image, company);
                              },
                            ),
                            PopupMenuItem(
                              child: Text("From gallery"),
                              onTap: () async {
                                final image =
                                    await EditProfileController.pickImage(
                                        ImageSource.gallery);
                                if (image != null)
                                  editProfileCubit.uploadImage(image, company);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(thickness: 2),
                const SizedBox(height: 10),
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
                    Text("Update Location"),
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
                BlocConsumer<EditProfileCubit, EditProfileState>(
                    listener: (context, state) {},
                    builder: (context, snapshot) {
                      return BlocConsumer<CheckBoxCubit, CheckBoxState>(
                          builder: (context, state) {
                            return (editProfileCubit.state
                                    is GetingIndustriesSuccessfullyState)
                                ? CustomCheckBox(
                                    CheckBoxModel(
                                        editProfileCubit.industries.choices),
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
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (registerController.formKey.currentState!.validate()) {
                        List<String> industries = [];
                        editProfileCubit.industries.selected.forEach((element) {
                          industries.add(
                              editProfileCubit.industries.choices[element]);
                        });
                        company = Company(
                            companyId: company.companyId,
                            image: company.image,
                            locationId: company.locationId,
                            size: (comapnySizes.selected.length > 0)
                                ? comapnySizes.choices[comapnySizes.selected[0]]
                                : null,
                            email: registerController.email.text,
                            name: registerController.companyName.text,
                            address: registerController.companyAddress.text,
                            contactPhone: registerController.phone.text,
                            contactName: registerController.name.text,
                            industries: industries,
                            lat: registerController.lat,
                            lon: registerController.lon,
                            password: company.password);
                        await editProfileCubit.updateCompany(company);
                        if (editProfileCubit.state
                            is UpdatedSuccessfullyState) {
                          company = editProfileCubit.company!;
                          const snackBar = SnackBar(
                              content: Text("Account Updated successfully !"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          const snackBar = SnackBar(
                              content:
                                  Text("Something went wrong try again !"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                      editProfileCubit.getIndustries();
                      debugPrint("email : ${registerController.email.text}");
                    },
                    child: const Text("Save"),
                  ),
                ),
                SizedBox(height: constraintsHight / 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
