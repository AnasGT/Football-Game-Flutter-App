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

  factory Player.fromJson(Map<String, dynamic> json, String clubName) {
    return Player(
      name: json['name'] ?? '',
      position: json['position'] ?? '',
      club: clubName,
      price: (json['price'] ?? 0).toDouble(),
    );
  }
}
