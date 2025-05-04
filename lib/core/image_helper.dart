import 'dart:io';
import 'package:edge_scan/common/custom_button.dart';
import 'package:edge_scan/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

class ImageHelper {
  static void showImageAlert(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final size = MediaQuery.of(context).size;

        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            AppLocalizations.of(context)!.imageDetails,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.file(File(imagePath)),
              SizedBox(height: 1.h),
              SizedBox(
                width: size.width,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CustomButton(
                    text: AppLocalizations.of(context)!.close,
                    onPressed: () => Navigator.of(context).pop(),
                    width: size.width,
                    height: 50,
                  ),
                ),
              ),
            ],
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSmall,
            vertical: Dimensions.paddingSmall,
          ),
        );
      },
    );
  }
}
