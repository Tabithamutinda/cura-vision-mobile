import 'dart:io';

import 'package:cura_vision/controllers/diagonosis/diagnosis_controller.dart';
import 'package:cura_vision/helpers/constants.dart';
import 'package:cura_vision/helpers/widget_helper.dart';
import 'package:cura_vision/pages/prediction_results_page.dart';
import 'package:cura_vision/widgets/buttons/outlined_button_with_icon.dart';
import 'package:cura_vision/widgets/buttons/primary_button_widget.dart';
import 'package:cura_vision/widgets/textfields/form_label_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final DiagnosisController diagnosisController = Get.find();
  final List<String> dropdownItems = ['Malaria', 'Tuberculosis'];
  final ImagePicker _picker = ImagePicker();

  analyzeImage() async {
    WidgetHelper.loadingDialog(
        title: 'Please wait', message: 'Analysing image');
    await diagnosisController.predictMalariaCell().then((value) {
      Get.back();
      if (!value) {
        WidgetHelper.snackbar('Error', diagnosisController.errorMessage.value);
      } else {
        Get.to(() => const PredictionsResultPage());
      }
    });
  }

  analyzeTBImage() async {
    WidgetHelper.loadingDialog(
        title: 'Please wait', message: 'Analysing Xray');
    await diagnosisController.predictTuberculosisXray().then((value) {
      Get.back();
      if (!value) {
        WidgetHelper.snackbar('Error', diagnosisController.errorMessage.value);
      } else {
        Get.to(() => const PredictionsResultPage());
      }
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedImage = await _picker.pickImage(
      source: source,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 85,
    );

    if (pickedImage != null) {
      setState(() {
        diagnosisController.uploadedImage.value = pickedImage;
        diagnosisController.selected.value = pickedImage.path;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image selected successfully!')),
      );
    } else if (pickedImage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Choose another image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(Constants.appWhite),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 70,
              ),
              const Center(
                child: Text(
                  'Upload Medical Image',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(Constants.appBlack)),
                ),
              ),
              const Center(
                child: Text(
                  'Please upload a clear medical image for analysis.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(Constants.appTextGrey),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              FormLabelText(
                title: 'Select type of image to upload',
                fontSize: 16,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  filled: true,
                  fillColor:
                      const Color(Constants.appFillColor).withOpacity(0.7),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 1,
                      color:
                          const Color(Constants.appFillColor).withOpacity(0.5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 1,
                      color:
                          const Color(Constants.appFillColor).withOpacity(0.5),
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                hint: const Text(
                  'Select image type',
                  style: TextStyle(color: Color(Constants.appHintTextColor)),
                ),
                items: dropdownItems.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (value) {
                  diagnosisController.imageType.value = value!;
                  diagnosisController.uploadedImage.value = null;
                  diagnosisController.selected.value = '';
                },
              ),
              diagnosisController.imageType.value == 'Malaria' ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 69,
                  ),
                  GestureDetector(
                    onTap: () => _pickImage(ImageSource.gallery),
                    child: Obx(
                      ()=> Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(Constants.appPrimaryColor),
                                width: 1),
                            borderRadius:
                                BorderRadius.circular(20), // Rounded corners
                            color: const Color(Constants.appbackgroundColor)
                                .withOpacity(0.4) // Light grey background
                            ),
                        child: diagnosisController.uploadedImage.value == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/images/upload.svg"),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Select Image',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(Constants.appTextGrey)),
                                  ),
                                ],
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  File(diagnosisController.uploadedImage.value!.path),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Color(
                            Constants.appDividerColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'or',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(
                              Constants.appBlack,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Color(
                            Constants.appDividerColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 44,
                  ),
                  OutlinedIconButton(
                    action: () => _pickImage(ImageSource.camera),
                    buttonText: 'Open Camera & Take a Photo',
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  PrimaryButtonWidget(
                      action: 
                      analyzeImage , buttonText: 'Review')
                ],
              ) : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 69,
                  ),
                  GestureDetector(
                    onTap: () => _pickImage(ImageSource.gallery),
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(Constants.appPrimaryColor),
                              width: 1),
                          borderRadius:
                              BorderRadius.circular(20), // Rounded corners
                          color: const Color(Constants.appbackgroundColor)
                              .withOpacity(0.4) // Light grey background
                          ),
                      child: diagnosisController.uploadedImage.value == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/images/upload.svg"),
                                const SizedBox(height: 8),
                                const Text(
                                  'Select Image',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color(Constants.appTextGrey)),
                                ),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                File(diagnosisController.uploadedImage.value!.path),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Color(
                            Constants.appDividerColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'or',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(
                              Constants.appBlack,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Color(
                            Constants.appDividerColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 44,
                  ),
                  OutlinedIconButton(
                    action: () => _pickImage(ImageSource.camera),
                    buttonText: 'Open Camera & Take a Photo',
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  PrimaryButtonWidget(
                      action:  analyzeTBImage, buttonText: 'Review')
                ],
              ),
           
            ],
          ),
        ),
      ),
    );
  }
}
