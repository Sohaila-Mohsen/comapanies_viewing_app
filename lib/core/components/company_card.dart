import 'dart:io';

import 'package:authentication_app/views/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../bloc/services_cubit/services_cubit.dart';
import '../../models/company.dart';
import '../../models/company_service_response.dart';
import '../../views/company_profile_screen.dart';
import '../style/app_colors/app_colors.dart';
import '../style/app_text_style/app_textstyle.dart';

class CompanyCard extends StatelessWidget {
  CompanyCard(this.displayedCompany, this.company, {Key? key})
      : super(key: key);
  Data displayedCompany;
  Company company;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Position? cuttentPosition =
            await RegisterController.getCurrentLocation(context);
        String? distance = "0.0";
        if (cuttentPosition != null) {
          distance = await ServicesCubit.getDistance(
              displayedCompany, cuttentPosition);
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CompanyProfileScreen(displayedCompany, company, distance)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CircleAvatar(
              radius: 35,
              backgroundColor: AppColors.primaryColor,
              child: //(displayedCompany.image != null)
                  // ? CircleAvatar(
                  //     radius: 33,
                  //     backgroundImage:
                  //         (displayedCompany.image!.contains('assets'))
                  //             ? AssetImage(displayedCompany.image!)
                  //             : FileImage(File(displayedCompany.image!))
                  //                 as ImageProvider,
                  //   ):
                  const Icon(Icons.apartment, size: 60, color: Colors.white)),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(displayedCompany.name!,
                  style: AppTextStyle.labelTextStyle(20)),
              const SizedBox(height: 10),
              Text(displayedCompany.contactPhone!,
                  style: AppTextStyle.labelTextStyle(12)),
            ],
          ),
          const Expanded(child: SizedBox()),
        ]),
      ),
    );
  }
}
