import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../utils/database_helper.dart';
import '../utils/error_handling_util.dart'; // Importing the error handling utility

class DestinationDetailPage extends StatelessWidget {
  final int destinationId;

  DestinationDetailPage({required this.destinationId});

  @override
  Widget build(BuildContext context) {
    final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

    return FutureBuilder<Destination>(
      future: _databaseHelper.getDestinationById(destinationId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data!.name),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset("assets/images/${snapshot.data!.imageUrl}", errorBuilder: (context, error, stackTrace) {
                    debugPrint('Failed to load image: $error, StackTrace: $stackTrace');
                    return ErrorHandlingUtil.imageLoadError(context, error, stackTrace);
                  }),
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