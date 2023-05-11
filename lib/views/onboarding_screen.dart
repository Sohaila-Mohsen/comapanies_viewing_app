import 'package:authentication_app/bloc/onboarding_cubit/onboarding_cubit.dart';
import 'package:authentication_app/utils/sp_helper/cache_helper.dart';
import 'package:authentication_app/views/sign%20in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/onboarding_content.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    OnboardingCubit pageCubit = OnboardingCubit.get(context);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: PageView.builder(
              onPageChanged: (index) {
                pageCubit.changeIndex(index);
              },
              itemCount: content.length,
              itemBuilder: (context, index) => Center(
                child: Column(
                  children: [
                    Image.asset(content[index].imagePath),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      content[index].title,
                      style: const TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(128, 255, 193, 7)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      content[index].description,
                      style: const TextStyle(wordSpacing: 6),
                    )
                  ],
                ),
              ),
            ),
          ),
          BlocConsumer<OnboardingCubit, OnboardingState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    content.length,
                    (index) => Container(
                          margin: const EdgeInsets.all(3),
                          height: 10,
                          width: pageCubit.pageIndex == index ? 20 : 10,
                          decoration: BoxDecoration(
                              color: pageCubit.pageIndex == index
                                  ? Theme.of(context).primaryColor
                                  : const Color.fromARGB(83, 210, 210, 210),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                        )),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              SharedPreferencesHelper.saveData(key: "isFirst", value: true);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
            child: const Text("     Start      "),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
