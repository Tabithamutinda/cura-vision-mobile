import 'dart:io';

import 'package:cura_vision/controllers/diagonosis/diagnosis_controller.dart';
import 'package:cura_vision/helpers/constants.dart';
import 'package:cura_vision/widgets/suggestions_box.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PredictionsResultPage extends StatefulWidget {
  const PredictionsResultPage({super.key});

  @override
  State<PredictionsResultPage> createState() => _PredictionsResultPageState();
}

class _PredictionsResultPageState extends State<PredictionsResultPage> {
  final DiagnosisController diagnosisController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              diagnosisController.selected.value = '';
              diagnosisController.uploadedImage.value = null;
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Obx(
                () => diagnosisController.imageType.value == "Malaria"
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          diagnosisController
                                      .predictionResponse.value.classLabel ==
                                  "Parasitized"
                              ? const Text(
                                  "🩺 The analysis suggests the presence of parasites in the blood sample. This could be indicative of malaria infection 😷.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              : const Text(
                                  "🌞 Great news! No signs of infection were detected in this image 😊.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                          //       const SizedBox(height: 16),
                          // const Text(
                          //   "Review has been submitted \nsuccessfully!",
                          //   textAlign: TextAlign.center,
                          //   style: TextStyle(fontSize: 18),
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: const Color(Constants.appFillColor),
                                borderRadius: BorderRadius.circular(20)),
                            child: Obx(() {
                              if (diagnosisController
                                  .selected.value.isNotEmpty) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    File(diagnosisController.selected.value),
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              } else {
                                return const Text(
                                  "No image selected",
                                  style: TextStyle(fontSize: 16),
                                );
                              }
                            }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Risk: ${diagnosisController.predictionResponse.value.confidencePercentage}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: diagnosisController.predictionResponse
                                            .value.classLabel ==
                                        "Parasitized"
                                    ? Colors.red
                                    : Colors.green),
                          ),
                          const SizedBox(
                            height: 16,
                          ),

                          if (diagnosisController
                                  .predictionResponse.value.classLabel ==
                              "Parasitized") ...[
                            const Text(
                              "Here’s what you can do:",
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 12),
                            const SuggestionTile(
                              icon: Icons.local_hospital,
                              title: "Consult a Doctor",
                              description:
                                  "Contact a medical professional for immediate evaluation and treatment.",
                            ),
                            const SuggestionTile(
                              icon: Icons.info_outline,
                              title: "Learn About Parasitic Infections",
                              description:
                                  "Understand more about parasitic diseases, symptoms, and how they spread.",
                            ),
                            const SuggestionTile(
                              icon: Icons.location_on,
                              title: "Find a Nearby Clinic",
                              description:
                                  "Locate a clinic or hospital for further assistance.",
                            ),
                          ] else ...[
                            const Text(
                              "Here’s how to stay healthy:",
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 12),
                            const SuggestionTile(
                              icon: Icons.bug_report,
                              title: "Use Mosquito Nets",
                              description:
                                  "Sleep under treated mosquito nets to protect yourself from mosquito bites at night.",
                            ),
                            const SuggestionTile(
                              icon: Icons.lightbulb,
                              title: "Avoid Stagnant Water",
                              description:
                                  "Eliminate stagnant water around your home to reduce mosquito breeding grounds.",
                            ),
                            const SuggestionTile(
                              icon: Icons.health_and_safety,
                              title: "Apply Mosquito Repellent",
                              description:
                                  "Use mosquito repellents on exposed skin, especially during evenings and nights.",
                            ),
                            const SuggestionTile(
                              icon: Icons.cleaning_services,
                              title: "Maintain Clean Surroundings",
                              description:
                                  "Keep your living area clean and free of litter that can collect water.",
                            ),
                            const SuggestionTile(
                              icon: Icons.vaccines,
                              title: "Consider Prophylaxis",
                              description:
                                  "Consult a healthcare provider about preventive malaria medication if traveling to high-risk areas.",
                            ),
                            const SuggestionTile(
                              icon: Icons.local_hospital,
                              title: "Seek Medical Attention Early",
                              description:
                                  "If you experience symptoms like fever or chills, visit a healthcare provider immediately.",
                            ),
                          ],
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          diagnosisController
                                      .predictionResponse.value.classLabel ==
                                  "Tuberculosis"
                              ? const Text(
                                  "🩺 The analysis suggests the presence of abnormalities in the X-ray. This could be indicative of tuberculosis infection 🫁.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              : const Text(
                                  "🌞 Great news! No signs of tuberculosis were detected in this X-ray 😊.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                          //       const SizedBox(height: 16),
                          // const Text(
                          //   "Review has been submitted \nsuccessfully!",
                          //   textAlign: TextAlign.center,
                          //   style: TextStyle(fontSize: 18),
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: const Color(Constants.appFillColor),
                                borderRadius: BorderRadius.circular(20)),
                            child: Obx(() {
                              if (diagnosisController
                                  .selected.value.isNotEmpty) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    File(diagnosisController.selected.value),
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              } else {
                                return const Text(
                                  "No image selected",
                                  style: TextStyle(fontSize: 16),
                                );
                              }
                            }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Risk: ${diagnosisController.predictionResponse.value.confidencePercentage}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: diagnosisController.predictionResponse
                                            .value.classLabel ==
                                        "Tuberculosis"
                                    ? Colors.red
                                    : Colors.green),
                          ),
                          const SizedBox(
                            height: 16,
                          ),

                          if (diagnosisController
                                  .predictionResponse.value.classLabel ==
                              "Tuberculosis") ...[
                            const Text(
                              "Here’s what you can do:",
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 12),
                            const SuggestionTile(
                              icon: Icons.local_hospital,
                              title: "Consult a Doctor",
                              description:
                                  "Reach out to a healthcare professional for a comprehensive evaluation and treatment plan.",
                            ),
                            const SuggestionTile(
                              icon: Icons.info_outline,
                              title: "Learn About Tuberculosis",
                              description:
                                  "Educate yourself on tuberculosis, its symptoms, treatment options, and prevention strategies.",
                            ),
                            const SuggestionTile(
                              icon: Icons.location_on,
                              title: "Find a TB Care Facility",
                              description:
                                  "Locate a specialized tuberculosis clinic or hospital for further diagnosis and care.",
                            ),
                          ] else ...[
                            const Text(
                              "Here’s how to stay healthy:",
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 12),
                            const SuggestionTile(
                              icon: Icons.check_circle_outline,
                              title: "Maintain Good Health",
                              description:
                                  "Keep up with a healthy lifestyle to continue staying disease-free.",
                            ),
                            const SuggestionTile(
                              icon: Icons.vaccines,
                              title: "Stay Vaccinated",
                              description:
                                  "Ensure you're up-to-date with vaccines like the BCG vaccine to prevent tuberculosis.",
                            ),
                            const SuggestionTile(
                              icon: Icons.health_and_safety,
                              title: "Regular Health Checkups",
                              description:
                                  "Schedule periodic health screenings to monitor your overall well-being.",
                            ),
                          ],
                        ],
                      ),
              ))),
    );
  }
}
