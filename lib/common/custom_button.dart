import 'package:edge_scan/utils/appColors.dart';
import 'package:edge_scan/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  TextStyle? style;
  CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.backgroundColor,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: size.height * 0.07,
        width: size.width * 0.45,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: AppColors.blueGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(Dimensions.borderXMinRadiusSmall),
          color: backgroundColor ?? Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Text(
            text,
            style: style ?? Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
