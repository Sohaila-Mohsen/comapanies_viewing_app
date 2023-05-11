import 'package:authentication_app/bloc/checkbox_cubit/check_box_cubit.dart';
import 'package:authentication_app/models/checkbox_model.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final bool isMulti;
  CheckBoxModel values;
  CustomCheckBox(this.values, {this.isMulti = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CheckBoxCubit checkBoxCubit = CheckBoxCubit.get(context);
    return SizedBox(
      height: values.choices.length * 33 + 30,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: values.choices.length,
          itemBuilder: (context, index) => SizedBox(
                height: 33,
                child: ListTile(
                  leading: Checkbox(
                      onChanged: (value) {
                        if (isMulti) {
                          checkBoxCubit.addValue(values, index);
                        } else {
                          checkBoxCubit.changeValue(values, index);
                        }
                      },
                      value: values.selected.contains(index)),
                  title: Text(values.choices[index]),
                ),
              )),
    );
  }
}
