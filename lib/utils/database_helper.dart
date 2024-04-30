import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/destination.dart';
import '../models/hotel.dart';
import '../models/restaurant.dart';
import '../models/meal.dart'; // Importing the Meal model

class DatabaseHelper {
  static const _dbName = 'ethioTouristGuide.db';
  static const _dbVersion = 4; // Incremented the database version to trigger onCreate for existing installations
  static const _destinationTableName = 'destinations';
  static const _hotelTableName = 'hotels';
  static const _restaurantTableName = 'restaurants';
  static const _mealTableName = 'meals'; // Added table name for meals

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(path,
        version: _dbVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_destinationTableName(
        id INTEGER PRIMARY KEY,
        name TEXT,
        imageUrl TEXT,
        openingHours TEXT,
        description TEXT,
        isFavorite INTEGER,
        rating DOUBLE
      )
    ''');
    await db.execute('''
      CREATE TABLE $_hotelTableName(
        id INTEGER PRIMARY KEY,
        name TEXT,
        rating DOUBLE,
        contactInfo TEXT,
        imageUrl TEXT,
        description TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE $_restaurantTableName(
        id INTEGER PRIMARY KEY,
        name TEXT,
        rating DOUBLE,
        contactInfo TEXT,
        imageUrl TEXT,
        description TEXT
      )
    ''');
    // Create table for meals
    await db.execute('''
      CREATE TABLE $_mealTableName(
        id INTEGER PRIMARY KEY,
        name TEXT,
        description TEXT,
        imageUrl TEXT,
        calories INTEGER
      )
    ''');
    // Insert initial data into the hotels and restaurants tables
    await db.execute(
        "INSERT INTO $_hotelTableName (name, rating, contactInfo, imageUrl, description) VALUES ('Sheraton Addis', 5.0, '+251 11 517 1717', 'assets/images/sheraton_addis.jpg', 'Luxury hotel in Addis Ababa')");
    await db.execute(
        "INSERT INTO $_restaurantTableName (name, rating, contactInfo, imageUrl, description) VALUES ('Kategna Restaurant', 4.8, '+251 91 121 1148', 'assets/images/kategna_restaurant.jpg', 'Traditional Ethiopian cuisine')");
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // This will add the 'price' column if upgrading from version 3 to 4.
      if (oldVersion < 4) {
        await db.execute(
            'ALTER TABLE $_destinationTableName ADD COLUMN price REAL');
      }
    }
  }

  Future<int> addDestination(Destination destination) async {
    Database db = await database;
    return await db.insert(_destinationTableName, destination.toMap());
  }

  Future<List<Destination>> getDestinations() async {
    Database db = await database;
    var destinations = await db.query(_destinationTableName);
    List<Destination> destinationList = destinations.isNotEmpty
        ? destinations.map((c) => Destination.fromMap(c)).toList()
        : [];
    return destinationList;
  }

  Future<List<Destination>> getFilteredDestinations(
      {bool? category,
      double? minPrice,
      double? maxPrice,
      double? rating}) async {
    Database db = await database;
    String whereString = '';
    List<dynamic> whereArguments = [];
    if (rating != null) {
      whereString += 'rating >= ?';
      whereArguments.add(rating);
    }
    if (minPrice != null && maxPrice != null) {
      if (whereString.isNotEmpty) whereString += ' AND ';
      whereString += 'price BETWEEN ? AND ?';
      whereArguments.addAll([minPrice, maxPrice]);
    }
    var destinations = await db.query(
      _destinationTableName,
      where: whereString.isNotEmpty ? whereString : null,
      whereArgs: whereArguments.isNotEmpty ? whereArguments : null,
    );
    List<Destination> destinationList = destinations.isNotEmpty
        ? destinations.map((c) => Destination.fromMap(c)).toList()
        : [];
    return destinationList;
  }

  Future<void> updateFavorite(int id, bool isFavorite) async {
    Database db = await database;
    await db.update(_destinationTableName, {'isFavorite': isFavorite ? 1 : 0},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Hotel>> getHotels() async {
    Database db = await database;
    var hotels = await db.query(_hotelTableName);
    List<Hotel> hotelList =
        hotels.isNotEmpty ? hotels.map((c) => Hotel.fromMap(c)).toList() : [];
    return hotelList;
  }

  Future<List<Restaurant>> getRestaurants() async {
    Database db = await database;
    var restaurants = await db.query(_restaurantTableName);
    List<Restaurant> restaurantList = restaurants.isNotEmpty
        ? restaurants.map((c) => Restaurant.fromMap(c)).toList()
        : [];
    return restaurantList;
  }

  Future<Destination> getDestinationById(int id) async {
    Database db = await database;
    var result =
        await db.query(_destinationTableName, where: 'id = ?', whereArgs: [id]);
    return Destination.fromMap(result.first);
  }

  Future<Hotel> getHotelById(int id) async {
    Database db = await database;
    var result =
        await db.query(_hotelTableName, where: 'id = ?', whereArgs: [id]);
    return Hotel.fromMap(result.first);
  }

  Future<Restaurant> getRestaurantById(int id) async {
    Database db = await database;
    var result =
        await db.query(_restaurantTableName, where: 'id = ?', whereArgs: [id]);
    return Restaurant.fromMap(result.first);
  }

  Future<List<Destination>> getPopularDestinations() async {
    Database db = await database;
    // Assuming there's a 'popularity' column in your destinations table
    // This query fetches destinations with popularity greater than 50
    var destinations = await db.query(
      _destinationTableName,
      where: 'popularity > ?',
      whereArgs: [50],
    );
    List<Destination> destinationList = destinations.isNotEmpty
        ? destinations.map((c) => Destination.fromMap(c)).toList()
        : [];
    return destinationList;
  }

  Future<List<Meal>> getMeals() async {
    Database db = await database;
    var meals = await db.query(_mealTableName);
    List<Meal> mealList =
        meals.isNotEmpty ? meals.map((c) => Meal.fromMap(c)).toList() : [];
    return mealList;
  }

  Future<Meal> getMealById(int id) async {
    Database db = await database;
    var result = await db.query(_mealTableName, where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return Meal.fromMap(result.first);
    } else {
      throw Exception('Failed to load meal');
    }
  }

  // Add a new meal to the database
  Future<int> addMeal(Meal meal) async {
    Database db = await database;
    return await db.insert(_mealTableName, meal.toMap());
  }

  // Update an existing meal in the database
  Future<int> updateMeal(Meal meal) async {
    Database db = await database;
    return await db.update(
      _mealTableName,
      meal.toMap(),
      where: 'id = ?',
      whereArgs: [meal.id],
    );
  }

  // Delete a meal from the database
  Future<int> deleteMeal(int id) async {
    Database db = await database;
    return await db.delete(
      _mealTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Method to retrieve favorite destinations IDs
  Future<List<int>> getFavoriteDestinations() async {
    Database db = await database;
    var result = await db.query(
      _destinationTableName,
      columns: ['id'],
      where: 'isFavorite = ?',
      whereArgs: [1],
    );
    if (result.isNotEmpty) {
      return result.map<int>((map) => map['id'] as int).toList();
    } else {
      return [];
    }
  }
}