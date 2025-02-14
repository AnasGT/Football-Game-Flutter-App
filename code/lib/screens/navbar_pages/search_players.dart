import 'package:flutter/material.dart';
import '../../models/player.dart';
import '../../constants/app_colors.dart';
import '../../services/player_service.dart';
import '../navbar_pages/player_details_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedPosition = 'Forwards';
  Map<String, List<Player>> playersByPosition = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPlayers();
  }

  Future<void> fetchPlayers() async {
    playersByPosition = await PlayerService.getPlayersByPosition();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Available Players',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.navbarColor,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Position filter list
                Container(
                  height: 60,
                  color: AppColors.darkGreenColor,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    children: [
                      for (String position in playersByPosition.keys)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(
                              position,
                              style: TextStyle(
                                color: selectedPosition == position
                                    ? Colors.white
                                    : Colors.white70,
                              ),
                            ),
                            selected: selectedPosition == position,
                            onSelected: (bool selected) {
                              setState(() {
                                selectedPosition = position;
                              });
                            },
                            backgroundColor: AppColors.darkGreenColor,
                            selectedColor: AppColors.greenColor,
                          ),
                        ),
                    ],
                  ),
                ),
                // Players list
                Expanded(
                  child: ListView.builder(
                    itemCount: playersByPosition[selectedPosition]?.length ?? 0,
                    itemBuilder: (context, index) {
                      final player =
                          playersByPosition[selectedPosition]![index];
                      return InkWell(
                        onTap: () async {
                          final selectedPlayer = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayerDetailsPage(
                                player: player,
                              ),
                            ),
                          );
                          if (selectedPlayer != null) {
                            // Return to generate team page with selected player
                            Navigator.pop(context, selectedPlayer);
                          }
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          color: AppColors.darkGreenColor,
                          child: ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              child: player.kitImageUrl.isNotEmpty
                                  ? Image.network(
                                      player.kitImageUrl,
                                      fit: BoxFit.contain,
                                    )
                                  : Icon(Icons.person, color: Colors.white),
                            ),
                            title: Text(
                              player.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${player.position} • ${player.club} • £${player.price}M',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
