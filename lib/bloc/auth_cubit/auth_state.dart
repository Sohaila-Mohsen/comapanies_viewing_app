part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

class RegisterErrorState extends AuthState {}

class LoginLoadingState extends AuthState {}

class LogedinSuccessfullyState extends AuthState {}

class LogedinFailedState extends AuthState {}

class GetingIndustriesSuccessState extends AuthState {}

class GetingIndustriesFailState extends AuthState {}

class GetingIndustriesLoadState extends AuthState {}
