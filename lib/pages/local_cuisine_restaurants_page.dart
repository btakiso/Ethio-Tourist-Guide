import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../utils/database_helper.dart'; // Importing the DatabaseHelper
import 'restaurant_detail_page.dart';
import '../utils/error_handling_util.dart'; // Importing the error handling utility

class LocalCuisineRestaurantsPage extends StatefulWidget {
  @override
  _LocalCuisineRestaurantsPageState createState() =>
      _LocalCuisineRestaurantsPageState();
}

class _LocalCuisineRestaurantsPageState
    extends State<LocalCuisineRestaurantsPage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance; // Using DatabaseHelper to fetch local cuisine restaurants

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Cuisine/Restaurants'),
      ),
      body: FutureBuilder<List<Restaurant>>(
        future: _databaseHelper.getRestaurants(), // Fetching local cuisine restaurants from DatabaseHelper
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Restaurant restaurant = snapshot.data![index];
                return ListTile(
                  leading: Image.asset('assets/images/${restaurant.imageUrl}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        debugPrint(
                            'Failed to load image: $error, StackTrace: $stackTrace');
                        return ErrorHandlingUtil.imageLoadError(context, error, stackTrace); // Utilizing the centralized error handling utility for image loading errors
                      }),
                  title: Text(restaurant.name),
                  subtitle: Text('Rating: ${restaurant.rating}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RestaurantDetailPage(
                              restaurantId: restaurant.id)),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            debugPrint('Error fetching local cuisine restaurants: ${snapshot.error}, StackTrace: ${snapshot.stackTrace}');
            return Center(child: Text('Error loading local cuisine restaurants'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}