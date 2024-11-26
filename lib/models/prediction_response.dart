
class PredictionResponse {
  String? classLabel;
  String? confidencePercentage;
  double? confidenceRaw;
  List<int>? imageDimensions;
  String? modelUsed;
  List<double>? predictionRaw;

  PredictionResponse({this.classLabel, this.confidencePercentage, this.confidenceRaw, this.imageDimensions, this.modelUsed, this.predictionRaw});

  PredictionResponse.fromJson(Map<String, dynamic> json) {
    if(json["class_label"] is String) {
      classLabel = json["class_label"];
    }
    if(json["confidence_percentage"] is String) {
      confidencePercentage = json["confidence_percentage"];
    }
    if(json["confidence_raw"] is double) {
      confidenceRaw = json["confidence_raw"];
    }
    if(json["image_dimensions"] is List) {
      imageDimensions = json["image_dimensions"] == null ? null : List<int>.from(json["image_dimensions"]);
    }
    if(json["model_used"] is String) {
      modelUsed = json["model_used"];
    }
    if(json["prediction_raw"] is List) {
      predictionRaw = json["prediction_raw"] == null ? null : List<double>.from(json["prediction_raw"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["class_label"] = classLabel;
    _data["confidence_percentage"] = confidencePercentage;
    _data["confidence_raw"] = confidenceRaw;
    if(imageDimensions != null) {
      _data["image_dimensions"] = imageDimensions;
    }
    _data["model_used"] = modelUsed;
    if(predictionRaw != null) {
      _data["prediction_raw"] = predictionRaw;
    }
    return _data;
  }
}