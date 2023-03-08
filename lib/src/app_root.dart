import 'package:authentication_app/bloc/auth_cubit/auth_cubit.dart';
import 'package:authentication_app/bloc/onboarding_cubit/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../views/splash_screen.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnboardingCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(double.infinity, 20),
                  backgroundColor: Color.fromARGB(114, 255, 193, 7))),
          brightness: Brightness.dark,
          primaryColor: Color.fromARGB(128, 255, 193, 7),
          fontFamily: 'Georgia',
        ),
        home: SplashScreen(),
      ),
    );
  }
}
