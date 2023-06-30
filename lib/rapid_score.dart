import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/teams.dart';
import 'package:google_fonts/google_fonts.dart';

class scoreboard extends StatefulWidget {
  const scoreboard({super.key});

  @override
  State<scoreboard> createState() => _scoreboardState();
}

class _scoreboardState extends State<scoreboard> {
  @override
  Widget build(BuildContext context) {
    final hei = MediaQuery.of(context).size.height;
    final wid = MediaQuery.of(context).size.width;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('scores').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: hei * 0.96,
              width: wid * 0.26,
              decoration: BoxDecoration(
                color: Colors.transparent.withOpacity(0.56),
              ),
              child: Column(
                children: [
                  Container(
                    height: hei * 0.08,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text("Scoreboard",
                          style: GoogleFonts.poppins(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: wid * 0.015,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(children: [
                          for (var i = 0; i < snapshot.data!.docs.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 13.0, bottom: 13.0),
                              child: teams(
                                wid: wid,
                                points:
                                    snapshot.data!.docs[i]['score'].toString() +
                                        " Points",
                                teamname: snapshot.data!.docs[i]['teamname']
                                    .toString(),
                                image:
                                    'https://cdn.dribbble.com/userupload/2798814/file/original-3cfdbabadfd8f92aed97b0c0b57c6b89.png?compress=1&resize=752x',
                              ),
                            ),
                        ]),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Container();
        });
  }
}
