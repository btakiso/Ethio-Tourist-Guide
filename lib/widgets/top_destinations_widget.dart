import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/destination.dart';
import '../utils/mock_data_service.dart';
import '../pages/destination_detail_page.dart';

class TopDestinationsWidget extends StatefulWidget {
  TopDestinationsWidget(
      {Key? key, required List<String> imageUrls, required bool autoPlay})
      : super(key: key);

  @override
  _TopDestinationsWidgetState createState() => _TopDestinationsWidgetState();
}

class _TopDestinationsWidgetState extends State<TopDestinationsWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Destination>>(
      future: Future.value(MockDataService.getPopularDestinations()),
      builder:
          (BuildContext context, AsyncSnapshot<List<Destination>> snapshot) {
        if (snapshot.hasData) {
          return CarouselSlider.builder(
            itemCount: snapshot.data!.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              Destination destination = snapshot.data![itemIndex];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DestinationDetailPage(destinationId: destination.id),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.asset(
                          destination.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            debugPrint(
                                'Failed to load image: $error, StackTrace: $stackTrace');
                            return Center(child: Icon(Icons.error));
                          },
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.7),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              destination.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: false,
              viewportFraction: 0.4,
              aspectRatio: 16 / 9,
              initialPage: 0,
            ),
          );
        } else if (snapshot.hasError) {
          debugPrint(
              'Error loading top destinations: ${snapshot.error}, StackTrace: ${snapshot.stackTrace}');
          return Center(child: Text('Error loading top destinations'));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
