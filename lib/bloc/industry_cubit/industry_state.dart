part of 'industry_cubit.dart';

@immutable
abstract class IndustryState {}

class IndustryInitial extends IndustryState {}

class GetingIndustriesSuccessfullyState extends IndustryState {}

class GetingIndustriesFailedState extends IndustryState {}

class GetingIndustriesLoadingState extends IndustryState {}
