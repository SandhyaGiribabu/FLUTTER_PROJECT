import 'package:flutter/material.dart';
import 'package:nav_app/screens/busSearch.dart';

import 'package:nav_app/utils/app_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: ListView(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                const SizedBox(height: 40),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Good morning",
                            style: Styles.headLineStyle3,
                          ),
                          Text(
                            "Find the bus,train schedules here",
                            style: Styles.headLineStyle,
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: AssetImage("assets/images/logo.png")),
                        ),
                      ),
                    ]),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: const Row(
                    children: [
                      BusSearchScreen(),
                    ],
                  ),
                )
              ]))
        ],
      ),
    );
  }
}
