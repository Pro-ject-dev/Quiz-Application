import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_app/public.dart';
import 'package:flutter_app/rapid_score.dart';
import 'package:flutter_app/textfield.dart';
import 'package:google_fonts/google_fonts.dart';

class rapid_round extends StatefulWidget {
  const rapid_round({super.key});

  @override
  State<rapid_round> createState() => _rapid_roundState();
}

class _rapid_roundState extends State<rapid_round> {
  final _formKey = GlobalKey<FormState>();

  var items = ['A', 'B', 'C', 'D'];
  var item1 = [
    'select-question',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20'
  ];
  String dropdownvalue = 'A';
  String dropdownvalue1 = 'select-question';
  TextEditingController question = TextEditingController();
  TextEditingController option1 = TextEditingController(text: "A. ");

  TextEditingController option2 = TextEditingController(text: "B. ");

  TextEditingController option3 = TextEditingController(text: "C. ");

  TextEditingController option4 = TextEditingController(text: "D. ");

  @override
  Widget build(BuildContext context) {
    final hei = MediaQuery.of(context).size.height;
    final wid = MediaQuery.of(context).size.width;
    String? i = "1";

    return Scaffold(
        body: Form(
            key: _formKey,
            child: Stack(children: [
              Container(
                height: hei,
                width: wid,
                child: Image.asset(
                  'assets/bgimg.gif',
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 10),
                    child: Container(
                      height: hei * 0.98,
                      width: wid * 0.53,
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.56)),
                      child: Column(
                        children: [
                          Container(
                              child: Center(
                                child: Text("Rapid Round",
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: wid * 0.02,
                                        fontWeight: FontWeight.w500)),
                              ),
                              decoration: BoxDecoration(color: Colors.white),
                              height: hei * 0.08,
                              width: double.infinity),
                          SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 28.0, right: 18),
                            child: SingleChildScrollView(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Question",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: wid * 0.015,
                                          fontWeight: FontWeight.w500)),
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              width: 2)),
                                      height: hei * 0.075,
                                      width: wid * 0.1,
                                      child: DropdownButton(
                                          value: dropdownvalue1,
                                          iconEnabledColor: Colors.white,
                                          isExpanded: true,
                                          underline: Container(),
                                          dropdownColor: Colors.transparent
                                              .withOpacity(0.5),
                                          items: item1.map((String items) {
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
                                            i = newValue;

                                            setState(() {
                                              dropdownvalue1 = newValue!;
                                              retriew(dropdownvalue1);
                                            });
                                          })),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 10),
                              Textfield(
                                  context: context,
                                  wid: wid,
                                  width: 0.48,
                                  maxline: 2,
                                  label: "Question",
                                  controller: question,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter question";
                                    }
                                  }),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(width: 28),
                              Text("Options",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: wid * 0.015,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 38.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Textfield(
                                      context: context,
                                      wid: wid,
                                      width: 0.2,
                                      maxline: 1,
                                      label: "Option A",
                                      controller: option1,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please Enter Option A";
                                        }
                                      },
                                    ),
                                    Textfield(
                                        context: context,
                                        wid: wid,
                                        width: 0.2,
                                        maxline: 1,
                                        label: "Option C",
                                        controller: option3,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please Enter Option C";
                                          }
                                        })
                                  ],
                                ),
                                SizedBox(width: 40),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Textfield(
                                        context: context,
                                        wid: wid,
                                        width: 0.2,
                                        maxline: 1,
                                        label: "Option B",
                                        controller: option2,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please Enter Option B";
                                          }
                                        }),
                                    Textfield(
                                        context: context,
                                        wid: wid,
                                        width: 0.2,
                                        maxline: 1,
                                        label: "Option D",
                                        controller: option4,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please Enter Option D";
                                          }
                                        })
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 28),
                              Text("Answer:",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: wid * 0.015,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(width: wid * 0.08),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          width: 3)),
                                  height: hei * 0.09,
                                  width: wid * 0.17,
                                  child: DropdownButton(
                                      value: dropdownvalue,
                                      iconEnabledColor: Colors.white,
                                      isExpanded: true,
                                      underline: Container(),
                                      dropdownColor:
                                          Colors.transparent.withOpacity(0.5),
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
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
                                        });
                                      }))
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MaterialButton(
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
                              MaterialButton(
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
                                    "update",
                                    style: GoogleFonts.poppins(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      fontSize: 14,
                                    ),
                                  ),
                                  color: Colors.teal),
                              MaterialButton(
                                  onPressed: () {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    } else {
                                      q_num = question.text.split('.');

                                      delete();
                                    }
                                  },

                                  // ignore: sort_child_properties_last
                                  child: Text(
                                    "Delete",
                                    style: GoogleFonts.poppins(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      fontSize: 14,
                                    ),
                                  ),
                                  color: Color.fromARGB(255, 255, 0, 0)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: wid * 0.015),
                  scoreboard()
                ],
              )
            ])));
  }

  void clear_text() {
    question.clear();
    option1.text = "A. ";
    option2.text = "B. ";

    option3.text = "C. ";

    option4.text = "D. ";
    setState(() {
      dropdownvalue = "A";
      dropdownvalue1 = "select-question";
    });
  }

  void store() {
    FirebaseFirestore.instance.collection('rapid_question').doc(q_num[0]).set({
      "sort": q_num[0],
      "question": question.text,
      "answer": dropdownvalue.toString(),
      "opt1": option1.text,
      "opt2": option2.text,
      "opt3": option3.text,
      "opt4": option4.text,
    }).whenComplete(() => clear_text());
  }

  void delete() {
    FirebaseFirestore.instance
        .collection('rapid_question')
        .doc(q_num[0])
        .delete()
        .whenComplete(() => clear_text());
  }

  retriew(var i) async {
    print(i);
    try {
      var collection = FirebaseFirestore.instance.collection('rapid_question');
      var querySnapshot = await collection.doc(i).get();

      var quest = querySnapshot['question'];
      var opt1 = querySnapshot['opt1'];
      var opt2 = querySnapshot['opt2'];

      var opt3 = querySnapshot['opt3'];

      var opt4 = querySnapshot['opt4'];
      String ans = querySnapshot['answer'];
      question.text = quest;
      option1.text = opt1;
      option2.text = opt2;
      option3.text = opt3;
      option4.text = opt4;
      dropdownvalue = ans;

      print(quest);
    } catch (e) {
      print(e);
      question.clear();
      option1.text = "A. ";
      option2.text = "B. ";

      option3.text = "C. ";

      option4.text = "D. ";
      setState(() {
        dropdownvalue = "A";
      });
    }
  }
}
