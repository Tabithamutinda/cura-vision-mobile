import 'package:cura_vision/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OutlinedIconButton extends StatelessWidget {
  final action;
  final String buttonText;
  final double? borderRadius;

  OutlinedIconButton(
      {super.key,
      required this.action,
      required this.buttonText,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    double effectiveBorderRadius = borderRadius ?? 20.0;
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton.icon(

        onPressed: action,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0XFFE7FBF5),
          foregroundColor: Color(Constants.appPrimaryColor),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(effectiveBorderRadius)),
             
        ),
        icon: SvgPicture.asset("assets/images/camera.svg"),
        label: Text(
          buttonText,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}