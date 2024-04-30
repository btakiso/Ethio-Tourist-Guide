import 'package:flutter/material.dart';
import '../models/hotel.dart';
import '../utils/database_helper.dart';
import '../utils/error_handling_util.dart'; // Importing the error handling utility

class HotelDetailPage extends StatelessWidget {
  final int hotelId;

  HotelDetailPage({required this.hotelId});

  @override
  Widget build(BuildContext context) {
    final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

    return FutureBuilder<Hotel>(
      future: _databaseHelper.getHotelById(hotelId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data!.name),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset('assets/images/${snapshot.data!.imageUrl}',
                      errorBuilder: (context, error, stackTrace) {
                    // Utilizing the centralized error handling utility for image loading errors
                    return ErrorHandlingUtil.imageLoadError(
                        context, error, stackTrace);
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
          // Utilizing the centralized error handling utility for snapshot errors
          ErrorHandlingUtil.logError('Error loading hotel details',
              snapshot.error!, snapshot.stackTrace!);
          return ErrorHandlingUtil.futureSnapshotError(
              context, snapshot.error!, snapshot.stackTrace!);
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}