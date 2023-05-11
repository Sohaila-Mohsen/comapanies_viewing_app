import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

import 'package:authentication_app/models/company.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../models/checkbox_model.dart';
import '../../models/company.dart';
import '../../services/dio_helper.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());
  static EditProfileCubit get(context) => BlocProvider.of(context);
  var imageFile;
  CompanyResponse? companyResponse;
  Company? company;
  IndustriesResponse? industriesResponse;
  CheckBoxModel industries = CheckBoxModel([]);

  addImage(pickedFile) {
    imageFile = pickedFile;
    emit(ImageAddedState());
  }

  Future<void> updateCompany(Company comp) async {
    print("updat sent company: ${comp.toJson()}");
    emit(UpdateLoadingState());
    await DioHelper.postData(
            url: "http://10.0.2.2:8080/mobiletask/company/updateCompany.php",
            data: comp.toJson())
        .then((value) {
      print("********\n${value.data} it's string");
      Map<String, dynamic> val = json.decode(value.data);
      companyResponse = CompanyResponse.fromJson(val);
      print("valueMap : $val");
      if (companyResponse!.data!.companyId != null) {
        company = companyResponse!.data!;
        emit(UpdatedSuccessfullyState());
      }
    }).onError((error, stackTrace) {
      debugPrint("errorrr: $error,stackTrace : $stackTrace ");
      emit(UpdatedFailedState());
    });
  }

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
      debugPrint("errorrr: $error,stackTrace : $stackTrace ");
      emit(GetingIndustriesFailedState());
    });
  }

  Future<void> uploadImage(File file, Company company) async {
    addImage(file);
    var postUri =
        Uri.parse("http://10.0.2.2:8080/mobiletask/company/updateCompany.php");
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['companyId'] = company.companyId!;
    request.fields['locationId'] = company.locationId!;
    request.fields['name'] = company.name!;
    request.fields['email'] = company.email!;
    request.fields['password'] = company.password!;
    request.fields['contactName'] = company.contactName!;
    request.fields['contactPhone'] = company.contactPhone!;
    request.fields['address'] = company.address!;
    if (company.size != null) request.fields['size'] = company.size!;
    if (company.image != null) request.fields['image'] = company.image!;
    if (company.lat != null) request.fields['lat'] = company.lat!;
    if (company.lon != null) request.fields['lon'] = company.lon!;
    print('dara: ${request.fields}');
    request.files.add(new http.MultipartFile.fromBytes(
      'file',
      await File(file.path).readAsBytes(),
    ));

    var res = await request.send();
    print(await res.stream.bytesToString().onError((error, stackTrace) {
      debugPrint(error.toString());
      return error.toString();
    }));
    // print("object: ${company.toJson()}");
    // String fileName = file.path.split('/').last;
    // Map<String, dynamic> dataSend = {};
    // dataSend.addAll(company.toJson());
    // dataSend.addAll({
    //   "image": await MultipartFile.fromFile(file.path,
    //       filename: fileName,
    //       contentType: MediaType("image", fileName.split(".").last)),
    // });

    // debugPrint("data sent: $dataSend");
    // FormData data = FormData.fromMap(dataSend);
    // debugPrint("data: $data");
    // emit(UpdateLoadingState());
    // await DioHelper.postData(
    //         url: "http://10.0.2.2:8080/mobiletask/company/updateCompany.php",
    //         data: dataSend)
    //     .then((value) {
    //   // if (value is Map<String, dynamic>)
    //   print("$value is string");
    //   Map<String, dynamic> valueMap = json.decode(value.data);
    //   if (valueMap["companyId"] != null) {
    //     this.company = CompanyResponse.fromJson(valueMap).data!;
    //     emit(UpdatedSuccessfullyState());
    //   }
    //   print("data after adding image :  $value");
    // }).catchError((error) => print(error.toString()));
  }
}
