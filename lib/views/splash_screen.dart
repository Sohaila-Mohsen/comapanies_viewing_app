import 'dart:async';
import 'package:authentication_app/bloc/auth_cubit/auth_cubit.dart';
import 'package:authentication_app/bloc/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:authentication_app/bloc/industry_cubit/industry_cubit.dart';
import 'package:authentication_app/models/company.dart';
import 'package:authentication_app/views/edit_profile/edit_profile.dart';
import 'package:authentication_app/views/map_screen.dart';
import 'package:authentication_app/views/sign%20in/sign_in.dart';
import 'package:flutter/material.dart';

import '../utils/sp_helper/cache_helper.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    IndustryCubit industryCubit = IndustryCubit.get(context);
    industryCubit.getIndustries();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/logo.png"),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "IT'S ME",
            style: TextStyle(
                color: Color.fromARGB(145, 255, 193, 7), fontSize: 30),
          )
        ],
      ),
    );
  }

  startTime() async {
    var duration = const Duration(seconds: 10);
    return Timer(duration, await route);
  }

  route() async {
    var screen;
    if (SharedPreferencesHelper.getData(key: "isFirst") != null) {
      if (SharedPreferencesHelper.getData(key: "email") != null) {
        Company? company = Company(
            email: SharedPreferencesHelper.getData(key: "email"),
            password: SharedPreferencesHelper.getData(key: "email"));
        AuthCubit authCubit = AuthCubit.get(context);
        await authCubit.signIn(company);
        company = authCubit.company;
        screen = (company != null) ? EditProfile(company) : SignInScreen();
      }
      screen = SignInScreen();
    } else
      screen = OnBoardingScreen();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return screen;
    }), (route) => true);
  }
}
