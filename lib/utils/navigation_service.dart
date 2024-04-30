import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> navigateTo(String routeName) async {
    navigatorKey.currentState?.pushNamed(routeName);
    await _saveRouteNameToPreferences(routeName);
  }

  Future<void> _saveRouteNameToPreferences(String routeName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastRoute', routeName);
  }

  Future<String?> getLastRouteName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('lastRoute');
  }

  Future<void> clearLastRouteName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('lastRoute');
  }

  Future<void> resetLastVisitedPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('lastRoute');
    print('Last visited page reset successfully');
  }
}