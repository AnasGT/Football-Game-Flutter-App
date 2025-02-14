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
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayerDetailsPage(
                                player: player,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          color: AppColors.darkGreenColor,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          player.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        player.position,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        player.club,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '£${player.price}M',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                if (player.kitImageUrl.isNotEmpty)
                                  Image.network(
                                    player.kitImageUrl,
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.contain,
                                  )
                                else
                                  Container(
                                    height: 80,
                                    width: 80,
                                    color: Colors.grey,
                                    child: Icon(
                                      Icons.image_not_supported,
                                      color: Colors.white70,
                                    ),
                                  ),
                              ],
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
