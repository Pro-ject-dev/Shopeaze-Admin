import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class cat_card extends StatefulWidget {
  final icon, title1;
  cat_card({this.icon, this.title1});

  @override
  State<cat_card> createState() => _cat_cardState();
}

class _cat_cardState extends State<cat_card> {
  @override
  Widget build(BuildContext context) {
    final hei = MediaQuery.of(context).size.height;
    final wid = MediaQuery.of(context).size.width;
    return Container(
        height: hei * 0.056,
        width: wid * 0.44,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(255, 119, 117, 117)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 30, child: Image.asset(widget.icon)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: wid * 0.3,
                      child: Text(widget.title1,
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: wid * 0.03,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
