import 'package:flutter/material.dart';
import '../models/hotel.dart';
import '../pages/hotel_detail_page.dart';
import '../utils/logger_util.dart'; // Import the logger utility

class PopularHotelsWidget extends StatelessWidget {
  final List<Hotel> hotels;

  const PopularHotelsWidget({
    Key? key,
    required this.hotels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          final hotel = hotels[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HotelDetailPage(hotelId: hotel.id)),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Image.asset(hotel.imageUrl, fit: BoxFit.cover, height: 120,
                      errorBuilder: (context, error, stackTrace) {
                    LoggerUtil.logError('Failed to load hotel image',
                        error: error,
                        stackTrace:
                            stackTrace); // Log the entire error message and trace
                    return Icon(
                        Icons.error); // Show error icon if image fails to load
                  }),
                  Text(hotel.name),
                  Text('Rating: ${hotel.rating}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
