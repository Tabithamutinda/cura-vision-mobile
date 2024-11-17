import 'package:cura_vision/helpers/constants.dart';
import 'package:flutter/material.dart';

class FormLabelText extends StatelessWidget {
  final String title;
  double fontSize;
  double bottomPadding;
  FontWeight fontWeight;

  FormLabelText({
    super.key,
    required this.title,
    this.fontWeight = FontWeight.w400,
    this.fontSize = 14,
    this.bottomPadding = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: const Color(Constants.appBlack),
        ),
      ),
    );
  }
}