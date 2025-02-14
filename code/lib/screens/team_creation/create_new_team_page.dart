import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../navbar_pages/search_page.dart';

class CreateNewTeamPage extends StatefulWidget {
  const CreateNewTeamPage({super.key});

  @override
  State<CreateNewTeamPage> createState() => _CreateNewTeamPageState();
}

class _CreateNewTeamPageState extends State<CreateNewTeamPage> {
  final _nameController = TextEditingController();
  String selectedFormation = '4-3-3';
  final List<String> formations = ['4-3-3', '4-4-2', '3-5-2', '5-3-2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create New Team',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.navbarColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: AppColors.gradientBackground,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Team Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter team name',
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                          filled: true,
                          fillColor: AppColors.inputBackgroundColor,
                          border: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white38),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Formation',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: formations.length,
                        itemBuilder: (context, index) {
                          final formation = formations[index];
                          final isSelected = formation == selectedFormation;
                          return InkWell(
                            onTap: () => setState(() => selectedFormation = formation),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.greenColor : AppColors.darkGreenColor,
                                border: Border.all(
                                  color: isSelected ? Colors.white : Colors.white38,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  formation,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(
                          teamName: _nameController.text,
                          formation: selectedFormation,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkColor,  // Changed from greenColor to darkColor
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text(
                  'Create Team',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
