import 'package:cura_vision/helpers/constants.dart';
import 'package:cura_vision/helpers/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.textHint,
    this.validator = _defaultValidator,
    this.textInputType = TextInputType.text,
    this.onChanged = _defaultOnChange,
    this.prefixIcon,
    this.prefixText,
    this.inputFormatters,
    this.enabled = true,
    this.initialValue,
    this.textController,
  });

  final TextEditingController? textController;
  final String textHint;
  final String? Function(String?) validator;
  final dynamic Function(String?) onChanged;
  final TextInputType textInputType;
  final Widget? prefixIcon;
  final String? prefixText;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;

  static String? _defaultValidator(value) {
    return null;
  }

  static String? _defaultOnChange(value) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        WidgetHelper.closeKeyboard();
      },
      controller: textController,
      keyboardType: textInputType,
      validator: validator,
      onChanged: onChanged,
      enabled: enabled,
      inputFormatters: inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: initialValue,
      style: const TextStyle(color: Color(Constants.appWhite)),
      //focusNode: FocusNode(),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: prefixIcon ??
            (prefixText == null
                ? null
                : Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(prefixText ?? '',
                        style: const TextStyle(
                          color: Color(Constants.appWhite),
                        )))),
        // prefixText: prefixText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.red.shade400,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.blue.shade300,
            width: 1,
          ),
        ),
        filled: true,
        fillColor: const Color(Constants.appWhite),
        isDense: true,
        hintText: textHint,
        hintStyle: const TextStyle(color: Color(Constants.appHintTextColor,), fontSize: 12),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(width: 1)),
      ),
    );
  }
}