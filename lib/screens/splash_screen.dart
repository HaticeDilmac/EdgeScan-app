import 'package:edge_scan/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/home_screen');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final logoAsset =
        Theme.of(context).brightness == Brightness.dark
            ? 'assets/logo/lightIcon.png'
            : 'assets/logo/appIcon.png';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.darkBlue.withOpacity(0.6),
                      blurRadius: 35,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Image.asset(
                  logoAsset,
                  width: size.width * 0.3,
                  height: size.height * 0.15,
                ),
              ),
              SizedBox(height: 1.h),
              Text('EdgeScan', style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 0.5.h),
              Text(
                AppLocalizations.of(context)!.scanningDocument,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
