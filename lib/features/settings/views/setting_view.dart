import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../core/di/locator.dart';
import '../../../core/stores/app_store.dart';
import '../../home/stores/home_store.dart';
import '../../movie/stores/movie_store.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  void _onLanguageChanged(String newLang) {
    final appStore = locator<AppStore>();
    appStore.setLanguage(newLang);

    locator<HomeStore>().fetchHomeData(isRefresh: true);
    locator<MovieStore>().fetchMovies(isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final appStore = locator<AppStore>();

    return Scaffold(
      appBar: AppBar(
        title: Observer(builder: (_) => Text(appStore.t['settings']!)),
      ),
      body: ListView(
        children: [
          Observer(
            builder: (_) => ExpansionTile(
              leading: const Icon(Icons.palette),
              title: Text(appStore.t['theme']!),
              subtitle: Text(appStore.isDarkMode ? 'Dark Mode' : 'Light Mode'),
              children: [
                RadioGroup<bool>(
                  groupValue: appStore.isDarkMode,
                  onChanged: (val) {
                    if (val != null) appStore.setTheme(val);
                  },
                  child: Column(
                    children: const [
                      RadioListTile<bool>(
                        title: Text('Dark Mode'),
                        value: true,
                      ),
                      RadioListTile<bool>(
                        title: Text('Light Mode'),
                        value: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),

          Observer(
            builder: (_) => ExpansionTile(
              leading: const Icon(Icons.language),
              title: Text(appStore.t['language']!),
              subtitle: Text(
                appStore.locale == 'id'
                    ? 'Bahasa'
                    : appStore.locale == 'en'
                    ? 'English'
                    : '日本語',
              ),
              children: [
                RadioGroup<String>(
                  groupValue: appStore.locale,
                  onChanged: (val) {
                    if (val != null) _onLanguageChanged(val);
                  },
                  child: Column(
                    children: const [
                      RadioListTile<String>(title: Text('Bahasa'), value: 'id'),
                      RadioListTile<String>(
                        title: Text('English'),
                        value: 'en',
                      ),
                      RadioListTile<String>(
                        title: Text('日本語 (Jepang)'),
                        value: 'ja',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
