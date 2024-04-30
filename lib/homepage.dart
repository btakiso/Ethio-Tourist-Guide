import 'package:flutter/material.dart';
import 'widgets/popular_destinations_widget.dart';
import 'widgets/top_destinations_widget.dart';
import 'package:rxdart/rxdart.dart';
import 'l10n/app_localizations.dart';
import 'utils/mock_data_service.dart';
import 'pages/hotel_detail_page.dart';
import 'pages/restaurant_detail_page.dart';
import 'widgets/shared_bottom_nav_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _searchController = TextEditingController();
  final BehaviorSubject<String> _searchSubject = BehaviorSubject<String>();
  int _selectedIndex =
      2; // Keep track of the selected index in the bottom navigation bar

  @override
  void initState() {
    super.initState();
    _searchSubject.stream
        .debounceTime(const Duration(milliseconds: 500))
        .listen((searchTerm) {
      print('Search term: $searchTerm');
      // Implement the search logic here
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchSubject.close();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.homepageTitle),
        actions: [
          IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const SizedBox(
                      height: 100,
                      child: Center(
                        child: Text("More options coming soon!"),
                      ),
                    );
                  },
                );
              }),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0), // Increased height
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                8.0, 6.0, 8.0, 10.0), // Adjusted padding
            child: TextField(
              controller: _searchController,
              onChanged: (value) => _searchSubject.add(value),
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.searchHint,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Top Destinations',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            TopDestinationsWidget(
                imageUrls: MockDataService.getTopDestinationImages(),
                autoPlay: true),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Popular Destinations',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            PopularDestinationsWidget(
                imageUrls: MockDataService.getPopularDestinationImages(),
                autoPlay: true),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Popular Hotels',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: MockDataService.getPopularHotels().length,
                itemBuilder: (context, index) {
                  final hotel = MockDataService.getPopularHotels()[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HotelDetailPage(hotelId: hotel.id)),
                      );
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Image.asset(hotel.imageUrl,
                              fit: BoxFit.cover, height: 120),
                          Text(hotel.name),
                          Text('Rating: ${hotel.rating}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Local Cuisine/Restaurants',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: MockDataService.getLocalCuisineRestaurants().length,
                itemBuilder: (context, index) {
                  final restaurant =
                      MockDataService.getLocalCuisineRestaurants()[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RestaurantDetailPage(
                                restaurantId: restaurant.id)),
                      );
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Image.asset(restaurant.imageUrl,
                              fit: BoxFit.cover, height: 120),
                          Text(restaurant.name),
                          Text('Rating: ${restaurant.rating}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SharedBottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped:
              _onItemTapped), // Use the shared bottom navigation bar with updated selectedIndex and onItemTapped
    );
  }
}
