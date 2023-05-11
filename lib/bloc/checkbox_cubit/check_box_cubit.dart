import 'package:authentication_app/models/checkbox_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'check_box_state.dart';

class CheckBoxCubit extends Cubit<CheckBoxState> {
  CheckBoxCubit() : super(CheckBoxInitial());
  static CheckBoxCubit get(context) => BlocProvider.of(context);
  //List<int> values = [];

  addValue(CheckBoxModel values, int value) {
    if (values.selected.contains(value)) {
      values.selected.remove(value);
    } else
      values.selected.add(value);

    emit(ValueChangedState());
  }

  changeValue(CheckBoxModel values, value) {
    if (values.selected.length > 0 && value == values.selected[0])
      values.selected.removeAt(0);
    else {
      if (values.selected.length > 0) values.selected.removeAt(0);
      values.selected.add(value);
    }
    emit(ValueChangedState());
  }
}
