import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../utils/mock_data_service.dart';
import 'destination_detail_page.dart';

class TopDestinationsPage extends StatefulWidget {
  @override
  _TopDestinationsPageState createState() => _TopDestinationsPageState();
}

class _TopDestinationsPageState extends State<TopDestinationsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Top Destinations',
          style: TextStyle(
            fontSize: 24, // Making the AppBar title more prominent
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightBlue, // Setting the AppBar background color to light blue
      ),
      body: FutureBuilder<List<Destination>>(
        future: Future.value(MockDataService.getPopularDestinations()), // Fetching popular destinations from MockDataService
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Destination destination = snapshot.data![index];
                return ListTile(
                  leading: Image.asset('destination.imageUrl}',
                      errorBuilder: (context, error, stackTrace) {
                    debugPrint('Failed to load image: $error, StackTrace: $stackTrace');
                    return Icon(Icons.error);
                  }),
                  title: Text(destination.name),
                  subtitle: Text(destination.description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DestinationDetailPage(destinationId: destination.id)),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            debugPrint('Error loading top destinations: ${snapshot.error}, StackTrace: ${snapshot.stackTrace}');
            return Center(child: Text('Error loading top destinations'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
