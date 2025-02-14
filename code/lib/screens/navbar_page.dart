import 'package:flutter/material.dart';
import 'navbar_pages/home_page.dart';
import 'team_creation/create_team_page.dart';
import 'navbar_pages/squad_page.dart';
import 'navbar_pages/profile_page.dart';
import '../constants/app_colors.dart';

class NavbarPage extends StatefulWidget {
  final String? email;
  
  const NavbarPage({super.key, this.email});

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  int _selectedIndex = 0;

  // List of pages to display
  late final List<Widget> _pages = [
    HomePage(),
    CreateTeamPage(),
    const SquadPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: AppColors.navbarColor,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.create_outlined),
            selectedIcon: Icon(Icons.create),
            label: 'Create Team',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Squad',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
