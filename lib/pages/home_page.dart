import 'dart:io';

import 'package:cura_vision/controllers/diagonosis/diagnosis_controller.dart';
import 'package:cura_vision/helpers/constants.dart';
import 'package:cura_vision/widgets/buttons/outlined_button_with_icon.dart';
import 'package:cura_vision/widgets/buttons/primary_button_widget.dart';
import 'package:cura_vision/widgets/textfields/form_label_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  XFile? _uploadedImage; // To hold the uploaded image file
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 85, // Adjust for smaller file size if needed
    );

    if (pickedImage != null && pickedImage.path.endsWith('.png')) {
      setState(() {
        _uploadedImage = pickedImage;
      });
    } else if (pickedImage != null) {
      // Show an error if the selected file is not a PNG
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Only PNG images are allowed!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(Constants.appbackgroundColor),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
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
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 1,
                      color:  const Color(Constants.appFillColor).withOpacity(0.5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
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
                },
              ),
              Obx(
                () => diagnosisController.imageType.value == 'Malaria'
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 69,
                          ),
                          GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(
                                          Constants.appPrimaryColor),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(
                                      15), // Rounded corners
                                  color: const Color(Constants
                                      .appWhite) // Light grey background
                                  ),
                              child: _uploadedImage == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            "assets/images/upload.svg"),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Select Image',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color:
                                                  Color(Constants.appTextGrey)),
                                        ),
                                      ],
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.file(
                                        File(_uploadedImage!.path),
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
                            action: () {},
                            buttonText: 'Open Camera & Take a Photo',
                          ),
                          const SizedBox(
                            height: 44,
                          ),
                          PrimaryButtonWidget(
                              action: () {}, buttonText: 'Review')
                        ],
                      )
                    : const SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
