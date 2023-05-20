import 'package:authentication_app/core/components/service_card.dart';
import 'package:authentication_app/models/company.dart';
import 'package:authentication_app/views/edit_profile/edit_profile.dart';
import 'package:authentication_app/views/fav_services_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/services_cubit/services_cubit.dart';
import '../core/components/Popup_menue.dart';
import 'edit_profile/edit_profile_controller.dart';

class ServicesScreen extends StatelessWidget {
  ServicesScreen(this.company, {Key? key}) : super(key: key);
  Company company;
  late ServicesCubit servicesCubit;

  @override
  Widget build(BuildContext context) {
    servicesCubit = ServicesCubit.get(context);
    servicesCubit.getFav(company.companyId!);
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
                      onTap: () => Future(
                            () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => FavServicesScreen(company)),
                            ),
                          )),
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
                          itemCount: servicesCubit.services!.length,
                          itemBuilder: (context, index) => ServiceCard(
                              servicesCubit.services![index], company))));
        },
      ),
    );
  }
}
