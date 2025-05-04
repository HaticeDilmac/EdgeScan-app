import 'package:edge_scan/providers/tutorial_provider.dart';
import 'package:edge_scan/screens/history/history_screen.dart';
import 'package:edge_scan/screens/receipt/receipt_screen.dart';
import 'package:edge_scan/utils/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  //bottom screen widget list
  final List<Widget> _pages = [const ReceiptScreen(), const HistoricalScreen()];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // syhow tutorial
      Provider.of<TutorialProvider>(
        context,
        listen: false,
      ).showTutorial(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tutorialProvider = Provider.of<TutorialProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(title: 'EdgeScan', showMenuIcon: true),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            key: tutorialProvider.scanTabKey,
            icon: const Icon(Icons.document_scanner),
            label: AppLocalizations.of(context)!.scan,
          ),
          BottomNavigationBarItem(
            key: tutorialProvider.historyTabKey,
            icon: const Icon(Icons.history),
            label: AppLocalizations.of(context)!.history,
          ),
        ],
      ),
    );
  }
}
