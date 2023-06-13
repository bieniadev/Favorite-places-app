import 'dart:io';

import 'package:favorite_places/models/places.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/providers/user_places.dart'; //import provider

class AddPlaceScreen extends ConsumerStatefulWidget {
  // riverpod consumer
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState(); // riverpod consumer
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  //riverpod consumer
  final _titleContoller = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void _savePlace() {
    final enteredTitle = _titleContoller.text;

    if (enteredTitle.isEmpty || _selectedImage == null || _selectedLocation == null) {
      return;
    }

    ref.read(userPlacesProvider.notifier).addPlace(enteredTitle, _selectedImage!, _selectedLocation!); // save into the provider
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dodaj nowe miejsce')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          TextField(
            decoration: const InputDecoration(label: Text('Tytuł')),
            controller: _titleContoller,
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(height: 18),
          ImageInput(onPickImage: (image) {
            _selectedImage = image;
          }),
          const SizedBox(height: 14),
          LocationInput(
            onSelectLocation: (location) {
              _selectedLocation = location;
            },
          ),
          const SizedBox(height: 14),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            onPressed: _savePlace,
            label: const Text('Dodaj miejsce'),
          ),
        ]),
      ),
    );
  }
}
