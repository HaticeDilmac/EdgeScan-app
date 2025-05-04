import 'package:edge_scan/providers/receipt_provider.dart';
import 'package:edge_scan/providers/tutorial_provider.dart';
import 'package:edge_scan/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'controller/locale_controller.dart';
import 'providers/theme_providers.dart';
import 'providers/history_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/history/history_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ReceiptProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => TutorialProvider()),
      ],
      child: ResponsiveSizer(
        builder: (context, orientation, deviceType) {
          return const MyApp();
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    final localeController = Get.put(LocaleController());

    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/home_screen': (context) => const HomeScreen(),
          '/history_screen': (context) => const HistoricalScreen(),
          '/menu': (context) => const MenuScreen(),
        },
        theme: themeProvider.getThemeData(context),
        themeMode: ThemeMode.system,
        supportedLocales: const [
          //supportedLocales devce language show device language tr app tr
          Locale('tr'),
          Locale('en'),
        ],
        locale: localeController.currentLocale.value, //direct system language
        fallbackLocale: const Locale('tr'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
      ),
    );
  }
}
