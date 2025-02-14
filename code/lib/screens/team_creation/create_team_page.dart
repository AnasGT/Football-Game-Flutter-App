import 'package:flutter/material.dart';
import '../../models/team_info.dart';
import '../../models/saved_team.dart';
import '../../constants/app_colors.dart';
import '../navbar_pages/generate_team.dart';  // Add this import
import '../match_parameters_page.dart';  // Add this import

class CreateTeamPage extends StatelessWidget {
  CreateTeamPage({super.key});

  // Temporary list of saved teams (replace with actual data from database later)
  final List<SavedTeam> savedTeams = [
    SavedTeam(
      name: 'Dream Team 1',
      formation: '4-3-3',
      playerCount: 11,
      totalValue: 85.5,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    SavedTeam(
      name: 'My Squad',
      formation: '4-4-2',
      playerCount: 8,
      totalValue: 62.0,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Team',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.navbarColor,
      ),
      body: Column(
        children: [
          // Create New Team Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MatchParametersPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.greenColor,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8),
                  Text('Create New Team'),
                ],
              ),
            ),
          ),
          // Saved Teams List
          Expanded(
            child: ListView.builder(
              itemCount: savedTeams.length,
              itemBuilder: (context, index) {
                final team = savedTeams[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: AppColors.darkGreenColor,
                  child: ListTile(
                    title: Text(
                      team.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${team.formation} • ${team.playerCount} players • £${team.totalValue}M',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        // TODO: Navigate to edit team screen
                      },
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
