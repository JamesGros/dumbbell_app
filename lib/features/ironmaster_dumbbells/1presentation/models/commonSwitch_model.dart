import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CommonSwitchClass {
  String title = "";
  String onName = "";
  String offName = "";
  bool isSwitchedOn = false;
  void Function(BuildContext context, bool value)? callbackFunc;

  CommonSwitchClass(
      {required this.title,
      required this.onName,
      required this.offName,
      required this.isSwitchedOn,
      this.callbackFunc}) {
    title = title;
    onName = onName;
    offName = offName;
    isSwitchedOn = isSwitchedOn;
    callbackFunc = callbackFunc ?? onChangePlaceholder;
  }

  void onChangePlaceholder(BuildContext context, bool value) {
    if (kDebugMode) {
      print("CommonSwitchClass::onChangePlaceholder() value = $value");
    }
  }
}
