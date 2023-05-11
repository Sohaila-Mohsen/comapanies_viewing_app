import 'dart:convert';
import 'dart:io';
import 'package:authentication_app/services/dio_helper.dart';
import 'package:authentication_app/utils/sp_helper/cache_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../models/checkbox_model.dart';
import '../../models/company.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  CompanyResponse? companyResponse;
  Company? company;
  IndustriesResponse? industriesResponse;
  CheckBoxModel industries = CheckBoxModel([]);

  Future<void> register(Company user) async {
    emit(RegisterLoadingState());
    await DioHelper.postData(
            url: "http://10.0.2.2:8080/mobiletask/auth/signup.php",
            data: user.toJson())
        .then((value) {
      Map<String, dynamic> val = json.decode(value.data);
      companyResponse = CompanyResponse.fromJson(val);
      if (companyResponse!.data!.contactName != null) {
        company = companyResponse!.data;
        SharedPreferencesHelper.saveData(
            key: "email", value: companyResponse!.data!.email);
        SharedPreferencesHelper.saveData(
            key: "password", value: companyResponse!.data!.password);
        emit(RegisterSuccessState());
      } else {
        emit(RegisterErrorState());
      }
    }).catchError((error) {
      debugPrint("erroe $error");
      emit(RegisterErrorState());
    });
  }

//clams@gmail.com
//12345645
  Future<void> signIn(Company company) async {
    print(company.toJson());
    emit(LoginLoadingState());
    await DioHelper.postData(
            url: "http://10.0.2.2:8080/mobiletask/auth/login.php",
            data: company.toJson())
        .then((value) {
      Map<String, dynamic> val = json.decode(value.data);
      companyResponse = CompanyResponse.fromJson(val);
      if (companyResponse!.data!.contactName != null) {
        this.company = companyResponse!.data;
        emit(LogedinSuccessfullyState());
      }
    }).onError((error, stackTrace) {
      debugPrint("error:: ${error.toString()}");
      emit(LogedinFailedState());
    });
  }

  Future<void> getIndustries() async {
    emit(GetingIndustriesLoadState());
    await DioHelper.getData(
      url: "http://10.0.2.2:8080/mobiletask/industry/getIndustries.php",
    ).then((value) {
      Map<String, dynamic> val = json.decode(value.data);
      industriesResponse = IndustriesResponse.fromJson(val);
      if (industriesResponse!.data != null) {
        industries.choices = industriesResponse!.data!;
        emit(GetingIndustriesSuccessState());
      }
    }).onError((error, stackTrace) {
      debugPrint("errorrr: $error,stackTrace : $stackTrace ");
      emit(GetingIndustriesFailState());
    });
  }
}
