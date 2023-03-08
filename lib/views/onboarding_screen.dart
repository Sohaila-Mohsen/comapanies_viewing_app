import 'package:authentication_app/bloc/onboarding_cubit/onboarding_cubit.dart';
import 'package:authentication_app/views/register_screen.dart';
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
          SizedBox(
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
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      content[index].title,
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(128, 255, 193, 7)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      content[index].description,
                      style: TextStyle(wordSpacing: 6),
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
                          margin: EdgeInsets.all(3),
                          height: 10,
                          width: pageCubit.pageIndex == index ? 20 : 10,
                          decoration: BoxDecoration(
                              color: pageCubit.pageIndex == index
                                  ? Theme.of(context).primaryColor
                                  : Color.fromARGB(83, 210, 210, 210),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        )),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => RegisterScreen()),
              );
            },
            child: Text("     Start      "),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
