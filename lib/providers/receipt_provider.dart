// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';
import 'package:edge_scan/common/custom_button.dart';
import 'package:edge_scan/providers/history_provider.dart';
import 'package:edge_scan/utils/dimensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_gallery_saver/flutter_image_gallery_saver.dart';
// import 'package:gallery_saver/gallery_saver.dart';
import 'package:image/image.dart' as img;
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

class ReceiptProvider extends ChangeNotifier {
  String? _scannedImagePath;
  String? get scannedImagePath => _scannedImagePath;

  Future<void> scanDocument(BuildContext context) async {
    try {
      var status = await Permission.camera.status;

      if (status.isGranted) {
        //If you are given a job scan it
        await _startScanning(context);
      } else if (status.isDenied) {
        //The user previoesly declined but did not say dont show again
        final newStatus = await Permission.camera.request();

        if (newStatus.isGranted) {
          //if permission isGranted then startScan
          await _startScanning(context);
        } else {
          //else permission isnot successfuly show permission dialog
          _showPermissionDialog(context);
        }
      } else if (status.isPermanentlyDenied || status.isRestricted) {
        // If it is completely blocked, it will still give you the permission alert.
        _showPermissionDialog(context);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> requestStoragePermission() async {
    if (await Permission.photos.request().isGranted ||
        await Permission.storage.request().isGranted) {
    } else {
      openAppSettings();
    }
  }

  Future<void> _startScanning(BuildContext context) async {
    final List<String>? scanPictures =
        await CunningDocumentScanner.getPictures(); //document scan

    if (scanPictures != null && scanPictures.isNotEmpty) {
      final imagePath = scanPictures.first;
      bool isBlurred = await _checkBlur(File(imagePath));

      if (isBlurred) {
        //isBlur control
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.photoNotClear)),
        );
        return;
      }

      _scannedImagePath = imagePath;
      notifyListeners();

      final historyProvider = Provider.of<HistoryProvider>(
        context,
        listen: false,
      );
      await historyProvider.saveHistory(imagePath); //save history list

      await requestStoragePermission(); //gallerry permission
      final file = File(_scannedImagePath!);
      final Uint8List imageBytes = await file.readAsBytes();
      await FlutterImageGallerySaver.saveImage(imageBytes); //save galleery
      // user show message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.savedSuccessfully),
        ),
      );
    }
  }

  void _showPermissionDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                Dimensions.borderXMinRadiusSmall,
              ), // Köşe yuvarlama
            ),
            alignment: Alignment.center,
            title: Text(
              AppLocalizations.of(context)!.cameraPermissionTitle,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            content: Text(
              AppLocalizations.of(context)!.cameraPermissionMessage,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            actionsPadding: const EdgeInsets.only(
              bottom: 12,
              right: 16,
              left: 16,
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: CustomButton(
                      text: AppLocalizations.of(context)!.cancel,
                      style: Theme.of(context).textTheme.bodySmall,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Expanded(
                    child: CustomButton(
                      text: AppLocalizations.of(context)!.openSettings,
                      style: Theme.of(context).textTheme.bodySmall,
                      onPressed: () {
                        Navigator.pop(context);
                        openAppSettings();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
    );
  }

  Future<bool> _checkBlur(File imageFile) async {
    try {
      final bytes =
          await imageFile.readAsBytes(); //image to byte format  convert
      final decoded = img.decodeImage(bytes);

      if (decoded == null) return true;
      //calculates the brightness (grayscale) variability in the şnmg
      double variance = _calculateImageVariance(decoded);

      //Experimental threshold: count as fuzzy if less than 500
      return variance < 500;
    } catch (e) {
      return true;
    }
  }

  //The brightness variable of the image is calculated, if the brightness part is low, it should be ensured that an error is given.
  double _calculateImageVariance(img.Image image) {
    List<int> grayscale = [];

    for (var y = 0; y < image.height; y++) {
      for (var x = 0; x < image.width; x++) {
        final pixel = image.getPixel(x, y); // returns Pixel
        final r = pixel.r;
        final g = pixel.g;
        final b = pixel.b;

        final gray = ((r + g + b) / 3).round();
        grayscale.add(gray);
      }
    }

    final mean = grayscale.reduce((a, b) => a + b) / grayscale.length;
    final variance =
        grayscale.map((g) => (g - mean) * (g - mean)).reduce((a, b) => a + b) /
        grayscale.length;

    return variance;
  }
}
