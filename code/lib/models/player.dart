class Player {
  final String name;
  final String position;
  final String club;
  final double price;
  final String? imageUrl;

  Player({
    required this.name,
    required this.position,
    required this.club,
    required this.price,
    this.imageUrl,
  });
}
