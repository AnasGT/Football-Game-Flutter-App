import 'package:flutter/material.dart';

class SquadPage extends StatelessWidget {
  const SquadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            'Squad Page',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
