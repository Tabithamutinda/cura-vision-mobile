import 'package:cura_vision/helpers/constants.dart';
import 'package:flutter/material.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final action;
  final String buttonText;
  final double? borderRadius;

  PrimaryButtonWidget(
      {super.key,
      required this.action,
      required this.buttonText,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    double effectiveBorderRadius = borderRadius ?? 15.0;
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(Constants.appPrimaryColor),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(effectiveBorderRadius)),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
