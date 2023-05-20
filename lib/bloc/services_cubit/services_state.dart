part of 'services_cubit.dart';

@immutable
abstract class ServicesState {}

class ServicesInitial extends ServicesState {}
class GetServicesSuccessState extends ServicesState {}
class GetServicesFailState extends ServicesState {}
class GetServicesLoadingState extends ServicesState {}
class ServiceAddedToFavSuccesState extends ServicesState {}
class ServiceAddedToFavFailState extends ServicesState {}
class ServiceAddedToFavLoadingState extends ServicesState {}
class GetFavLoadingState extends ServicesState {}
class GetFavSuccessState extends ServicesState {}
class GetFavFailState extends ServicesState {}
class GetCompanyServiceLoadingState extends ServicesState {}
class GetCompanyServiceSuccessState extends ServicesState {}
class GetCompanyServiceFailState extends ServicesState {}
