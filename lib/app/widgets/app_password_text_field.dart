import 'package:ecomm/app/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

/// {@template app_password_text_field}
/// An Password text field component.
/// {@endtemplate}
class AppPasswordTextField extends StatelessWidget {
  /// {@macro app_password_text_field}
  const AppPasswordTextField({
    super.key,
    this.controller,
    this.hintText,
    this.suffix,
    this.readOnly,
    this.onChanged,
    this.errorText,
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// Text that suggests what sort of input the field accepts.
  final String? hintText;

  /// A widget that appears after the editable part of the text field.
  final Widget? suffix;

  /// Text that appears below the field.
  final String? errorText;

  /// Called when the user inserts or deletes texts in the text field.
  final ValueChanged<String>? onChanged;

  /// Whether the text field should be read-only.
  /// Defaults to false.
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      hintText: hintText,
      keyboardType: TextInputType.text,
      autoFillHints: const [AutofillHints.password],
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      readOnly: readOnly ?? false,
      onChanged: onChanged,
      suffix: suffix,
      errorText: errorText,
    );
  }
}
