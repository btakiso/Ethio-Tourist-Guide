import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../pages/meal_detail_page.dart';
import '../utils/database_helper.dart';

class MealsWidget extends StatefulWidget {
  @override
  _MealsWidgetState createState() => _MealsWidgetState();
}

class _MealsWidgetState extends State<MealsWidget> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Meal>>(
      future: _databaseHelper.getMeals(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Meal meal = snapshot.data![index];
              return ListTile(
                leading: Image.asset(meal.imageUrl, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
                  debugPrint('Failed to load image: $error');
                  return Text('Image not available'); // Provide a more actionable feedback
                }),
                title: Text(meal.name),
                subtitle: Text('${meal.calories} calories'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MealDetailPage(mealId: meal.id!)), // Implement navigation to MealDetailPage
                  );
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          debugPrint('Error fetching meals: ${snapshot.error}');
          return Center(child: Text('Error fetching meals. Please try again later.')); // Provide a more actionable feedback
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
