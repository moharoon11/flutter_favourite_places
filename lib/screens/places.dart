import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/model/place.dart';
import 'package:places/provider/places_provider.dart';
import 'package:places/screens/add_place.dart';
import 'package:places/screens/places_details.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Place> places = ref.watch(placesProvider);

    Widget content = const Center(
      child: Text(
        'Add places to visit',
      ),
    );

    if (places.isNotEmpty) {
      content = ListView.builder(
          itemCount: places.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: ValueKey(places[index].id),
              onDismissed: (direction) {},
              child: ListTile(
                title: Text(
                  places[index].title,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          PlaceDetailScreen(place: places[index]),
                    ),
                  );
                },
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Places',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddPlaceScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: content,
    );
  }
}
