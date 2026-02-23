import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tmdb_assistx_app/features/home/views/home_view.dart';
import 'core/di/locator.dart';
import 'core/stores/app_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appStore = locator<AppStore>();

    return Observer(
      builder: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appStore.isDarkMode ? ThemeData.dark() : ThemeData.light(),
        home: const HomeView(),
      ),
    );
  }
}
