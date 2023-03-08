import 'package:authentication_app/bloc/auth_cubit/auth_cubit.dart';
import 'package:authentication_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../core/components/custom_text_field.dart';
import '../core/style/app_text_style/app_textstyle.dart';

class RegisterScreen extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _Name = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double constraintsHight = MediaQuery.of(context).size.height;
    AuthCubit authCubit = AuthCubit.get(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
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
                  "Create Account",
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
                  controller: _Name,
                  label: "Name",
                  validator: (value) {
                    if (value!.length < 1 || value == null) {
                      return 'Name is required';
                    }
                  },
                ),
                CustomTextField(
                  label: "Email",
                  controller: _email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!value.contains('@') || !value.contains('.')) {
                      return 'Please enter valid email ex : "example@mail.com"';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  label: "Phone",
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone is required';
                    } else if (value.length != 11) {
                      return 'Please enter valid phone ex : "01*********"';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: _password,
                  label: "Password",
                  validator: (value) {
                    RegExp regex = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])');
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (!regex.hasMatch(value)) {
                      return 'Password should be: \nat least 8 characters\n at least 1 uppercase letter\n at least 1 lowercase letter \n at least 1 special letter \n at least 1 number';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  label: "Confirm Password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    } else if (value != _password.text) {
                      return 'Doesn\'t match password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is RegisterSuccessState ||
                        state is RegisterErrorState) {
                          Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
                      Fluttertoast.showToast(
                          msg: authCubit.userResponse!.message!,
                          gravity: ToastGravity.BOTTOM);
                    }
                  },
                  child: Container(),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() ||
                        !_formKey.currentState!.validate()) {
                      //TODO::show toster and navigate
                      print("valiiiiiid");
                      /* User user = User(
                          email: _email.text,
                          phone: _phone.text,
                          name: _Name.text,
                          password: _password.text); */

                      User user = User(
                          email: "sohaila@email.com",
                          phone: "01122152211",
                          name: "sohaila",
                          password: "Mm#123456");

                      print("valiiiiiid222");
                      authCubit.register(user);
                      print("valiiiiiid3333");
                      /*  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      ); */
                    }
                    print("email : ${_email.text}");
                  },
                  child: const Text("Register"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: AppTextStyle.grayTextStyle(12),
                    ),
                    TextButton(
                      child: Text("Login",
                          style: AppTextStyle.linkTextStyle(13, true)),
                      onPressed: () {
                        /*  Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen()),
                                      ); */
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
