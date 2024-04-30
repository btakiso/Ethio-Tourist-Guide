import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../utils/database_helper.dart'; // Importing the DatabaseHelper
import 'destination_detail_page.dart';
import '../utils/error_handling_util.dart'; // Importing the error handling utility

class PopularDestinationsPage extends StatefulWidget {
  @override
  _PopularDestinationsPageState createState() => _PopularDestinationsPageState();
}

class _PopularDestinationsPageState extends State<PopularDestinationsPage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance; // Using DatabaseHelper to fetch popular destinations

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Destinations'),
      ),
      body: FutureBuilder<List<Destination>>(
        future: _databaseHelper.getPopularDestinations(), // Fetching popular destinations from DatabaseHelper
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Destination destination = snapshot.data![index];
                return ListTile(
                  leading: Image.asset('assets/images/${destination.imageUrl}', fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
                    ErrorHandlingUtil.logError('Failed to load image', error, stackTrace);
                    return ErrorHandlingUtil.imageLoadError(context, error, stackTrace);
                  }),
                  title: Text(destination.name),
                  subtitle: Text(destination.description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DestinationDetailPage(destinationId: destination.id)),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            ErrorHandlingUtil.logError('Error loading popular destinations', snapshot.error!, snapshot.stackTrace!);
            return ErrorHandlingUtil.futureSnapshotError(context, snapshot.error, snapshot.stackTrace);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}