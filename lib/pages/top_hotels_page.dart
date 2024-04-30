import 'package:flutter/material.dart';
import '../models/hotel.dart';
import '../utils/mock_data_service.dart'; // Importing the MockDataService
import '../pages/hotel_detail_page.dart';
import '../utils/error_handling_util.dart'; // Importing the error handling utility

class TopHotelsPage extends StatefulWidget {
  @override
  _TopHotelsPageState createState() => _TopHotelsPageState();
}

class _TopHotelsPageState extends State<TopHotelsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Hotels'),
      ),
      body: FutureBuilder<List<Hotel>>(
        future: Future.value(MockDataService.getPopularHotels()), // Fetching popular hotels from MockDataService
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Hotel hotel = snapshot.data![index];
                return ListTile(
                  leading: Image.asset('images/${hotel.imageUrl}',
                      errorBuilder: (context, error, stackTrace) {
                        // Utilizing the centralized error handling utility for image loading errors
                        return ErrorHandlingUtil.imageLoadError(context, error, stackTrace);
                      }),
                  title: Text(hotel.name),
                  subtitle: Text('Rating: ${hotel.rating}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HotelDetailPage(hotelId: hotel.id)),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            debugPrint('Error loading top hotels: ${snapshot.error}, StackTrace: ${snapshot.stackTrace}');
            return Center(child: Text('Error loading top hotels'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}