import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future<void> setUserLanguage(String languageCode) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('userLanguage', languageCode);
    debugPrint('User language set to $languageCode');
  }

  Future<String?> getUserLanguage() async {
    final preferences = await SharedPreferences.getInstance();
    String? languageCode = preferences.getString('userLanguage');
    debugPrint('Retrieved user language: $languageCode');
    return languageCode;
  }

  Future<void> setFavoriteDestinations(List<String> destinations) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setStringList('favoriteDestinations', destinations);
    debugPrint('Favorite destinations updated.');
  }

  Future<List<String>?> getFavoriteDestinations() async {
    final preferences = await SharedPreferences.getInstance();
    List<String>? favorites = preferences.getStringList('favoriteDestinations');
    debugPrint('Retrieved favorite destinations.');
    return favorites;
  }

  Future<void> savePersonalizedItinerary(List<String> itinerary) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setStringList('personalizedItinerary', itinerary);
    debugPrint('Personalized itinerary saved.');
  }

  Future<List<String>?> getPersonalizedItinerary() async {
    final preferences = await SharedPreferences.getInstance();
    List<String>? itinerary = preferences.getStringList('personalizedItinerary');
    debugPrint('Retrieved personalized itinerary.');
    return itinerary;
  }

  Future<void> saveThemeMode(ThemeMode themeMode) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('themeMode', themeMode.toString());
    debugPrint('Theme mode saved: ${themeMode.toString()}');
  }

  Future<ThemeMode> getThemeMode() async {
    final preferences = await SharedPreferences.getInstance();
    String? themeModeString = preferences.getString('themeMode');
    debugPrint('Retrieved theme mode: $themeModeString');
    return themeModeString == 'ThemeMode.dark' ? ThemeMode.dark : ThemeMode.light;
  }
}