import 'package:flutter/material.dart';
import '../map_page.dart';
import '../ethiopian_meal_page.dart';
import '../hotel_restaurant_page.dart';
import '../destinations_page.dart';
import '../homepage.dart';

class SharedBottomNavBar extends StatefulWidget {
 final int selectedIndex;
 final Function(int) onItemTapped; // Add this line

 const SharedBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped, // Add this line
 }) : super(key: key);

 @override
 _SharedBottomNavBarState createState() => _SharedBottomNavBarState();
}

class _SharedBottomNavBarState extends State<SharedBottomNavBar> {
 void _selectPage(int index) {
    final List<Widget> pages = [
      MapPage(),
      EthiopianMealPage(),
      Homepage(),
      HotelRestaurantPage(),
      DestinationsPage(),
    ];

    if (index != widget.selectedIndex) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => pages[index]),
        (Route<dynamic> route) => false,
      );
    }
    widget.onItemTapped(index); // Call the onItemTapped function with the selected index
 }

 @override
 Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fastfood),
          label: 'Meals',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.hotel),
          label: 'Hotels',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Destinations',
        ),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: Colors.red[700],
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      onTap: _selectPage,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
    );
 }
}