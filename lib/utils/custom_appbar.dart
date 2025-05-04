import 'package:edge_scan/providers/tutorial_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showMenuIcon;

  CustomAppBar({super.key, required this.title, this.showMenuIcon = false});

  @override
  Widget build(BuildContext context) {
    final tutorialProvider = Provider.of<TutorialProvider>(context);

    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shadowColor: Colors.transparent,
      centerTitle: true,
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
      actions:
          showMenuIcon
              ? [
                IconButton(
                  key: tutorialProvider.menuButtonKey,
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Navigator.pushNamed(context, '/menu');
                  },
                ),
              ]
              : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
