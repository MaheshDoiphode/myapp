import 'package:flutter/material.dart';
import 'package:myapp/core/services/mongodb_service.dart'; // Import your MongoDB service
import 'package:myapp/core/services/local_storage_service.dart'; // Import your local storage service
import 'package:myapp/features/dashboard/screens/dashboard_screen.dart'; // Import your dashboard screen

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final mongoDBService =
          MongoDBService(); // Initialize your MongoDB service
      final localStorageService =
          LocalStorageService(); // Initialize your local storage service

      // Check if the user exists in MongoDB
      final userExists = await mongoDBService.userExists(username);

      if (userExists) {
        // User exists, load their data and navigate to the dashboard
        await localStorageService.setUsername(username);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } else {
        // User doesn't exist, prompt to create a new user
        final createNewUser = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('User Not Found'),
            content: const Text('Do you want to create a new user?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Yes'),
              ),
            ],
          ),
        );

        if (createNewUser == true) {
          // Create a new user with default template values
          await mongoDBService.createUser(username);
          await localStorageService.setUsername(username);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
