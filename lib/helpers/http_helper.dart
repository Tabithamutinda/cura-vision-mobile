import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:cura_vision/helpers/constants.dart';

class HttpHelper {
  final Dio _dio = Dio(); // Dio instance for making requests

  // Method to send POST requests with multipart/form-data
  Future<dynamic> post(String endpoint, FormData formData, {bool isMultipart = false}) async {
    print('POST Request: ${Constants.ENDPOINT}$endpoint');

    try {
      // If multipart form data, set the appropriate headers
      final response = await _dio.post(
        '${Constants.ENDPOINT}$endpoint',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': isMultipart ? 'multipart/form-data' : 'application/json',
          },
        ),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data; // Return response data if successful
      } else if (response.statusCode == 400 || response.statusCode == 401 || response.statusCode == 422) {
        // Return error details for certain status codes
        return response.data;
      } else {
        throw Exception('Failed to post data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to post data: $e');
    }
  }
}