import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends GetxController {
  Rx<Locale> currentLocale = const Locale('tr').obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedLocale(); //load Locale
  }

  //sace language loading
  void _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString('selected_language');

    // If there is a language saved, load it
    if (langCode != null) {
      currentLocale.value = Locale(langCode);
      Get.updateLocale(currentLocale.value); // Locale update
    } else {
      //If there is no language saved, use the device language
      Locale deviceLocale = Get.deviceLocale ?? const Locale('tr');
      currentLocale.value = deviceLocale;
      Get.updateLocale(currentLocale.value);
    }
  }

  // Language change function
  void changeLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'selected_language', languageCode); // lanbguage chagne save
    currentLocale.value = Locale(languageCode);
    Get.updateLocale(currentLocale.value); //language update
  }
}
