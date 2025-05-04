// ignore_for_file: use_build_context_synchronously
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TutorialService {
  static Future<void> showTutorial({
    required BuildContext context,
    required String tutorialId, // esc:scan_receipt_tutorial
    required List<TargetFocus> targets,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeen = prefs.getBool('tutorial_seen_$tutorialId') ?? false;

    if (hasSeen) return;

    TutorialCoachMark tutorial = TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black.withOpacity(0.8),
      textSkip: AppLocalizations.of(context)!.skip,
      paddingFocus: 10,
      alignSkip: Alignment.topRight,
      onSkip: () {
        prefs.setBool('tutorial_seen_$tutorialId', true);
        return true;
      },
      onFinish: () {
        prefs.setBool('tutorial_seen_$tutorialId', true);
      },
    );

    tutorial.show(context: context);
  }
}
