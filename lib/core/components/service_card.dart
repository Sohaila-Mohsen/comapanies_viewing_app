import 'package:authentication_app/bloc/services_cubit/services_cubit.dart';
import 'package:authentication_app/core/style/app_text_style/app_textstyle.dart';
import 'package:authentication_app/models/company.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/service.dart';
import '../../views/companies_screen.dart';

class ServiceCard extends StatelessWidget {
  ServiceCard(this.service, this.company, {Key? key}) : super(key: key);
  Service service;
  Company company;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await ServicesCubit.get(context).getCompanies(service);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CompaniesScreen(company)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(service.name!, style: AppTextStyle.labelTextStyle(18)),
          BlocConsumer<ServicesCubit, ServicesState>(
            listener: (context, state) {},
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    ServicesCubit.get(context)
                        .addFavorite(company.companyId!, service.serviceId!);
                  },
                  icon: Icon(
                    (ServicesCubit.get(context).isFav(service.serviceId!))
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.amberAccent[400],
                  ));
            },
          )
        ]),
      ),
    );
  }
}
