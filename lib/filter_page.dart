import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  bool _isCategorySelected = false;
  double _minPrice = 0;
  double _maxPrice = 1000;
  double _currentRating = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Options'),
      ),
      body: ListView(
        children: [
          CheckboxListTile(
            title: Text('Category'),
            value: _isCategorySelected,
            onChanged: (bool? value) {
              setState(() {
                _isCategorySelected = value!;
              });
            },
          ),
          ListTile(
            title: Text('Price Range'),
            subtitle: RangeSlider(
              values: RangeValues(_minPrice, _maxPrice),
              min: 0,
              max: 1000,
              divisions: 20,
              labels: RangeLabels('\$${_minPrice.toInt()}', '\$${_maxPrice.toInt()}'),
              onChanged: (RangeValues values) {
                setState(() {
                  _minPrice = values.start;
                  _maxPrice = values.end;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Minimum Rating'),
            subtitle: Slider(
              value: _currentRating,
              min: 0,
              max: 5,
              divisions: 5,
              label: _currentRating.toString(),
              onChanged: (double value) {
                setState(() {
                  _currentRating = value;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Placeholder for applying filters
              Navigator.pop(context, {'category': _isCategorySelected, 'minPrice': _minPrice, 'maxPrice': _maxPrice, 'rating': _currentRating});
            },
            child: Text('Apply Filters'),
          ),
        ],
      ),
    );
  }
}