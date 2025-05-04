import 'package:edge_scan/core/tutorial_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TutorialProvider with ChangeNotifier {
  final GlobalKey _scanTabKey = GlobalKey();
  final GlobalKey _historyTabKey = GlobalKey();
  final GlobalKey _menuButtonKey = GlobalKey();
  final GlobalKey _scanButtonKey = GlobalKey();

  GlobalKey get scanTabKey => _scanTabKey;
  GlobalKey get historyTabKey => _historyTabKey;
  GlobalKey get menuButtonKey => _menuButtonKey;
  GlobalKey get scanButtonKey => _scanButtonKey;

  void showTutorial(BuildContext context) async {
    const tutorialId = "home_screen_tutorial";

    final targets = [
      TargetFocus(
        identify: "scanButton",
        keyTarget: _scanButtonKey, // Added Scan Button Key
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: Text(
              AppLocalizations.of(context)!.scanButton,
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "scanTab",
        keyTarget: _scanTabKey,
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: Text(
              AppLocalizations.of(context)!.scanTab,
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "historyTab",
        keyTarget: _historyTabKey,
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: Text(
              AppLocalizations.of(context)!.historyTab,
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "menuButton",
        keyTarget: _menuButtonKey,
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Text(
              AppLocalizations.of(context)!.menuButton,
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
          ),
        ],
      ),
    ];

    await TutorialService.showTutorial(
      context: context,
      tutorialId: tutorialId,
      targets: targets,
    );
  }
}
