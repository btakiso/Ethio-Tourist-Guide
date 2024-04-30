import 'package:flutter/material.dart';
import 'models/meal.dart';
import 'utils/database_helper.dart';
import 'pages/meal_detail_page.dart';
import 'widgets/shared_bottom_nav_bar.dart'; // Import the shared bottom navigation bar widget

class EthiopianMealPage extends StatefulWidget {
  @override
  _EthiopianMealPageState createState() => _EthiopianMealPageState();
}

class _EthiopianMealPageState extends State<EthiopianMealPage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ethiopian Meals'),
      ),
      body: FutureBuilder<List<Meal>>(
        future: _databaseHelper.getMeals(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Removing duplicate meals based on meal name
            var meals = snapshot.data!;
            var uniqueMeals = {for (var meal in meals) meal.name: meal}.values.toList();

            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: uniqueMeals.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    if (uniqueMeals[index].id != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MealDetailPage(mealId: uniqueMeals[index].id!),
                        ),
                      );
                    } else {
                      print('Meal ID is null, cannot navigate to MealDetailPage');
                    }
                  },
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Image.asset('assets/images/' + uniqueMeals[index].imageUrl, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
                            print('Failed to load image: $error, StackTrace: $stackTrace'); // Log the entire error message and trace
                            return Icon(Icons.error); // Show error icon if image fails to load
                          }),
                        ),
                        Text(uniqueMeals[index].name),
                        Text('${uniqueMeals[index].calories} calories'),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            print('Failed to load meals: ${snapshot.error}, StackTrace: ${snapshot.stackTrace}'); // Log the entire error message and trace
            return Center(child: Text('Failed to load meals'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: SharedBottomNavBar(selectedIndex: 1, onItemTapped: (int ) {  },), // Use the shared bottom navigation bar with the Ethiopian Meal page index
    );
  }
}