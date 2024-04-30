import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../utils/database_helper.dart';
import '../utils/error_handling_util.dart';

class MealDetailPage extends StatefulWidget {
  final int mealId;

  MealDetailPage({required this.mealId});

  @override
  _MealDetailPageState createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  late Future<Meal> _mealDetail;

  @override
  void initState() {
    super.initState();
    _mealDetail = _databaseHelper.getMealById(widget.mealId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Detail'),
      ),
      body: FutureBuilder<Meal>(
        future: _mealDetail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Meal? meal = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset('assets/images/' + meal!.imageUrl, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
                    print('Failed to load image: $error, StackTrace: $stackTrace'); // Log the entire error message and trace
                    return ErrorHandlingUtil.imageLoadError(context, error, stackTrace);
                  }),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          meal.name,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          meal.description,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${meal.calories} calories',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            print('Failed to load meal details: ${snapshot.error}, StackTrace: ${snapshot.stackTrace}'); // Log the entire error message and trace
            return ErrorHandlingUtil.futureSnapshotError(context, snapshot.error, snapshot.stackTrace);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}