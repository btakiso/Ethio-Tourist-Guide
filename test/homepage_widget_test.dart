import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ethio_tourist_guide/homepage.dart';
import 'package:ethio_tourist_guide/map_page.dart';
import 'package:ethio_tourist_guide/ethiopian_meal_page.dart';
import 'package:ethio_tourist_guide/hotel_restaurant_page.dart';
import 'package:provider/provider.dart';
import 'package:mockito/annotations.dart';
import 'package:ethio_tourist_guide/utils/database_helper.dart';
import 'homepage_widget_test.mocks.dart';

@GenerateMocks([DatabaseHelper])
void main() {
  group('Homepage Widget Tests', () {
    // Test tapping on the "Map" button navigates to the Map Page
    testWidgets('Navigates to Map Page on tap', (WidgetTester tester) async {
      // Mock the necessary dependencies
      MockDatabaseHelper mockDatabaseHelper = MockDatabaseHelper();

      // Provide the mock dependencies
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            Provider<DatabaseHelper>(create: (_) => mockDatabaseHelper),
          ],
          child: const MaterialApp(home: Homepage()),
        ),
      );

      // Find the BottomNavigationBar and tap on the "Map" icon
      final mapIconFinder = find.byIcon(Icons.map);
      await tester.tap(mapIconFinder);
      await tester.pumpAndSettle();

      // Verify that after tapping, we navigated to the Map Page
      expect(find.byType(MapPage), findsOneWidget);
    });

    // Test tapping on the "Ethiopian Meal" button navigates to the Ethiopian Meal Page
    testWidgets('Navigates to Ethiopian Meal Page on tap', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Homepage()));

      // Find the BottomNavigationBar and tap on the "Ethiopian Meal" icon
      final ethiopianMealIconFinder = find.byIcon(Icons.fastfood);
      await tester.tap(ethiopianMealIconFinder);
      await tester.pumpAndSettle();

      // Verify that after tapping, we navigated to the Ethiopian Meal Page
      expect(find.byType(EthiopianMealPage), findsOneWidget);
    });

    // Test tapping on the "Hotels & Restaurants" button navigates to the Hotel and Restaurant Page
    testWidgets('Navigates to Hotel and Restaurant Page on tap', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Homepage()));

      // Find the BottomNavigationBar and tap on the "Hotels & Restaurants" icon
      final hotelsRestaurantsIconFinder = find.byIcon(Icons.hotel);
      await tester.tap(hotelsRestaurantsIconFinder);
      await tester.pumpAndSettle();

      // Verify that after tapping, we navigated to the Hotel and Restaurant Page
      expect(find.byType(HotelRestaurantPage), findsOneWidget);
    });

    // Additional tests for other interactions and navigations can be added here
  });
}