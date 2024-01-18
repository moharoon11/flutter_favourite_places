import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/model/place.dart';

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super([]);

  void addPlace(String title) {
    final newPlace = Place(title: title);
    state = [...state, newPlace];
  }
}

final placesProvider =
    StateNotifierProvider<PlacesNotifier, List<Place>>((ref) {
  return PlacesNotifier();
});
