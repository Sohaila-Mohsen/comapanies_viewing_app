import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../style/app_text_style/app_textstyle.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String> validator;
  final bool obsecure;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool isMulti;
  final bool autofocus;
  final bool enabled;
  final String? errorText;
  final String label;
  final String? hint;
  final Widget? suffix;
  final Widget? prefix;

  CustomTextField(
      {this.controller,
      required this.validator,
      this.keyboardType = TextInputType.text,
      this.obsecure = false,
      this.onTap,
      this.hint,
      this.isMulti = false,
      this.readOnly = false,
      this.autofocus = false,
      this.errorText,
      required this.label,
      this.suffix,
      this.prefix,
      this.enabled = true,
      this.onEditingCompleted,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label",
            style: AppTextStyle.labelTextStyle(11),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: onChanged,
            keyboardType: keyboardType,
            controller: controller,
            enabled: enabled,
            readOnly: readOnly,
            //initialValue: hint,
            style: (enabled) ? null : AppTextStyle.grayTextStyle(14),
            decoration: InputDecoration(
              errorMaxLines: 5,
              hintText: hint,
              isDense: true,
              contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              print("validator ${validator(value)}");
              return validator(value);
            },
          ),
        ],
      ),
    );
  }
}
