import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart'; // Localizations for internationalization
import 'intro_page.dart'; // Navigation target page
import 'utils/preferences_service.dart'; // Service for user preferences
import 'settings_page.dart'; // Settings page for configurations

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PreferencesService _preferencesService = PreferencesService();

  @override
  void initState() {
    super.initState();
    _loadUserLanguage();
  }

  void _loadUserLanguage() async {
    String? languageCode = await _preferencesService.getUserLanguage();
    if (languageCode != null) {
      print('Loaded user language: $languageCode');
    } else {
      print('No user language saved, using default.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.getStarted),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white, // Set background color to white
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Space elements evenly
          children: <Widget>[
            Column(
              children: <Widget>[
                const SizedBox(height: 80), // Adjust space as needed
                const Text(
                  'Welcome to EthioGuide',
                  style: TextStyle(
                    fontSize: 28, // Adjust font size as needed
                    fontWeight: FontWeight.bold,
                    color: Colors
                        .black, // Set text color to black or any other color
                  ),
                ),
                Text(
                  'Discover the beauty of Ethiopia\'s breathtaking destinations.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16, // Adjust font size as needed
                    color: Colors.grey[800], // Set text color to dark grey
                  ),
                ),
              ],
            ),
            const CircleAvatar(
              radius: 150, // Adjust the size of the circle as needed
              backgroundImage: AssetImage('assets/ethiopia_landscape.jpg'),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 80), // Adjust the padding as needed
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IntroPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor:
                      const Color.fromARGB(255, 76, 175, 80), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                child: Text(AppLocalizations.of(context)!.getStarted),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
