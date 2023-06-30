import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class teams extends StatelessWidget {
  final String points;

  final String teamname;

  final image;

  const teams({
    Key? key,
    required this.wid,
    required this.points,
    required this.teamname,
    this.image,
  }) : super(key: key);

  final double wid;

  @override
  Widget build(BuildContext context) {
    var hei = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(image),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Text(teamname,
                style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: wid * 0.009,
                    fontWeight: FontWeight.w600)),
          )
        ]),
        Container(
          padding: EdgeInsets.only(right: wid * 0.025, bottom: hei * 0.03),
          child: Text(points,
              style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: wid * 0.015,
                  fontWeight: FontWeight.w600)),
        )
      ],
    );
  }
}
