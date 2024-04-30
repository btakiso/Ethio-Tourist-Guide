import 'package:flutter/material.dart';

class Feature {
  final String title;
  final String description;
  final IconData iconData;
  final VoidCallback onTapCallback;

  Feature({
    required this.title,
    required this.description,
    required this.iconData,
    required this.onTapCallback,
  });
}