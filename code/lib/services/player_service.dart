import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/player.dart';

class PlayerService {
  static Future<Map<String, List<Player>>> getPlayersByPosition() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('clubs')
        .doc('Association sportive olympique de Chlef - ASOC')
        .get();

    final Map<String, List<Player>> playersByPosition = {};
    final clubData = snapshot.data();

    if (clubData != null) {
      final players = clubData['players'] as List<dynamic>;
      for (var playerData in players) {
        final player = Player.fromJson(playerData);
        if (!playersByPosition.containsKey(player.position)) {
          playersByPosition[player.position] = [];
        }
        playersByPosition[player.position]!.add(player);
      }
    }

    return playersByPosition;
  }
}
