import 'dart:io';

class Place {
  final String title;
  final String id;
  final File image;

  const Place({
    required this.title,
    required this.image,
  }) : id = title + '123';
}
