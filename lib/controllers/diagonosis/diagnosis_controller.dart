import 'package:cura_vision/helpers/http_helper.dart';
import 'package:cura_vision/models/prediction_response.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:image_picker/image_picker.dart';

class DiagnosisController extends GetxController {
  Rx<String> selected = "".obs;
  Rx<bool> isLoading = false.obs;
  Rx<PredictionResponse> predictionResponse = PredictionResponse().obs;
  Rx<String> selectedModel = "simple_cnn".obs;
  Rx<String> selectedTbModel = "simple_cnn_tb_model".obs;
  Rx<String> errorMessage = "".obs;
  Rx<bool> hasPredicted = false.obs;
  Rx<String> imageType = "".obs;
  Rx<XFile?> uploadedImage = Rx<XFile?>(null);

  Future<bool> predictMalariaCell() async {
    predictionResponse.value = PredictionResponse();
    isLoading.value = true;
    try {
      // Validate the selected file
      if (selected.value.isEmpty) {
        errorMessage.value = "Please select an image.";
        return false;
      }

      // Prepare the form data
      Dio.FormData formData = Dio.FormData.fromMap({
        "image": await Dio.MultipartFile.fromFile(selected.value, filename: selected.value),
        "model": selectedModel.value,
      });

      // Send the request
      var decodedResponse = await HttpHelper().post('/predict', formData, isMultipart: true);

      if (decodedResponse is String) {
        errorMessage.value = decodedResponse;
        return false;
      }

      // Parse the response
      predictionResponse.value = PredictionResponse.fromJson(decodedResponse);
      hasPredicted.value = true;
    
      return true;
    } catch (e) {
      errorMessage.value = "An error occurred: $e";
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> predictTuberculosisXray() async {
    predictionResponse.value = PredictionResponse();
    isLoading.value = true;
    try {
      // Validate the selected file
      if (selected.value.isEmpty) {
        errorMessage.value = "Please select an image.";
        return false;
      }

      // Prepare the form data
      Dio.FormData formData = Dio.FormData.fromMap({
        "image": await Dio.MultipartFile.fromFile(selected.value, filename: selected.value),
        "model": selectedTbModel.value,
      });

      // Send the request
      var decodedResponse = await HttpHelper().post('/predict/tuberculosis', formData, isMultipart: true);

      if (decodedResponse is String) {
        errorMessage.value = decodedResponse;
        return false;
      }

      // Parse the response
      predictionResponse.value = PredictionResponse.fromJson(decodedResponse);
      hasPredicted.value = true;
    
      return true;
    } catch (e) {
      errorMessage.value = "An error occurred: $e";
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
