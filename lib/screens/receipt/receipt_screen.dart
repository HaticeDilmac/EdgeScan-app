// // // // // import 'dart:io';
// // // // // import 'package:camera/camera.dart';
// // // // // import 'package:edge_scan/providers/history_provider.dart';
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:gallery_saver/gallery_saver.dart';
// // // // // import 'package:permission_handler/permission_handler.dart';
// // // // // import 'package:provider/provider.dart';
// // // // // import 'package:shared_preferences/shared_preferences.dart';

// // // // // class ReceiptScreen extends StatefulWidget {
// // // // //   const ReceiptScreen({super.key});

// // // // //   @override
// // // // //   State<ReceiptScreen> createState() => _ReceiptScreenState();
// // // // // }

// // // // // class _ReceiptScreenState extends State<ReceiptScreen> {
// // // // //   CameraController? _controller;
// // // // //   bool _isCameraInitialized = false;
// // // // //   late List<CameraDescription> _cameras;
// // // // //   bool _isEdgeDetected = false;
// // // // //   String? _capturedImagePath;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _initializeCamera();
// // // // //   }

// // // // //   Future<void> _initializeCamera() async {
// // // // //     await Permission.camera.request();
// // // // //     _cameras = await availableCameras();
// // // // //     _controller = CameraController(_cameras[0], ResolutionPreset.medium);
// // // // //     await _controller!.initialize();
// // // // //     setState(() {
// // // // //       _isCameraInitialized = true;
// // // // //     });
// // // // //   }

// // // // //   Future<void> _captureImage() async {
// // // // //     if (_controller != null && _controller!.value.isInitialized) {
// // // // //       final file = await _controller!.takePicture();

// // // // //       // Simüle kenar algılama: %50 şansla başarılı
// // // // //       bool simulatedDetection = DateTime.now().second % 2 == 0;

// // // // //       if (!simulatedDetection) {
// // // // //         setState(() {
// // // // //           _isEdgeDetected = false;
// // // // //         });
// // // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // // //           const SnackBar(
// // // // //               content: Text("Fişi hizalayın, kenarlar algılanamadı.")),
// // // // //         );
// // // // //       } else {
// // // // //         setState(() {
// // // // //           _isEdgeDetected = true;
// // // // //           _capturedImagePath = file.path;
// // // // //         });
// // // // //       }
// // // // //     }
// // // // //   }

// // // // //   Future<void> _saveImage() async {
// // // // //     final historyProvider =
// // // // //         Provider.of<HistoryProvider>(context, listen: false);
// // // // //     if (_capturedImagePath != null) {
// // // // //       bool? success =
// // // // //           await GallerySaver.saveImage(_capturedImagePath!); //save to galleryy
// // // // //       if (success ?? true) {
// // // // //         await historyProvider.saveHistory(_capturedImagePath!);
// // // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // // //           const SnackBar(content: Text("Fotoğraf galeriye kaydedildi.")),
// // // // //         );
// // // // //       }
// // // // //     }
// // // // //   }

// // // // //   @override
// // // // //   void dispose() {
// // // // //     _controller?.dispose();
// // // // //     super.dispose();
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(title: const Text('Fiş Tara')),
// // // // //       body: _isCameraInitialized
// // // // //           ? Stack(
// // // // //               children: [
// // // // //                 CameraPreview(_controller!),
// // // // //                 Center(
// // // // //                   child: Container(
// // // // //                     width: 250,
// // // // //                     height: 150,
// // // // //                     decoration: BoxDecoration(
// // // // //                       border: Border.all(
// // // // //                           color: _isEdgeDetected ? Colors.green : Colors.red,
// // // // //                           width: 2),
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //                 // if (_capturedImagePath != null && _isEdgeDetected)
// // // // //                 //   Align(
// // // // //                 //     alignment: Alignment.bottomCenter,
// // // // //                 //     child: ElevatedButton.icon(
// // // // //                 //       onPressed: _saveImage,
// // // // //                 //       icon: const Icon(Icons.save),
// // // // //                 //       label: const Text("Kaydet"),
// // // // //                 //     ),
// // // // //                 //   ),
// // // // //                 if (_capturedImagePath != null && _isEdgeDetected)
// // // // //                   Align(
// // // // //                     alignment: Alignment.bottomCenter,
// // // // //                     child: Row(
// // // // //                       mainAxisAlignment: MainAxisAlignment.center,
// // // // //                       children: [
// // // // //                         ElevatedButton.icon(
// // // // //                           onPressed: _saveImage,
// // // // //                           icon: const Icon(Icons.save),
// // // // //                           label: const Text("Kaydet"),
// // // // //                         ),
// // // // //                         const SizedBox(width: 16), // Butonlar arası boşluk
// // // // //                         ElevatedButton.icon(
// // // // //                           onPressed: () {
// // // // //                             Navigator.pushNamed(context,
// // // // //                                 '/history_screen'); // Rota ile yönlendirme
// // // // //                           },
// // // // //                           icon: const Icon(Icons.arrow_forward),
// // // // //                           label: const Text("İleri"),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                   ),

// // // // //                 Positioned(
// // // // //                   bottom: 30,
// // // // //                   left: MediaQuery.of(context).size.width / 2 - 30,
// // // // //                   child: FloatingActionButton(
// // // // //                     onPressed: _captureImage,
// // // // //                     child: const Icon(Icons.camera),
// // // // //                   ),
// // // // //                 ),
// // // // //               ],
// // // // //             )
// // // // //           : const Center(child: CircularProgressIndicator()),
// // // // //     );
// // // // //   }
// // // // // }
// // // // import 'dart:io';
// // // // import 'package:edge_scan/utils/dimensions.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:provider/provider.dart';
// // // // import 'package:gallery_saver/gallery_saver.dart';
// // // // import 'package:cunning_document_scanner/cunning_document_scanner.dart';
// // // // import 'package:edge_scan/providers/history_provider.dart';
// // // // import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// // // // class ReceiptScreen extends StatefulWidget {
// // // //   const ReceiptScreen({super.key});

// // // //   @override
// // // //   State<ReceiptScreen> createState() => _ReceiptScreenState();
// // // // }

// // // // class _ReceiptScreenState extends State<ReceiptScreen> {
// // // //   String? _scannedImagePath;

// // // //   Future<void> _scanDocument() async {
// // // //     try {
// // // //       final List<String>? scanPictures =
// // // //           await CunningDocumentScanner.getPictures();
// // // //       if (scanPictures != null && scanPictures.isNotEmpty) {
// // // //         final imagePath = scanPictures.first; //first image set imagePath
// // // //         setState(() {
// // // //           _scannedImagePath = imagePath;
// // // //         });

// // // //         await GallerySaver.saveImage(imagePath); //save to gallery - imagepath

// // // //         final historyProvider =
// // // //             Provider.of<HistoryProvider>(context, listen: false);
// // // //         await historyProvider.saveHistory(imagePath);

// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           const SnackBar(content: Text("Taranmış fiş kaydedildi.")),
// // // //         );
// // // //       }
// // // //     } catch (e) {
// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         SnackBar(content: Text("Tarama sırasında hata oluştu: $e")),
// // // //       );
// // // //     }
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       // appBar: AppBar(title: Text(AppLocalizations.of(context)!.scan_receipt)),
// // // //       body: Center(
// // // //         child: Column(
// // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // //           children: [
// // // //             if (_scannedImagePath != null)
// // // //               Container(
// // // //                 decoration: BoxDecoration(border: Border.all()),
// // // //                 height: size.height * 0.7,
// // // //                 width: double.infinity,
// // // //                 child: Padding(
// // // //                   padding: const EdgeInsets.all(16.0),
// // // //                   child: Image.file(File(_scannedImagePath!)),
// // // //                 ),
// // // //               ),
// // // //             ElevatedButton.icon(
// // // //               onPressed: _scanDocument,
// // // //               icon: const Icon(Icons.document_scanner),
// // // //               label: const Text("Fişi Tara"),
// // // //             ),
// // // //             const SizedBox(height: 10),
// // // //             // ElevatedButton.icon(
// // // //             //   onPressed: () {
// // // //             //     Navigator.pushNamed(context, '/history_screen');
// // // //             //   },
// // // //             //   icon: const Icon(Icons.history),
// // // //             //   label: const Text("Geçmişe Git"),
// // // //             // ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // // import 'dart:io';
// // // import 'package:edge_scan/common/custom_button.dart';
// // // import 'package:edge_scan/providers/receipt_provider.dart';
// // // import 'package:edge_scan/utils/appColors.dart';
// // // import 'package:edge_scan/utils/dimensions.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// // // import 'package:sizer/sizer.dart';

// // // class ReceiptScreen extends StatefulWidget {
// // //   const ReceiptScreen({super.key});

// // //   @override
// // //   State<ReceiptScreen> createState() => _ReceiptScreenState();
// // // }

// // // class _ReceiptScreenState extends State<ReceiptScreen> {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final size = MediaQuery.of(context).size;
// // //     final receiptProvider = Provider.of<ReceiptProvider>(context);
// // //     return Scaffold(
// // //       body: Center(
// // //         child: Padding(
// // //           padding: EdgeInsets.all(Dimensions.paddingSmall),
// // //           child: Column(
// // //             mainAxisAlignment: MainAxisAlignment.center,
// // //             children: [
// // //               if (receiptProvider.scannedImagePath != null)
// // //                 Container(
// // //                   height: size.height * 0.6,
// // //                   width: double.infinity,
// // //                   decoration: BoxDecoration(
// // //                     borderRadius: BorderRadius.circular(
// // //                       Dimensions.paddingSmall,
// // //                     ),
// // //                     gradient: const LinearGradient(
// // //                       colors: AppColors.blueGradient,
// // //                       begin: Alignment.topLeft,
// // //                       end: Alignment.bottomRight,
// // //                     ),
// // //                     boxShadow: [
// // //                       BoxShadow(
// // //                         color: Colors.black.withOpacity(0.2),
// // //                         blurRadius: 8,
// // //                         offset: const Offset(0, 4),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   child: ClipRRect(
// // //                     borderRadius: BorderRadius.circular(16),
// // //                     child: Image.file(
// // //                       File(receiptProvider.scannedImagePath!),
// // //                       fit: BoxFit.cover,
// // //                     ),
// // //                   ),
// // //                 )
// // //               else
// // //                 const SizedBox.shrink(),
// // //               SizedBox(height: 1.h),
// // //               CustomButton(
// // //                 text: AppLocalizations.of(context)!.scan_receipt,
// // //                 onPressed: () => receiptProvider.scanDocument(context),
// // //                 width: size.width * 0.6,
// // //                 height: size.height * 0.1,
// // //               ),
// // //               const SizedBox(height: 10),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
import 'dart:io';
import 'package:edge_scan/common/custom_button.dart';
import 'package:edge_scan/core/tutorial_service.dart';
import 'package:edge_scan/providers/receipt_provider.dart';
import 'package:edge_scan/providers/tutorial_provider.dart';
import 'package:edge_scan/utils/appColors.dart';
import 'package:edge_scan/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

// class ReceiptScreen extends StatefulWidget {
//   const ReceiptScreen({super.key});

//   @override
//   State<ReceiptScreen> createState() => _ReceiptScreenState();
// }

// class _ReceiptScreenState extends State<ReceiptScreen> {
//   final GlobalKey _scanButtonKey = GlobalKey();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _showTutorial();
//     });
//   }

//   void _showTutorial() async {
//     const tutorialId = "scan_receipt_tutorial";
//     final targets = [
//       TargetFocus(
//         identify: "scanButton",
//         keyTarget: _scanButtonKey,
//         shape: ShapeLightFocus.Circle,
//         contents: [
//           TargetContent(
//             align: ContentAlign.bottom,
//             child: Text(
//               AppLocalizations.of(context)!.scan_receipt,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     ];

//     await TutorialService.showTutorial(
//       //from tutorialCoachService showTutorialFunction
//       context: context,
//       tutorialId: tutorialId,
//       targets: targets,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final receiptProvider = Provider.of<ReceiptProvider>(context);

//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(Dimensions.paddingSmall),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (receiptProvider.scannedImagePath != null)
//                 Container(
//                   height: size.height * 0.6,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(
//                       Dimensions.paddingSmall,
//                     ),
//                     gradient: const LinearGradient(
//                       colors: AppColors.blueGradient,
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         blurRadius: 8,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(16),
//                     child: Image.file(
//                       File(receiptProvider.scannedImagePath!),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 )
//               else
//                 const SizedBox.shrink(),
//               SizedBox(height: 1.h),
//               CustomButton(
//                 key: _scanButtonKey,
//                 text: AppLocalizations.of(context)!.scan_receipt,
//                 onPressed: () => receiptProvider.scanDocument(context),
//                 width: size.width * 0.6,
//                 height: size.height * 0.1,
//               ),
//               const SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
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
