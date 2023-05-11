part of 'check_box_cubit.dart';

@immutable
abstract class CheckBoxState {}

class CheckBoxInitial extends CheckBoxState {}

class ValueChangedState extends CheckBoxState {}
