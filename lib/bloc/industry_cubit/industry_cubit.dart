import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/checkbox_model.dart';
import '../../models/company.dart';
import '../../services/dio_helper.dart';

part 'industry_state.dart';

class IndustryCubit extends Cubit<IndustryState> {
  IndustryCubit() : super(IndustryInitial());
  static IndustryCubit get(context) => BlocProvider.of(context);
  IndustriesResponse? industriesResponse;
  CheckBoxModel industries = CheckBoxModel([]);
  Future<void> getIndustries() async {
    emit(GetingIndustriesLoadingState());
    await DioHelper.getData(
      url: "http://10.0.2.2:8080/mobiletask/industry/getIndustries.php",
    ).then((value) {
      Map<String, dynamic> val = json.decode(value.data);
      industriesResponse = IndustriesResponse.fromJson(val);
      if (industriesResponse!.data != null) {
        industries.choices = industriesResponse!.data!;
        emit(GetingIndustriesSuccessfullyState());
      }
    }).onError((error, stackTrace) {
      debugPrint("error: $error,stackTrace : $stackTrace ");
      emit(GetingIndustriesFailedState());
    });
  }
}
