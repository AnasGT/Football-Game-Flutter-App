class Player {
  final String name;
  final String position;
  final String club;
  final double price;

  Player({
    required this.name,
    required this.position,
    required this.club,
    required this.price,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'] ?? '',
      position: json['position'] ?? '',
      club: json['club'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }
}
