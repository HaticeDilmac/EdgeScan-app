import 'package:edge_scan/controller/locale_controller.dart';
import 'package:edge_scan/providers/theme_providers.dart';
import 'package:edge_scan/utils/custom_appbar.dart';
import 'package:edge_scan/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeController = Get.find<LocaleController>();
    final isDark = themeProvider.isDarkTheme;

    final switchActiveColor = Theme.of(context).hoverColor;
    final switchInactiveColor = Theme.of(context).disabledColor;

    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.settings),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSmall,
          vertical: Dimensions.paddingSmall,
        ),
        child: ListView(
          children: [
            //theme change widget
            _buildSettingCard(
              context,
              title: AppLocalizations.of(context)!.changeTheme,
              icon: isDark ? Icons.dark_mode : Icons.light_mode,
              value: isDark,
              onChanged: (val) => themeProvider.toggleTheme(),
              activeColor: switchActiveColor,
              inactiveColor: switchInactiveColor,
            ),
            SizedBox(height: 0.5.h),
            _buildSettingCard(
              context,
              title: AppLocalizations.of(context)!.changeLanguage,
              icon:
                  localeController.currentLocale.value.languageCode == 'en'
                      ? Icons
                          .flag_outlined // en ikon
                      : Icons.translate, // tr icon
              value: localeController.currentLocale.value.languageCode == 'en',
              onChanged: (val) {
                final newLangCode = val ? 'en' : 'tr';
                localeController.changeLocale(newLangCode);
              },
              activeColor: switchActiveColor,
              inactiveColor: switchInactiveColor,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildSettingCard(
  BuildContext context, {
  required String title,
  required IconData icon,
  required bool value,
  required Function(bool) onChanged,
  required Color activeColor,
  required Color inactiveColor,
}) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    color: Theme.of(context).cardColor,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingMedium),
      child: SwitchListTile(
        title: Text(title),
        value: value,
        onChanged: onChanged,
        secondary: Icon(icon),
        activeColor: activeColor,
        inactiveThumbColor: inactiveColor,
        inactiveTrackColor: inactiveColor.withOpacity(0.5),
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      ),
    ),
  );
}
