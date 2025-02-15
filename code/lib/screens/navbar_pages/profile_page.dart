import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../constants/app_colors.dart';
import '../auth/landing_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> _getUserProfile() async {
    try {
      if (user == null) return {};

      final userDoc = await _firestore.collection('users').doc(user!.uid).get();
      
      if (!userDoc.exists) {
        // Create default profile if it doesn't exist
        final defaultData = {
          'displayName': user?.displayName ?? 'Football Manager',
          'email': user?.email,
          'photoURL': user?.photoURL,
          'totalMatches': 0,
          'totalPoints': 0,
          'wins': 0,
          'draws': 0,
          'losses': 0,
          'createdAt': Timestamp.now(),
        };
        
        await _firestore.collection('users').doc(user!.uid).set(defaultData);
        return defaultData;
      }
      
      // Merge Firestore data with current user data
      final userData = userDoc.data() ?? {};
      return {
        ...userData,
        'displayName': user?.displayName ?? userData['displayName'] ?? 'Football Manager',
        'email': user?.email ?? userData['email'] ?? '',
        'photoURL': user?.photoURL ?? userData['photoURL'] ?? '',
      };
    } catch (e) {
      print('Error fetching user profile: $e');
      return {
        'displayName': user?.displayName ?? 'Football Manager',
        'email': user?.email ?? '',
        'photoURL': user?.photoURL ?? '',
        'totalMatches': 0,
        'totalPoints': 0,
        'wins': 0,
        'draws': 0,
        'losses': 0,
      };
    }
  }

  Stream<Map<String, dynamic>> _getUserStats() {
    if (user == null) return Stream.value({});

    return _firestore
        .collection('match_results')
        .where('userId', isEqualTo: user!.uid)
        .snapshots()
        .map((snapshot) {
      int totalMatches = snapshot.docs.length;
      int totalPoints = 0;
      int wins = 0;
      int draws = 0;
      int losses = 0;

      for (var doc in snapshot.docs) {
        final data = doc.data();
        totalPoints += data['totalPoints'] as int;
        
        int teamScore = data['teamScore'] as int;
        int opponentScore = data['opponentScore'] as int;
        
        if (teamScore > opponentScore) wins++;
        else if (teamScore == opponentScore) draws++;
        else losses++;
      }

      return {
        'totalMatches': totalMatches,
        'totalPoints': totalPoints,
        'wins': wins,
        'draws': draws,
        'losses': losses,
        'winRate': totalMatches > 0 ? (wins / totalMatches * 100).toStringAsFixed(1) : '0',
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroun.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          ),
        ),
        child: SafeArea(
          child: StreamBuilder<Map<String, dynamic>>(
            stream: _getUserStats(),
            builder: (context, statsSnapshot) {
              if (statsSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final stats = statsSnapshot.data ?? {
                'totalMatches': 0,
                'totalPoints': 0,
                'wins': 0,
                'draws': 0,
                'losses': 0,
                'winRate': '0',
              };

              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Profile Header
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[900],
                            backgroundImage: AssetImage('assets/images/Vector.png'),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            user?.displayName ?? 'Football Manager',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            user?.email ?? '',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Stats Section
                    Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Career Statistics',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatItem('Matches', '${stats['totalMatches']}'),
                              _buildStatItem('Points', '${stats['totalPoints']}'),
                              _buildStatItem('Win Rate', '${stats['winRate']}%'),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatItem('Wins', '${stats['wins']}', color: Colors.green),
                              _buildStatItem('Draws', '${stats['draws']}', color: Colors.orange),
                              _buildStatItem('Losses', '${stats['losses']}', color: Colors.red),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Settings Section
                    Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          _buildSettingsItem(
                            icon: Icons.person_outline,
                            title: 'Edit Profile',
                            onTap: () {
                              // TODO: Implement edit profile
                            },
                          ),
                          _buildSettingsItem(
                            icon: Icons.notifications_outlined,
                            title: 'Notifications',
                            onTap: () {
                              // TODO: Implement notifications
                            },
                          ),
                          _buildSettingsItem(
                            icon: Icons.logout,
                            title: 'Sign Out',
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.of(context).pushReplacementNamed('/login');
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String _calculateWinRate(int wins, int totalMatches) {
    if (totalMatches == 0) return '0';
    return ((wins / totalMatches) * 100).toStringAsFixed(1);
  }

  Widget _buildStatItem(String label, String value, {Color? color}) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color ?? Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white70),
      onTap: () async {
        if (title == 'Sign Out') {
          try {
            final googleSignIn = GoogleSignIn();
            
            // First check if signed in with Google and sign out
            if (await googleSignIn.isSignedIn()) {
              await googleSignIn.disconnect().catchError((_) {});
              await googleSignIn.signOut().catchError((_) {});
            }
            
            // Then sign out from Firebase
            await FirebaseAuth.instance.signOut();

            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LandingPage()),
                (Route<dynamic> route) => false,
              );
            }
          } catch (e) {
            print('Error signing out: $e');
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error signing out: ${e.toString()}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        } else {
          onTap();
        }
      },
    );
  }
}
