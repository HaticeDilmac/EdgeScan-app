import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showMenuIcon;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showMenuIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shadowColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: showMenuIcon
          ? [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Navigator.pushNamed(context, '/menu');
                },
              )
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
