// File: lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/theme_provider.dart';
import 'welcome_page.dart';
import 'l10n/app_localizations.dart'; // Localizations for internationalization
import 'utils/db_seeder.dart'; // Import the DBSeeder
import 'destinations_page.dart';
import 'ethiopian_meal_page.dart';
import 'hotel_restaurant_page.dart';
import 'settings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure plugin services are initialized
  await DBSeeder.seedDatabase(); // Seed the database with initial data
  ThemeProvider themeProvider = ThemeProvider(ThemeData.light());
  await themeProvider.loadTheme();
  final prefs = await SharedPreferences.getInstance();
  final String lastLocale = prefs.getString('lastLocale') ?? 'en';
  final String lastRoute = prefs.getString('lastRoute') ?? '/welcome';
  runApp(ChangeNotifierProvider.value(
    value: themeProvider,
    child: MyApp(locale: Locale(lastLocale), initialRoute: lastRoute),
  ));
}

class MyApp extends StatelessWidget {
  final Locale? locale;
  final String initialRoute;

  MyApp({this.locale, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Ethio Tourist Guide',
          theme: themeProvider.getTheme().copyWith(
            primaryColor: Colors.blue,
            colorScheme: themeProvider.getTheme().colorScheme.copyWith(secondary: Colors.amber),
            appBarTheme: const AppBarTheme(
              color: Colors.blue,
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'OpenSans'),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: initialRoute,
          routes: {
            '/welcome': (context) => const WelcomePage(),
            '/destinations': (context) => DestinationsPage(),
            '/meals': (context) => EthiopianMealPage(),
            '/hotels_restaurants': (context) => HotelRestaurantPage(),
            '/settings': (context) => SettingsPage(),
            // Add other routes here as needed
          },
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: locale,
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
        );
      },
    );
  }
}