import 'package:flutter/material.dart';
import '../../models/player.dart';
import '../../constants/app_colors.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Player> players = [
    Player(
      name: 'Mohamed Salah',
      position: 'Forward',
      club: 'Liverpool',
      price: 32.5,
    ),
    Player(
      name: 'Riyad Mahrez',
      position: 'Midfielder',
      club: 'Al Ahli',
      price: 25.0,
    ),
    // Add more players as needed
  ];

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
      body: ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, index) {
          final player = players[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: AppColors.darkGreenColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(  // Wrap Column with Row
                children: [
                  Expanded(  // Add Expanded for text content
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
                          textAlign: TextAlign.left,  // Added left alignment
                        ),
                        const SizedBox(height: 4),
                        Text(
                          player.club,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.left,  // Added left alignment
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '£${player.price}M',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green,
                          ),
                          textAlign: TextAlign.left,  // Added left alignment
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),  // Add spacing
                  Image.asset(
                    'assets/images/akbou_kit.png',
                    height: 80,
                    width: 80,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
