import 'package:flutter/material.dart';

class WidgetHelper {
    static void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

}