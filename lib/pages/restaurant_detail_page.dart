import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../utils/database_helper.dart';
import '../utils/error_handling_util.dart'; // Assuming this utility is implemented as per previous instructions

class RestaurantDetailPage extends StatelessWidget {
  final int restaurantId;

  RestaurantDetailPage({required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

    return FutureBuilder<Restaurant>(
      future: _databaseHelper.getRestaurantById(restaurantId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data!.name),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset('assets/images/${snapshot.data!.imageUrl}', errorBuilder: (context, error, stackTrace) {
                    debugPrint('Failed to load image: $error, StackTrace: $stackTrace');
                    return ErrorHandlingUtil.imageLoadError(context, error, stackTrace);
                  }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Rating: ${snapshot.data!.rating}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snapshot.data!.description),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          debugPrint('Error loading restaurant details: ${snapshot.error}, StackTrace: ${snapshot.stackTrace}');
          return ErrorHandlingUtil.futureSnapshotError(context, snapshot.error, snapshot.stackTrace);
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}