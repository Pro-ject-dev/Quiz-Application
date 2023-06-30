import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/textfield.dart';

import 'package:google_fonts/google_fonts.dart';

class score_board extends StatefulWidget {
  const score_board({super.key});

  @override
  State<score_board> createState() => _score_boardState();
}

class _score_boardState extends State<score_board> {
  final _textFieldController = TextEditingController();
  var verify;
  var Score;
  var doc;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final hei = MediaQuery.of(context).size.height;
    final wid = MediaQuery.of(context).size.width;
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("scores").snapshots(),
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
                          childAspectRatio: wid * 0.0008,
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
                                    Text(
                                        documents[index]['score'].toString() +
                                            " Points",
                                        style: GoogleFonts.poppins(
                                            fontSize: wid * 0.03,
                                            color:
                                                Color.fromARGB(255, 254, 0, 81),
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(height: 30),
                                    Text(
                                        documents[index]['teamname'].toString(),
                                        style: GoogleFonts.poppins(
                                            fontSize: wid * 0.02,
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
                                        IconButton(
                                            color: Colors.white,
                                            onPressed: () {
                                              doc = documents[index].id;
                                              print("yy");
                                              decrement();
                                            },
                                            icon: Icon(Icons.remove,
                                                color: Colors.white, size: 30)),
                                        InkWell(
                                          onTap: () {
                                            doc = documents[index].id;

                                            return increment();
                                          },
                                          child: Icon(Icons.add,
                                              color: Colors.white, size: 30),
                                        ),
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

  void decrement() {
    FirebaseFirestore.instance
        .collection('scores')
        .doc(doc)
        .update({"score": FieldValue.increment(-10)});
  }

  void increment() {
    FirebaseFirestore.instance
        .collection('scores')
        .doc(doc)
        .update({"score": FieldValue.increment(10)});
  }
}
