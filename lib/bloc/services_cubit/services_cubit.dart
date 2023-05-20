import 'dart:convert';
import 'dart:developer';
import 'package:authentication_app/models/company.dart';
import 'package:authentication_app/models/company_service_response.dart';
import 'package:authentication_app/services/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import '../../models/service.dart';
part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit() : super(ServicesInitial());
  static ServicesCubit get(context) => BlocProvider.of(context);
  List<Service>? services = [];
  List<Service> fav = [];
  List<Data> companiesForService = [];

  ServicesResponse? servicesResponse;

  getservises() async {
    emit(GetServicesLoadingState());
    await DioHelper.getData(
            url: "http://10.0.2.2:8080/mobiletask/service/getServices.php")
        .then((value) {
      Map<String, dynamic> val = json.decode(value.data);
      print("services response $val");
      servicesResponse = ServicesResponse.fromJson(val);
      print("servicesResponse $servicesResponse");
      if (servicesResponse != null && servicesResponse!.services != null) {
        services = servicesResponse!.services;
      }
      emit(GetServicesSuccessState());
    }).onError((error, stackTrace) {
      debugPrint("get services error : $error");
      emit(GetServicesFailState());
    });
  }

  addFavorite(String companyId, String serviceId) async {
    emit(ServiceAddedToFavLoadingState());
    await DioHelper.postData(
        url:
            "http://10.0.2.2:8080/mobiletask/favoriteService/addCompanyFavoriteService.php",
        data: {
          "companyId": companyId,
          "serviceId": serviceId
        }).then((value) async {
      var val = json.decode(value.data);
      print("add fav response $val");
      fav = await getFav(companyId);
      emit(ServiceAddedToFavSuccesState());
    }).onError((error, stackTrace) {
      debugPrint("add fav error : $error");
      emit(ServiceAddedToFavFailState());
    });
  }

  getFav(String companyId) async {
    emit(GetFavLoadingState());
    await DioHelper.postData(
        url:
            "http://10.0.2.2:8080/mobiletask/favoriteService/getCompanyFavService.php",
        data: {"companyId": companyId}).then((value) {
      var val = json.decode(value.data);
      print("fav response $val");
      ServicesResponse favorite = ServicesResponse.fromJson(val);
      print("servicesResponse ${ServicesResponse.fromJson(val)}");
      if (favorite.services != null) {
        fav = favorite.services!;
        emit(GetFavSuccessState());
      }
    }).onError((error, stackTrace) {
      debugPrint("get fav error : $error");
      emit(GetFavFailState());
    });
  }

  bool isFav(String serviceId) {
    for (Service service in fav) {
      if (service.serviceId == serviceId) {
        return true;
      }
    }
    return false;
  }

  Service? getServiceById(String serviceId) {
    if (services != null) {
      for (Service service in services!) {
        if (service.serviceId == serviceId) {
          return service;
        }
      }
    }
    return null;
  }

  getCompany(String companyId) async {
    await DioHelper.postData(
        url: "http://10.0.2.2:8080/mobiletask/company/getCompany.php",
        data: {"companyId": companyId}).then((value) {
      var val = json.decode(value.data);
      print("add fav response $val");
    });
  }

  static Future<String?> getDistance(Data comp1, Position comp2) async {
    print(
        "lat 1 : ${comp1.lat} . lat2: ${comp2.latitude} , lon1 : ${comp1.lon} , lon2 : ${comp2.longitude}");
    await DioHelper.postData(
        url: "http://10.0.2.2:8080/mobileTask/company/getDistance.php",
        data: {
          "lat1": comp1.lat,
          "lat2": comp2.latitude.toString(),
          "lon1": comp1.lon,
          "lon2": comp2.longitude.toString()
        }).then((value) {
      var val = json.decode(value.data);
      if (val['distance'] != null) {
        return val['distance'];
      }
    }).onError((error, stackTrace) {
      debugPrint("get distance error : $error");
    });
  }

  getCompanies(Service service) async {
    emit(GetCompanyServiceLoadingState());
    await DioHelper.postData(
        url:
            "http://10.0.2.2:8080/mobileTask/service/getAllCompaniesBelongToService.php",
        data: {"serviceId": service.serviceId}).then((value) {
      print("get companies service response1 $value");
      var val = json.decode(value.data);
      print("get companies service response $val");

      CompanyServiceResponse companyServiceResponse =
          CompanyServiceResponse.fromJson(val);
      if (companyServiceResponse.data != null) {
        companiesForService = companyServiceResponse.data!;
        emit(GetCompanyServiceSuccessState());
      }
    }).onError((error, stackTrace) {
      debugPrint("get companies service error : $error");
      emit(GetCompanyServiceFailState());
    });
  }
}
