import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PhoneController extends GetxController {
  String PickedCountry = "+91";
  PickCountry(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        PickedCountry = country.displayName;
        print('Select country: ${country.displayName}');
      },
    );
    update();
  }
}
