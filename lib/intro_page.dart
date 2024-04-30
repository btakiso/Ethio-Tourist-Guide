import 'package:flutter/material.dart';
import 'homepage.dart'; // Ensure this file exists for navigating to the Homepage.
import 'l10n/app_localizations.dart'; // Import localization
import 'models/feature_model.dart'; // Import the Feature model
import 'destinations_page.dart'; // Import the destination guides page
import 'map_page.dart'; // Import the interactive offline maps page
import 'hotel_restaurant_page.dart'; // Import the hotel and restaurant page
import 'ethiopian_meal_page.dart'; // Import the Ethiopian meal page

class IntroPage extends StatelessWidget {
  IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Feature> features = [
      Feature(
        title: AppLocalizations.of(context)!.exploreDestinations,
        description: AppLocalizations.of(context)!.destinationGuidesDescription,
        iconData: Icons.explore,
        onTapCallback: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DestinationsPage()),
          );
        },
      ),
      Feature(
        title: AppLocalizations.of(context)!.interactiveOfflineMaps,
        description:
            AppLocalizations.of(context)!.interactiveOfflineMapsDescription,
        iconData: Icons.map,
        onTapCallback: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MapPage()),
          );
        },
      ),
      Feature(
        title: AppLocalizations.of(context)!.hotelsRestaurants,
        description: AppLocalizations.of(context)!.hotelsRestaurants,
        iconData: Icons.restaurant,
        onTapCallback: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HotelRestaurantPage()),
          );
        },
      ),
      Feature(
        title: AppLocalizations.of(context)!.ethiopianMeal,
        description: AppLocalizations.of(context)!.ethiopianMeal,
        iconData: Icons.local_dining,
        onTapCallback: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EthiopianMealPage()),
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.introPageTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: features.length,
              itemBuilder: (context, index) {
                return FeatureTile(
                  iconData: features[index].iconData,
                  label: features[index].title,
                  description: features[index].description,
                  onTap: features[index].onTapCallback,
                );
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: ConstrainedBox(
              constraints:
                  BoxConstraints.tightFor(width: double.infinity, height: 48),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Homepage()),
                  );
                },
                child: Text(AppLocalizations.of(context)!.continueLabel),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureTile extends StatelessWidget {
  final IconData iconData;
  final String label;
  final String description;
  final VoidCallback onTap;

  const FeatureTile({
    required this.iconData,
    required this.label,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Icon(iconData, size: 24.0, color: Colors.black87),
        ),
        title: Text(label, style: TextStyle(fontSize: 20)),
        subtitle: Text(description),
        onTap: onTap,
      ),
    );
  }
}
