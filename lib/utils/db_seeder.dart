import 'package:sqflite/sqflite.dart';
import '../models/destination.dart';
import '../models/hotel.dart';
import '../models/restaurant.dart';
import '../models/meal.dart'; 
import 'database_helper.dart';

class DBSeeder {
  static Future<void> seedDatabase() async {
    final Database db = await DatabaseHelper.instance.database;

    // Destinations Data
    final List<Destination> destinations = [
      Destination(
          id: 1,
          name: "Simien Mountains",
          imageUrl: "simien_mountains.jpg",
          openingHours: "All day",
          description: "A stunning example of Ethiopia's natural beauty.",
          isFavorite: true,
          rating: 4.5),
      // Add more destinations as needed
    ];

    // Hotels Data
    final List<Hotel> hotels = [
      Hotel(
          id: 1,
          name: "Sheraton Addis",
          rating: 5.0,
          imageUrl: "sheraton_addis.jpg",
          description: "A luxury hotel in the heart of Addis Ababa."),
      // Add more hotels as needed
    ];

    // Restaurants Data
    final List<Restaurant> restaurants = [
      Restaurant(
          id: 1,
          name: "Kategna Restaurant",
          rating: 4.8,
          imageUrl: "kategna_restaurant.jpg",
          description: "Traditional Ethiopian cuisine in a cozy setting."),
      // Add more restaurants as needed
    ];

    // Meals Data
    final List<Meal> meals = [
      Meal(
          name: 'Injera',
          description: 'A traditional Ethiopian sourdough flatbread.',
          imageUrl: 'injera.jpg',
          calories: 100,
      ),
      Meal(
          name: 'Doro Wat',
          description: 'Spicy chicken stew served with injera.',
          imageUrl: 'doro_wat.jpg',
          calories: 350,
      ),
      // Add more meals as needed
    ];

    // Insert Destinations into the Database
    for (var destination in destinations) {
      await db
          .insert('destinations', destination.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace)
          .catchError((error) {
            return -1;
      });
    }

    // Insert Hotels into the Database
    for (var hotel in hotels) {
      await db
          .insert('hotels', hotel.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace)
          .catchError((error) {
            return -1;
      });
    }

    // Insert Restaurants into the Database
    for (var restaurant in restaurants) {
      await db
          .insert('restaurants', restaurant.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace)
          .catchError((error) {
            return -1;
      });
    }

    // Insert Meals into the Database
    for (var meal in meals) {
      await db
          .insert('meals', meal.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace)
          .catchError((error) {
            return -1;
      });
    }
  }
}
