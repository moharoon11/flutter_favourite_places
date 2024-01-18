class Place {
  final String title;
  final String id;

  const Place({
    required this.title,
  }) : id = title + '123';
}
