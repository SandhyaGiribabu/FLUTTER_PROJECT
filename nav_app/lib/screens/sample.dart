import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class BusSearchScreen extends StatefulWidget {
  const BusSearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BusSearchScreenState createState() => _BusSearchScreenState();
}

class _BusSearchScreenState extends State<BusSearchScreen> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _departureTimeController =
      TextEditingController();

  List<Map<String, dynamic>> _busRoutes = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _databaseHelper.initDatabase();
  }

  Future<void> _searchBuses() async {
    final List<Map<String, dynamic>> buses = await _databaseHelper.searchBuses(
      _fromController.text,
      _toController.text,
      _departureTimeController.text,
    );
    setState(() {
      _busRoutes = buses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _fromController,
              decoration: const InputDecoration(labelText: 'From'),
            ),
            TextField(
              controller: _toController,
              decoration: const InputDecoration(labelText: 'To'),
            ),
            TextField(
              controller: _departureTimeController,
              decoration: const InputDecoration(labelText: 'Departure Time'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _searchBuses,
              child: const Text('Search Buses'),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _busRoutes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_busRoutes[index]['Route No.']),
                    subtitle: Text(
                        '${_busRoutes[index]['From']} - ${_busRoutes[index]['To']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DatabaseHelper {
  static late Database _database;

  Future<void> initDatabase() async {
    _database = await openDatabase(
      'C:/flutter/sqlite-tools-win-x64-3450100/bus_routes.db',
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE bus_routes(SlNo INTEGER PRIMARY KEY, Depot TEXT, RouteNo TEXT, FromLocation TEXT, ToLocation TEXT, RouteLength INTEGER, Type TEXT, NoOfService INTEGER, DepartureTimings TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<List<Map<String, dynamic>>> searchBuses(
      String from, String to, String departureTime) async {
    await initDatabase(); // Ensure database is initialized
    final List<Map<String, dynamic>> buses = await _database.rawQuery(
        "SELECT * FROM bus_routes WHERE FromLocation = ? AND ToLocation = ? AND DepartureTimings >= ?",
        [from, to, departureTime]);
    return buses;
  }
}
