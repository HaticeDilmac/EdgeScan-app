import 'dart:io';
import 'package:edge_scan/common/custom_button.dart';
import 'package:edge_scan/providers/receipt_provider.dart';
import 'package:edge_scan/providers/tutorial_provider.dart';
import 'package:edge_scan/utils/appColors.dart';
import 'package:edge_scan/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final receiptProvider = Provider.of<ReceiptProvider>(context);
    final tutorialProvider = Provider.of<TutorialProvider>(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.paddingSmall),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (receiptProvider.scannedImagePath != null)
                Container(
                  height: size.height * 0.6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Dimensions.paddingSmall,
                    ),
                    gradient: const LinearGradient(
                      colors: AppColors.blueGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      File(receiptProvider.scannedImagePath!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              else
                const SizedBox.shrink(),
              SizedBox(height: 1.h),
              CustomButton(
                key: tutorialProvider.scanButtonKey,
                text: AppLocalizations.of(context)!.scan_receipt,
                onPressed: () => receiptProvider.scanDocument(context),
                width: size.width * 0.6,
                height: size.height * 0.1,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
