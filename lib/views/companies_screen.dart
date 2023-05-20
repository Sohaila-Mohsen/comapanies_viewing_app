import 'package:authentication_app/bloc/services_cubit/services_cubit.dart';
import 'package:authentication_app/core/components/company_card.dart';
import 'package:authentication_app/models/company.dart';
import 'package:flutter/material.dart';

import '../core/components/Popup_menue.dart';
import 'edit_profile/edit_profile.dart';
import 'edit_profile/edit_profile_controller.dart';

class CompaniesScreen extends StatelessWidget {
  CompaniesScreen(this.company, {Key? key}) : super(key: key);
  Company company;
  late ServicesCubit servicesCubit;
  @override
  Widget build(BuildContext context) {
    servicesCubit = ServicesCubit.get(context);
    return Scaffold(
      appBar: AppBar(
          actions: [
            PopupMenue(
                icon: const Icon(Icons.menu, color: Colors.white),
                menueList: [
                  PopupMenuItem(
                      child: const Text("Edit Profile"),
                      onTap: () => Future(
                            () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => EditProfile(company)),
                            ),
                          )),
                  PopupMenuItem(
                      child: const Text("Favorite business services"),
                      onTap: () {}),
                  PopupMenuItem(
                      child: const Text("Logout"),
                      onTap: () => Future(
                            () =>
                                EditProfileController.logout(company, context),
                          )),
                ])
          ],
          title: SizedBox(
              height: 100, child: Image.asset("assets/images/logo.png")),
          centerTitle: true),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          height: MediaQuery.of(context).size.height - 100,
          child: ListView.builder(
              itemCount: servicesCubit.companiesForService.length,
              itemBuilder: (context, index) => CompanyCard(
                  servicesCubit.companiesForService[index], company))),
    );
  }
}
