import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/textfield.dart';

import 'package:google_fonts/google_fonts.dart';

class question_status extends StatefulWidget {
  const question_status({super.key});

  @override
  State<question_status> createState() => _question_statusState();
}

class _question_statusState extends State<question_status> {
  final _textFieldController = TextEditingController();
  var verify;
  var Score;
  var doc;

  @override
  Widget build(BuildContext context) {
    final hei = MediaQuery.of(context).size.height;
    final wid = MediaQuery.of(context).size.width;
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("temp_questions")
              .snapshots(),
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
                          childAspectRatio: wid * 0.0012,
                          crossAxisCount:
                              MediaQuery.of(context).size.shortestSide < 900
                                  ? 3
                                  : 2,
                        ),
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          SizedBox(height: 50);
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
                                    Text(documents[index]['q_no'].toString(),
                                        style: GoogleFonts.readexPro(
                                            fontSize: wid * 0.03,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        MaterialButton(
                                            color:
                                                Color.fromARGB(255, 21, 0, 252),
                                            onPressed: () {
                                              doc =
                                                  snapshot.data!.docs[index].id;
                                              question_update();
                                            },
                                            child: Text("Allow",
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

  void question_update() {
    FirebaseFirestore.instance
        .collection('question')
        .doc('id')
        .set({"status": doc}).whenComplete(() => delete());
  }

  void delete() {
    FirebaseFirestore.instance.collection('temp_questions').doc(doc).delete();
  }
}
