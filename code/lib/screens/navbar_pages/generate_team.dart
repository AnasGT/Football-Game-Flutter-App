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

  List<List<int>> _getFormationLayout() {
    List<List<int>> formation;
    switch (this.formation) {
      case '4-3-3':
        formation = [
          List.filled(3, 2), // Forwards
          List.filled(3, 1), // Midfielders
          List.filled(4, 0), // Defenders
          [3], // Goalkeeper at the end
        ];
        break;
      case '4-4-2':
        formation = [
          List.filled(2, 2), // Forwards
          List.filled(4, 1), // Midfielders
          List.filled(4, 0), // Defenders
          [3], // Goalkeeper at the end
        ];
        break;
      case '3-5-2':
        formation = [
          List.filled(2, 2), // Forwards
          List.filled(5, 1), // Midfielders
          List.filled(3, 0), // Defenders
          [3], // Goalkeeper at the end
        ];
        break;
      case '5-3-2':
        formation = [
          List.filled(2, 2), // Forwards
          List.filled(3, 1), // Midfielders
          List.filled(5, 0), // Defenders
          [3], // Goalkeeper at the end
        ];
        break;
      default:
        formation = [
          List.filled(3, 2),
          List.filled(3, 1),
          List.filled(4, 0),
          [3], // Goalkeeper at the end
        ];
    }
    return formation;
  }

  String _getPositionName(int positionType) {
    switch (positionType) {
      case 0:
        return 'DEF';
      case 1:
        return 'MID';
      case 2:
        return 'FWD';
      case 3:
        return 'GK';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final teamInfo = TeamInfo(
      budgetLeft: 57.0,
      numberOfPlayers: 6,
      formation: formation,
    );

    final formationLayout = _getFormationLayout();

    return Scaffold(
      body: Stack(
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
          // Formation layout
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(  // Added this Padding widget
              padding: const EdgeInsets.only(bottom: 120.0, left: 35.0, right: 35.0, top: 30.0),  // Increased from 40.0 to 80.0
              child: Column(
                children: [
                  for (int rowIndex = 0; rowIndex < formationLayout.length; rowIndex++)  // Changed from reverse to forward iteration
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (int player in formationLayout[rowIndex])
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Reduced vertical padding
                                child: Column(  // Removed Container wrapper
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/Vector.png',
                                      height: 35, // Slightly reduced height
                                      width: 35, // Slightly reduced width
                                      fit: BoxFit.contain,
                                      color: Colors.white,
                                      colorBlendMode: BlendMode.srcIn,
                                    ),
                                    const SizedBox(height: 4), // Reduced from 8 to 4
                                    Text(
                                      _getPositionName(player),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}