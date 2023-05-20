import 'package:authentication_app/bloc/services_cubit/services_cubit.dart';
import 'package:authentication_app/core/components/service_card.dart';
import 'package:authentication_app/core/style/app_text_style/app_textstyle.dart';
import 'package:flutter/material.dart';
import '../core/components/Popup_menue.dart';
import '../core/style/app_colors/app_colors.dart';
import '../models/company.dart';
import '../models/company_service_response.dart';
import 'edit_profile/change_password_screen.dart';
import 'edit_profile/edit_profile_controller.dart';

class CompanyProfileScreen extends StatelessWidget {
  CompanyProfileScreen(this.displayedCompany, this.company, this.distance,
      {Key? key})
      : super(key: key);
  Data displayedCompany;
  Company company;
  String? distance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            PopupMenue(icon: const Icon(Icons.menu, color: Colors.white), menueList: [
              PopupMenuItem(
                  child: const Text("Change Password"),
                  onTap: () => Future(
                        () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => ChangePasswordScreen(company)),
                        ),
                      )),
              PopupMenuItem(
                  child: const Text("Logout"),
                  onTap: () => Future(
                        () => EditProfileController.logout(company, context),
                      )),
            ])
          ],
          title: SizedBox(
              height: 100, child: Image.asset("assets/images/logo.png")),
          centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.primaryColor,
                  child: 
                        const Icon(Icons.apartment,
                          size: 70, color: Colors.white)),
            ),
            const SizedBox(height: 20),
            Center(
                child: Text(
              displayedCompany.name!,
              style: AppTextStyle.grayTextStyle(20),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 10),
                Text((distance) ?? "0.0")
              ],
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            Text("Address", style: AppTextStyle.linkTextStyle(18, true)),
            const SizedBox(height: 10),
            Text("   ${company.address!}"),
            const SizedBox(height: 10),
            Text("Phone", style: AppTextStyle.linkTextStyle(18, true)),
            const SizedBox(height: 10),
            Text("   ${company.contactPhone!}"),
            const SizedBox(height: 10),
            Text("Email", style: AppTextStyle.linkTextStyle(18, true)),
            const SizedBox(height: 10),
            Text("   ${company.email!}"),
            const SizedBox(height: 10),
            Text("Services", style: AppTextStyle.linkTextStyle(18, true)),
            const SizedBox(height: 10),
            Expanded(
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) => ServiceCard(
                        ServicesCubit.get(context).services![index], company)))
          ],
        ),
      ),
    );
  }
}
