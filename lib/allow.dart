import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class admin extends StatefulWidget {
  const admin({super.key});

  @override
  State<admin> createState() => _adminState();
}

class _adminState extends State<admin> {
  var verify;

  @override
  Widget build(BuildContext context) {
    final hei = MediaQuery.of(context).size.height;
    final wid = MediaQuery.of(context).size.width;
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("temp").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Error");
            }

            if (snapshot.hasData) {
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return Stack(children: [
                Container(
                    height: hei,
                    width: wid,
                    child: Image.asset(
                      'assets/bgimg.gif',
                      fit: BoxFit.cover,
                    )),
                SingleChildScrollView(
                  child: Container(
                    height: hei,
                    width: wid,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: wid * 0.00078,
                          crossAxisCount:
                              MediaQuery.of(context).size.shortestSide < 900
                                  ? 3
                                  : 2,
                        ),
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                color: Colors.transparent.withOpacity(0.5),
                                child: Column(
                                  children: [
                                    SizedBox(height: hei * 0.04),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 40,
                                        child: CircleAvatar(
                                          radius: 35,
                                          backgroundImage: NetworkImage(
                                              'https://cdn.dribbble.com/userupload/3638418/file/original-27458ba57c56b1872d898d64af0ac887.png?compress=1&resize=752x'),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                        documents[index]['Teamname'].toString(),
                                        style: GoogleFonts.poppins(
                                            fontSize: wid * 0.02,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        MaterialButton(
                                            color: Colors.blue,
                                            onPressed: () {
                                              verify = documents[index]
                                                      ['Teamname']
                                                  .toString();
                                              verification();
                                            },
                                            child: Text("Allow",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: wid * 0.01))),
                                        MaterialButton(
                                            color: Colors.red,
                                            onPressed: () {
                                              verify = documents[index]
                                                      ['Teamname']
                                                  .toString();
                                              delete();
                                            },
                                            child: Text("Decline",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: wid * 0.01))),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                )
              ]);
            } else {
              return Center(
                  child: const Text(
                "Something went wrong.",
                textAlign: TextAlign.center,
              ));
            }
          },
        ),
      ],
    );
  }

  void verification() {
    FirebaseFirestore.instance
        .collection('teams')
        .doc(verify)
        .update({"status": "1"})
        .whenComplete(() => delete())
        .whenComplete(() => score());
  }

  void score() {
    FirebaseFirestore.instance
        .collection('scores')
        .doc(verify)
        .set({"score": 0, "teamname": verify});
  }

  void delete() {
    FirebaseFirestore.instance.collection('temp').doc(verify).delete();
  }
}
