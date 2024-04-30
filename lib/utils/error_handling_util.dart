import 'package:flutter/material.dart';

class ErrorHandlingUtil {
  static Widget imageLoadError(
      BuildContext context, Object? error, StackTrace? stackTrace) {
    // Logging the error
    debugPrint('Failed to load image: $error, StackTrace: $stackTrace');
    return Center(child: Text('Error loading image'));
  }

  static Widget futureSnapshotError(
      BuildContext context, Object? error, StackTrace? stackTrace) {
    // Logging the full error message and stack trace
    debugPrint('Error loading data: $error, StackTrace: $stackTrace');
    return Center(child: Text('Error loading data. Please try again later.'));
  }

  static void logError(String message, Object? error, StackTrace? stackTrace) {
    // Logging the error message and stack trace
    debugPrint('$message: $error, StackTrace: $stackTrace');
  }
}