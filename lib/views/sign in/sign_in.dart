import 'package:authentication_app/views/register/register_screen.dart';
import 'package:authentication_app/views/sign%20in/signIn_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auth_cubit/auth_cubit.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/style/app_text_style/app_textstyle.dart';
import '../../models/company.dart';
import '../edit_profile/edit_profile.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final SignInController signInController = SignInController();

  @override
  Widget build(BuildContext context) {
    double constraintsHight = MediaQuery.of(context).size.height;
    AuthCubit authCubit = AuthCubit.get(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: signInController.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: constraintsHight / 15,
                ),
                SizedBox(
                    height: 150, child: Image.asset("assets/images/logo.png")),
                SizedBox(
                  height: constraintsHight / 60,
                ),
                Text(
                  "Sign In",
                  style: AppTextStyle.linkTextStyle(20, true),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(thickness: 2),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  label: "Email",
                  controller: signInController.email,
                  validator: (value) => signInController.emailValidator(value),
                ),
                CustomTextField(
                  controller: signInController.password,
                  label: "Password",
                  validator: (value) =>
                      signInController.passwordValidator(value),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is RegisterSuccessState ||
                        state is RegisterErrorState) {
                      // Fluttertoast.showToast(
                      //     msg: authCubit.userResponse!.message!,
                      //     gravity: ToastGravity.BOTTOM);
                      debugPrint("SUCCESS");
                    }
                  },
                  child: Container(),
                ),
                BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {},
                    builder: (context, snapshot) {
                      return ElevatedButton(
                        onPressed: () async {
                          if (signInController.formKey.currentState!
                              .validate()) {
                            Company? company = Company(
                                email: signInController.email.text,
                                password: signInController.password.text);

                            await authCubit.signIn(company);
                            company = authCubit.company;
                            print(authCubit.state);
                            if (authCubit.state is LogedinSuccessfullyState) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditProfile(company!)),
                              );
                            }
                            //_getCurrentLocation();
                          }
                        },
                        child: (authCubit.state is LoginLoadingState)
                            ? CircularProgressIndicator()
                            : const Text("Sign in"),
                      );
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: AppTextStyle.grayTextStyle(12),
                    ),
                    TextButton(
                      child: Text("Sign up",
                          style: AppTextStyle.linkTextStyle(13, true)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: constraintsHight / 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
