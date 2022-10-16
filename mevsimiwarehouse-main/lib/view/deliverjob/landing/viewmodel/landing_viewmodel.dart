import 'package:flutter/material.dart';
import 'package:mevsimiwarehouse/core/constants/_constants_exports.dart';

class LandingViewModel extends ChangeNotifier {
  final TextEditingController textOrderBarcode = TextEditingController();
  final TextEditingController textShelfBarcode = TextEditingController();
  final TextEditingController textOrderNumber = TextEditingController();

  final FocusNode focusOrderBarcode = FocusNode();
  final FocusNode focusShelfBarcode = FocusNode();
  final FocusNode focusOrderNumber = FocusNode();

  DateTime datePickerValue = DateTime.now();

  void datePicker(bool increment) {
    if (increment) {
      datePickerValue = datePickerValue.add(const Duration(days: 1));
      ApplicationConstants.dateTimeHeader =
          "deliveryAt[0]=${datePickerValue.toString().substring(0, 10)}&deliveryAt[1]=${datePickerValue.toString().substring(0, 10)}";
    } else {
      datePickerValue = datePickerValue.add(const Duration(days: -1));
      ApplicationConstants.dateTimeHeader =
          "deliveryAt[0]=${datePickerValue.toString().substring(0, 10)}&deliveryAt[1]=${datePickerValue.toString().substring(0, 10)}";
    }

    notifyListeners();
  }
}
//368305