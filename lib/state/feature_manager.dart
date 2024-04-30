import 'package:flutter/material.dart';
import '../models/feature.dart';

class FeatureManager with ChangeNotifier {
  final List<Feature> _features = [];

  List<Feature> get features => List.unmodifiable(_features);

  void addFeature(Feature feature) {
    _features.add(feature);
    notifyListeners();
  }
}