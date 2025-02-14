import 'package:flutter/material.dart';
import '../../models/team_info.dart';
import '../../constants/app_colors.dart';

class SearchPage extends StatelessWidget {
  final String teamName;
  final String formation;

  const SearchPage({
    super.key,
    required this.teamName,
    required this.formation,
  });

  @override
  Widget build(BuildContext context) {
    final teamInfo = TeamInfo(
      budgetLeft: 57.0,
      numberOfPlayers: 6,
      formation: formation,
    );

    return Scaffold(
      body: Stack(  // Changed to Stack
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Doing sport concept.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black26,
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          // Team info overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 16.0),
              decoration: BoxDecoration(
                color: AppColors.darkGreenColor.withOpacity(0.9),
              ),
              child: Column(
                children: [
                  Text(
                    'Budget left: £${teamInfo.budgetLeft}M',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Number of Players: ${teamInfo.numberOfPlayers}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Formation: ${teamInfo.formation}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Add player positions with vector images
          Positioned(
            top: 200,  // Adjust this value as needed
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height - 200,
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: 11,  // Number of players in formation
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkGreenColor.withOpacity(0.7),
                      border: Border.all(color: Colors.white38),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/vector.png',
                          height: 60,
                          width: 60,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Player ${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}