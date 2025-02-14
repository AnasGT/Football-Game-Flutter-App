import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/player.dart';

class PlayerService {
  static Future<Map<String, List<Player>>> getPlayersByPosition() async {
    final snapshot = await FirebaseFirestore.instance.collection('clubs').get();

    final Map<String, List<Player>> playersByPosition = {};

    for (var doc in snapshot.docs) {
      final clubData = doc.data();
      final clubName = doc.id;
      final players = clubData['players'] as List<dynamic>;

      for (var playerData in players) {
        final player = Player.fromJson(playerData, clubName);
        if (!playersByPosition.containsKey(player.position)) {
          playersByPosition[player.position] = [];
        }
        playersByPosition[player.position]!.add(player);
      }
    }

    return playersByPosition;
  }
}
