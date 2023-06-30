import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Scoreboard.dart';
import 'package:flutter_app/allow.dart';
import 'package:flutter_app/q_status.dart';
import 'package:flutter_app/quiz_round.dart';
import 'package:flutter_app/rapid_round.dart';
import 'package:side_navigation/side_navigation.dart';

class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  List<Widget> views = [
    const admin(),
    const score_board(),
    const quiz(),
    const question_status(),
    const rapid_round()
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hei = MediaQuery.of(context).size.height;
    final wid = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        children: [
          SideNavigationBar(
            theme: SideNavigationBarTheme(
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              togglerTheme: SideNavigationBarTogglerTheme.standard(),
              itemTheme: const SideNavigationBarItemTheme(
                  unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
                  selectedItemColor: Color.fromARGB(255, 255, 255, 255),
                  iconSize: 32.5,
                  labelTextStyle: TextStyle(fontSize: 15, color: Colors.black)),
              dividerTheme: SideNavigationBarDividerTheme.standard(),
            ),
            selectedIndex: selectedIndex,
            items: const [
              SideNavigationBarItem(
                icon: Icons.dashboard,
                label: 'Team Verification',
              ),
              SideNavigationBarItem(
                icon: Icons.stacked_bar_chart_sharp,
                label: 'Scoreboard',
              ),
              SideNavigationBarItem(
                icon: Icons.add,
                label: 'Normal Round',
              ),
              SideNavigationBarItem(
                icon: Icons.quiz,
                label: 'Question status',
              ),
              SideNavigationBarItem(
                icon: Icons.add,
                label: 'Rapid Round',
              ),
            ],
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: views.elementAt(selectedIndex),
          )
        ],
      ),
    );
  }
}
