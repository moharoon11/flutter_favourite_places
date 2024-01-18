import 'package:flutter/material.dart';

import 'package:location/location.dart';

class LoacationInput extends StatefulWidget {
  const LoacationInput({super.key});

  @override
  State<LoacationInput> createState() => _LoacationInputState();
}

class _LoacationInputState extends State<LoacationInput> {
  Location? isPickedLocation;
  bool isGettingLocation = false;

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      isGettingLocation = true;
    });

    locationData = await location.getLocation();

    setState(() {
      isGettingLocation = false;
    });

    print("=============================================================");
    print(locationData.altitude);
    print(locationData.latitude);
    print("=============================================================");
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = const Text(
      'No Location selected',
      style: TextStyle(
        color: Colors.white,
      ),
    );

    if (isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            child: previewContent),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    width: 0.8, color: Colors.white.withOpacity(0.5)),
              ),
              child: TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.location_on),
                label: const Text(
                  'Get current location',
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map),
                label: const Text(
                  'Select Location',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
