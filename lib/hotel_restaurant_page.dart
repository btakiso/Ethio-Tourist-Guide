import 'package:flutter/material.dart';
import 'models/hotel.dart';
import 'models/restaurant.dart';
import 'utils/database_helper.dart';
import 'filter_page.dart'; 
import 'pages/hotel_detail_page.dart';
import 'pages/restaurant_detail_page.dart';
import 'widgets/shared_bottom_nav_bar.dart'; 

class HotelRestaurantPage extends StatefulWidget {
  @override
  _HotelRestaurantPageState createState() => _HotelRestaurantPageState();
}

class _HotelRestaurantPageState extends State<HotelRestaurantPage>
    with SingleTickerProviderStateMixin {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels and Restaurants'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Hotels'),
            Tab(text: 'Restaurants'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FilterPage()),
              );
              if (result != null) {
                setState(() {
                  // Assuming you will handle the filter result to update the list
                  // Update the state with the filter results
                });
              }
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildHotelList(),
          _buildRestaurantList(),
        ],
      ),
      bottomNavigationBar: SharedBottomNavBar(selectedIndex: 3, onItemTapped: (int ) {  },), 
    );
  }

  Widget _buildHotelList() {
    return FutureBuilder<List<Hotel>>(
      future: _dbHelper.getHotels(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final hotel = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HotelDetailPage(hotelId: hotel.id)),
                  );
                },
                child: ListTile(
                  leading: Image.asset('assets/images/${hotel.imageUrl}', width: 100, height: 100, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
                    print('Error loading hotel image: $error');
                    return Icon(Icons.error);
                  }),
                  title: Text(hotel.name),
                  subtitle: Text('Rating: ${hotel.rating}'),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          print('Error fetching hotels: ${snapshot.error}');
          return Center(child: Text('Error fetching hotels'));
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildRestaurantList() {
    return FutureBuilder<List<Restaurant>>(
      future: _dbHelper.getRestaurants(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final restaurant = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RestaurantDetailPage(restaurantId: restaurant.id)),
                  );
                },
                child: ListTile(
                  leading: Image.asset('assets/images/${restaurant.imageUrl}', width: 100, height: 100, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
                    print('Error loading restaurant image: $error');
                    return Icon(Icons.error);
                  }),
                  title: Text(restaurant.name),
                  subtitle: Text('Rating: ${restaurant.rating}'),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          print('Error fetching restaurants: ${snapshot.error}');
          return Center(child: Text('Error fetching restaurants'));
        }
        return CircularProgressIndicator();
      },
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}