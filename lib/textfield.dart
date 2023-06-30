import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Textfield extends StatelessWidget {
  const Textfield({
    required BuildContext context,
    Key? key,
    required this.wid,
    required this.width,
    required this.maxline,
    required this.label,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  final double wid;
  final width, maxline, label, controller, validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 20),
        child: Container(
          width: wid * width,
          child: TextFormField(
            controller: controller,
            validator: validator,
            style: GoogleFonts.poppins(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontSize: 20,
                fontWeight: FontWeight.w400),
            cursorColor: Colors.white,
            maxLines: maxline,
            decoration: InputDecoration(
              errorStyle: GoogleFonts.poppins(color: Colors.white),
              label: Text(label),
              labelStyle: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 255, 255, 255), width: 2.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.pink, width: 2.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide:
                    const BorderSide(color: Colors.tealAccent, width: 2.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 255, 0, 0), width: 2.0),
              ),
            ),
          ),
        ));
  }
}
