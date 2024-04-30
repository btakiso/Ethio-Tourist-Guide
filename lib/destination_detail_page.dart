import 'package:flutter/material.dart';
import 'utils/database_helper.dart';
import 'models/destination.dart';

class DestinationDetailPage extends StatefulWidget {
  final int destinationId;

  DestinationDetailPage({required this.destinationId});

  @override
  _DestinationDetailPageState createState() => _DestinationDetailPageState();
}

class _DestinationDetailPageState extends State<DestinationDetailPage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  Destination? _destination;

  @override
  void initState() {
    super.initState();
    _loadDestinationDetails();
  }

  void _loadDestinationDetails() async {
    try {
      final destination = await _databaseHelper.getDestinationById(widget.destinationId);
      setState(() {
        _destination = destination;
      });
        } catch (e, stackTrace) {
      print('Error loading destination details: $e');
      print(stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_destination?.name ?? 'Destination Detail'),
      ),
      body: _destination == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  _destination!.imageUrl.isNotEmpty
                      ? Image.asset('assets/images/${_destination!.imageUrl}')
                      : const SizedBox(height: 200, child: Placeholder()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _destination!.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _destination!.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Opening Hours: ${_destination!.openingHours}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}