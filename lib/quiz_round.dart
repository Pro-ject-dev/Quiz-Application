import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_app/public.dart';
import 'package:flutter_app/textfield.dart';
import 'package:google_fonts/google_fonts.dart';

class quiz extends StatefulWidget {
  const quiz({super.key});

  @override
  State<quiz> createState() => _quizState();
}

class _quizState extends State<quiz> {
  final _formKey = GlobalKey<FormState>();

  var items = ['A', 'B', 'C', 'D'];
  String dropdownvalue = 'A';
  String? drop;
  TextEditingController question = TextEditingController();
  TextEditingController option1 = TextEditingController(text: "A. ");

  TextEditingController option2 = TextEditingController(text: "B. ");

  TextEditingController option3 = TextEditingController(text: "C. ");

  TextEditingController option4 = TextEditingController(text: "D. ");

  @override
  Widget build(BuildContext context) {
    final hei = MediaQuery.of(context).size.height;
    final wid = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Stack(children: [
      Container(
        height: hei,
        width: wid,
        child: Image.asset(
          'assets/bgimg.gif',
          fit: BoxFit.cover,
        ),
      ),
      Center(
          child: Form(
        key: _formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              height: hei * 0.98,
              width: wid * 0.8,
              decoration: BoxDecoration(
                  color: Colors.transparent.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        width: double.infinity,
                        height: hei * 0.098,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Quiz Round",
                                  style: GoogleFonts.poppins(
                                      fontSize: wid * 0.02,
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0, right: 10),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Questions",
                                        style: GoogleFonts.poppins(
                                            fontSize: wid * 0.018,
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                Textfield(
                                  wid: wid,
                                  width: 0.35,
                                  maxline: 5,
                                  context: context,
                                  label: 'Question',
                                  controller: question,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Questions";
                                    }
                                  },
                                ),
                                SizedBox(height: hei * 0.08),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text("Answer  :",
                                          style: GoogleFonts.poppins(
                                              fontSize: wid * 0.018,
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    SizedBox(width: wid * 0.07),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              width: 3)),
                                      height: hei * 0.09,
                                      width: wid * 0.2,
                                      child: DropdownButton(
                                          value: dropdownvalue,
                                          iconEnabledColor: Colors.white,
                                          isExpanded: true,
                                          underline: Container(),
                                          dropdownColor: Colors.transparent
                                              .withOpacity(0.5),
                                          items: items.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  items,
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownvalue = newValue!;
                                              newValue = drop;
                                            });
                                          }),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            VerticalDivider(color: Colors.white, width: 5),
                            Column(
                              children: [
                                Text("Options",
                                    style: GoogleFonts.poppins(
                                        fontSize: wid * 0.018,
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        fontWeight: FontWeight.w500)),
                                Textfield(
                                  wid: wid,
                                  context: context,
                                  width: 0.24,
                                  maxline: 1,
                                  label: 'Option A',
                                  controller: option1,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Option A";
                                    } else if (value[0] != 'A') {
                                      return "must insert option value";
                                    }
                                  },
                                ),
                                Textfield(
                                  wid: wid,
                                  context: context,
                                  controller: option2,
                                  width: 0.24,
                                  maxline: 1,
                                  label: 'Option B',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Option B";
                                    } else if (value[0] != 'B') {
                                      return "must insert option value";
                                    }
                                  },
                                ),
                                Textfield(
                                  wid: wid,
                                  context: context,
                                  width: 0.24,
                                  maxline: 1,
                                  label: 'Option C',
                                  controller: option3,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Option C";
                                    } else if (value[0] != 'C') {
                                      return "must insert option value";
                                    }
                                  },
                                ),
                                Textfield(
                                  context: context,
                                  wid: wid,
                                  width: 0.24,
                                  maxline: 1,
                                  label: 'Option D',
                                  controller: option4,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Option D";
                                    } else if (value[0] != 'D') {
                                      return "must insert option value";
                                    }
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: hei * 0.04),
                    Padding(
                      padding: const EdgeInsets.only(left: 120.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: hei * 0.07,
                            width: wid * 0.08,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    width: 3)),
                            child: MaterialButton(
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  } else {
                                    q_num = question.text.split('.');

                                    store();
                                  }
                                },

                                // ignore: sort_child_properties_last
                                child: Text(
                                  "Add",
                                  style: GoogleFonts.poppins(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    fontSize: 14,
                                  ),
                                ),
                                color: Colors.pink),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ))
        ]),
      ))
    ]));
  }

  void clear_text() {
    question.clear();
    option1.text = "A. ";
    option2.text = "B. ";

    option3.text = "C. ";

    option4.text = "D. ";
    dropdownvalue = "A";
  }

  void store() {
    FirebaseFirestore.instance
        .collection('question')
        .doc("question" + q_num[0])
        .set({
      "question": question.text,
      "answer": dropdownvalue.toString(),
      "opt1": option1.text,
      "opt2": option2.text,
      "opt3": option3.text,
      "opt4": option4.text,
    }).whenComplete(() => clear_text());
  }
}
