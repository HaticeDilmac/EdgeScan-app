import 'package:edge_scan/utils/appColors.dart' show AppColors;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  ThemeProvider() {
    loadFromPrefs();
  }

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    saveToPrefs();
    loadFromPrefs();
  }

  void loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    notifyListeners();
  }

  void saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', isDarkTheme);
    notifyListeners();
  }

  ThemeData getThemeData(BuildContext context) {
    double scaleFactor = MediaQuery.of(context).textScaleFactor;
    return isDarkTheme
        ? ThemeData.dark().copyWith(
          hoverColor: AppColors.lightBlue,
          scaffoldBackgroundColor: const Color.fromARGB(255, 7, 7, 7),
          cardColor: const Color.fromARGB(255, 28, 28, 28),
          canvasColor: AppColors.darkGrey,
          navigationBarTheme: const NavigationBarThemeData(
            backgroundColor: AppColors.darkGrey,
          ),
          appBarTheme: const AppBarTheme(
            color: AppColors.darkGrey,
            titleTextStyle: TextStyle(
              color: AppColors.primaryTextDark,
              fontSize: 20,
            ),
          ),
          primaryColor: AppColors.darkBlue,
          secondaryHeaderColor: AppColors.lightBlue,
          iconTheme: const IconThemeData(color: AppColors.primaryTextDark),
          textTheme: TextTheme(
            displaySmall: TextStyle(
              fontSize: 14 * scaleFactor,
              color: AppColors.primaryTextDark,
            ),
            displayMedium: TextStyle(
              fontSize: 17 * scaleFactor,
              color: AppColors.primaryTextDark,
            ),
            displayLarge: TextStyle(
              fontSize: 22 * scaleFactor,
              color: AppColors.primaryTextDark,
            ),
            bodySmall: TextStyle(
              fontSize: 12 * scaleFactor,
              color: AppColors.primaryTextDark,
            ),
            bodyMedium: TextStyle(
              fontSize: 14 * scaleFactor,
              color: AppColors.primaryTextDark,
            ),
            bodyLarge: TextStyle(
              fontSize: 16 * scaleFactor,
              color: AppColors.primaryTextDark,
            ),
            titleSmall: TextStyle(
              fontSize: 14 * scaleFactor,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryTextDark,
            ),
            titleMedium: TextStyle(
              fontSize: 18 * scaleFactor,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryTextDark,
            ),
            titleLarge: TextStyle(
              fontSize: 22 * scaleFactor,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryTextDark,
            ),
          ),
        )
        : ThemeData.light().copyWith(
          hoverColor: AppColors.lightBlue,
          scaffoldBackgroundColor: Colors.white,
          cardColor: const Color.fromARGB(255, 229, 228, 228),
          canvasColor: AppColors.lightGrey,
          primaryColor: AppColors.darkBlue,
          navigationBarTheme: const NavigationBarThemeData(
            backgroundColor: Colors.white,
          ),
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            titleTextStyle: TextStyle(
              fontSize: 20,
              color: AppColors.primaryTextLight,
            ),
          ),
          secondaryHeaderColor: AppColors.lightBlue,
          iconTheme: const IconThemeData(color: AppColors.primaryTextLight),
          textTheme: TextTheme(
            displaySmall: TextStyle(
              fontSize: 14 * scaleFactor,
              color: AppColors.primaryTextLight,
            ),
            displayMedium: TextStyle(
              fontSize: 17 * scaleFactor,
              color: AppColors.primaryTextLight,
            ),
            displayLarge: TextStyle(
              fontSize: 22 * scaleFactor,
              color: AppColors.primaryTextLight,
            ),
            bodySmall: TextStyle(
              fontSize: 12 * scaleFactor,
              color: AppColors.primaryTextLight,
            ),
            bodyMedium: TextStyle(
              fontSize: 14 * scaleFactor,
              color: AppColors.primaryTextLight,
            ),
            bodyLarge: TextStyle(
              fontSize: 16 * scaleFactor,
              color: AppColors.primaryTextLight,
            ),
            titleSmall: TextStyle(
              fontSize: 14 * scaleFactor,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryTextLight,
            ),
            titleMedium: TextStyle(
              fontSize: 18 * scaleFactor,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryTextLight,
            ),
            titleLarge: TextStyle(
              fontSize: 22 * scaleFactor,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryTextLight,
            ),
          ),
        );
  }
}
