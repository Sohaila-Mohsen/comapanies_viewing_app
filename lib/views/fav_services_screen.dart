import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/services_cubit/services_cubit.dart';
import '../core/components/Popup_menue.dart';
import '../core/components/service_card.dart';
import '../models/company.dart';
import 'edit_profile/edit_profile.dart';
import 'edit_profile/edit_profile_controller.dart';

class FavServicesScreen extends StatelessWidget {
  FavServicesScreen(this.company,{Key? key}) : super(key: key){}
  Company company;

  @override
  Widget build(BuildContext context) {
    ServicesCubit servicesCubit = ServicesCubit.get(context);
    return Scaffold(
      appBar:AppBar(
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
                      child: const Text("Home Page"),
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
      body: BlocConsumer<ServicesCubit, ServicesState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
              child: (servicesCubit.state is GetServicesLoadingState)
                  ? const CircularProgressIndicator()
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      height: MediaQuery.of(context).size.height - 100,
                      child: ListView.builder(
                          itemCount: servicesCubit.fav.length,
                          itemBuilder: (context, index) => ServiceCard(
                              servicesCubit.fav[index], company))));
        },
      ),
    );
  }
}