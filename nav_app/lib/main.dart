import 'package:flutter/material.dart';
import 'package:nav_app/screens/bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RouteMaster',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = '';

  void _login() {
    // just a basic outline guys...idk how to create database

    String username = _usernameController.text;
    String password = _passwordController.text;

    // Dummy account database
    Map<String, String> accounts = {
      'user1': 'password1',
      'user2': 'password2',
    };

    if (accounts.containsKey(username)) {
      if (accounts[username] == password) {
        // Successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottomBar()),
        );
      } else {
        // Incorrect password
        setState(() {
          _errorMessage = 'Incorrect password.';
        });
      }
    } else {
      // Account not found
      setState(() {
        _errorMessage = 'Account not found.';
      });
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
/*
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Bus, Train Schedules'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SchedulePage()),
              );
            },
          ),
          ListTile(
            title: const Text('Nearby Restaurants, Shops'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NearbyPlacesPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus, Train Schedules'),
      ),
      body: const Center(
        child: Text('Display Bus and Train Schedules here'),
      ),
    );
  }
}

class NearbyPlacesPage extends StatelessWidget {
  const NearbyPlacesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Restaurants, Shops'),
      ),
      body: const Center(
        child: Text('Display Nearby Restaurants and Shops here'),
      ),
    );
  }
  
}*/
