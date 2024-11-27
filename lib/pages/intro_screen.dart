import 'package:cura_vision/helpers/constants.dart';
import 'package:cura_vision/pages/home_page.dart';
import 'package:cura_vision/widgets/buttons/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
        PrimaryButtonWidget(action: (){
                  Get.to(()=> const Homepage());
                }, buttonText: 'Ready to get Started?'),
                const SizedBox(height: 20,),
                const Text("Note: This app is a diagnostic aid. Always consult a healthcare professional for confirmation and treatment.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(Constants.appTextGrey)
              ),
              ),
          ],

        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Image.asset("assets/images/diagnose.png", height: 400,),
              const SizedBox(height: 60,),
              const Text("Accessible to Everyone",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              ),
              const SizedBox(height: 10,),
              const Text("No need for specialized equipment—our app works with just an image.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
