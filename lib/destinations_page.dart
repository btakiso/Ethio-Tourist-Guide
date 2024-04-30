import 'package:flutter/material.dart';
import 'dart:convert'; // For encoding and decoding JSON
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import 'models/destination.dart';
import 'utils/database_helper.dart';
import 'destination_detail_page.dart';
import 'widgets/shared_bottom_nav_bar.dart';

class DestinationsPage extends StatefulWidget {
  @override
  _DestinationsPageState createState() => _DestinationsPageState();
}

class _DestinationsPageState extends State<DestinationsPage> {
  final _databaseHelper = DatabaseHelper.instance;
  List<int> _favoriteIds = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String favoriteDestinationsString = prefs.getString('favoriteDestinations') ?? '[]';
    setState(() {
      _favoriteIds = List<int>.from(jsonDecode(favoriteDestinationsString));
    });
  }

  void _updateFavorite(int destinationId, bool isFavorite) async {
    final prefs = await SharedPreferences.getInstance();
    if (isFavorite) {
      if (!_favoriteIds.contains(destinationId)) {
        _favoriteIds.add(destinationId);
      }
    } else {
      _favoriteIds.remove(destinationId);
    }
    await prefs.setString('favoriteDestinations', jsonEncode(_favoriteIds));
    _databaseHelper.updateFavorite(destinationId, isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Destinations'),
      ),
      body: FutureBuilder<List<Destination>>(
        future: _databaseHelper.getDestinations(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Destination destination = snapshot.data![index];
                bool isFavorite = _favoriteIds.contains(destination.id);
                return ListTile(
                  leading: Image.asset('assets/images/${destination.imageUrl}'),
                  title: Text(destination.name),
                  subtitle: Text(destination.openingHours),
                  trailing: IconButton(
                    icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                    color: Colors.red,
                    onPressed: () {
                      bool newFavoriteStatus = !isFavorite;
                      setState(() {
                        destination.isFavorite = newFavoriteStatus;
                      });
                      _updateFavorite(destination.id, newFavoriteStatus);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DestinationDetailPage(destinationId: destination.id),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return CircularProgressIndicator();
        },
      ),
      bottomNavigationBar: SharedBottomNavBar(selectedIndex: 4, onItemTapped: (int) {}), // Use the shared bottom navigation bar with the Destinations page index
    );
  }
}