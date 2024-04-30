import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';
import 'utils/preferences_service.dart';
import 'main.dart'; 
import 'providers/theme_provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final PreferencesService _preferencesService = PreferencesService();
  String? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _loadUserLanguage();
  }

  void _loadUserLanguage() async {
    final languageCode = await _preferencesService.getUserLanguage();
    setState(() {
      _selectedLanguage = languageCode ?? 'en';
    });
  }

  void _changeLanguage(String languageCode) async {
    await _preferencesService.setUserLanguage(languageCode);
    setState(() {
      _selectedLanguage = languageCode;
    });
    // Rebuild the entire app with the new locale
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => MyApp(locale: Locale(languageCode), initialRoute: '/welcome')),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsTitle),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.languageSetting),
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _changeLanguage(newValue);
                }
              },
              items: AppLocalizations.supportedLocales
                  .map((locale) => locale.languageCode)
                  .toSet() // Remove duplicates
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.toUpperCase()), // Display language codes in uppercase for better readability
                );
              }).toList(),
            ),
          ),
          SwitchListTile(
            title: const Text('Night Mode'),
            value: themeProvider.getTheme() == ThemeData.dark(),
            onChanged: (bool value) {
              themeProvider.setTheme(value ? ThemeData.dark() : ThemeData.light());
            },
          ),
        ],
      ),
    );
  }
}