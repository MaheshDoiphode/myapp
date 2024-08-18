import 'package:flutter/material.dart';
import 'package:myapp/features/revision_tracker/screens/add_topic_screen.dart'; // Import the AddTopicScreen

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        // Removed the const keyword here
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the Dashboard!'),
            const SizedBox(height: 16.0), // Added some spacing
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddTopicScreen()),
                );
              },
              child: const Text('Add Topic'),
            ),
          ],
        ),
      ),
    );
  }
}
