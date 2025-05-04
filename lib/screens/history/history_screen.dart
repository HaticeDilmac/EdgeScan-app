import 'dart:io';
import 'package:edge_scan/core/image_helper.dart';
import 'package:edge_scan/providers/history_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';
import '../../utils/appColors.dart';
import '../../utils/dimensions.dart';

class HistoricalScreen extends StatefulWidget {
  const HistoricalScreen({super.key});

  @override
  State<HistoricalScreen> createState() => _HistoricalScreenState();
}

class _HistoricalScreenState extends State<HistoricalScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final historyProvider = Provider.of<HistoryProvider>(
      context,
      listen: false,
    );
    historyProvider.loadHistory().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Consumer<HistoryProvider>(
        builder: (context, historyProvider, _) {
          final imagePaths = historyProvider.imagePaths;

          if (_isLoading) {
            return ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) => imageCardShimmer(theme),
            );
          }

          return imagePaths.isEmpty
              ? Center(
                child: Text(
                  AppLocalizations.of(context)!.noDataHistory,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )
              : ListView.builder(
                itemCount: imagePaths.length,
                itemBuilder:
                    (context, index) =>
                        imageCardMethod(context, imagePaths, index),
              );
        },
      ),
    );
  }

  Padding imageCardMethod(
    BuildContext context,
    List<String> imagePaths,
    int index,
  ) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingXExtraSmall,
        vertical: Dimensions.paddingXXExtraSmall,
      ),
      child: GestureDetector(
        onTap: () => ImageHelper.showImageAlert(context, imagePaths[index]),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              Dimensions.borderXMinRadiusSmall,
            ),
            side: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          child: Container(
            height: size.height * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Dimensions.borderXMinRadiusSmall,
              ),
              gradient: const LinearGradient(
                colors: AppColors.blueGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                Dimensions.borderXMinRadiusSmall,
              ),
              child: Padding(
                padding: EdgeInsets.all(Dimensions.paddingXXExtraSmall),
                child: Image.file(File(imagePaths[index]), fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // shşmmer card
  Padding imageCardShimmer(ThemeData theme) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingXExtraSmall,
        vertical: Dimensions.paddingXXExtraSmall,
      ),
      child: Shimmer.fromColors(
        baseColor: theme.colorScheme.surface.withOpacity(0.3),
        highlightColor: theme.colorScheme.surface.withOpacity(0.6),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              Dimensions.borderXMinRadiusSmall,
            ),
          ),
          child: Container(
            height: size.height * 0.2,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Dimensions.borderXMinRadiusSmall,
              ),
              color: theme.colorScheme.surface,
            ),
          ),
        ),
      ),
    );
  }
}
