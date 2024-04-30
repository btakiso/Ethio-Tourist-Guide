import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../utils/carousel_manager.dart';

class CarouselWidget extends StatefulWidget {
  final List<String> imageUrls;
  final bool autoPlay;

  const CarouselWidget({
    Key? key,
    required this.imageUrls,
    this.autoPlay = true,
  }) : super(key: key);

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final CarouselManager _carouselManager = CarouselManager();
  List<String> _availableImages = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  void _loadImages() async {
    List<String> availableImages = [];
    for (String imageUrl in widget.imageUrls) {
      bool isAvailable = await _carouselManager.isImageAvailable(imageUrl);
      if (isAvailable) {
        availableImages.add(imageUrl);
      } else {
        print('Error loading image $imageUrl'); // Log the error for failed image load
      }
    }
    setState(() {
      _availableImages = availableImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _availableImages.isNotEmpty
        ? CarouselSlider(
            items: _availableImages.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: widget.autoPlay,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
          )
        : const Center(child: Text('No images available'));
  }
}