import 'package:ecommerce/admin/screens/sales_screen.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class card extends StatefulWidget {
  final v1, iconcolor, b1color, b2color, v1color;
  final h1, h2, h3, h4, b1, b2, link;
  card(
      {required this.h1,
      this.b1,
      this.v1,
      this.iconcolor,
      this.b1color,
      this.b2color,
      this.v1color,
      this.h2,
      this.h3,
      this.h4,
      this.b2,
      this.link});

  @override
  State<card> createState() => _cardState();
}

class _cardState extends State<card> {
  @override
  Widget build(BuildContext context) {
    final hei = MediaQuery.of(context).size.height;
    final wid = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: 18, top: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                checkicon(),
                header(wid),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.link != null) link(wid),
                if (widget.h2 != null) h2(wid),
                if (widget.h3 != null) h3(wid),
                if (widget.h4 != null) h4(wid),
                button1(wid, context),
              ],
            ),
          )
        ],
      ),
    );
  }

  header(double wid) {
    return Center(
      child: Container(
        width: wid * 0.8,
        margin: EdgeInsets.only(top: 4, left: 12),
        child: Text(widget.h1,
            style: GoogleFonts.poppins(
                fontSize: wid * 0.035,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 0, 0, 0))),
      ),
    );
  }

  Icon checkicon() => Icon(Icons.check_circle, color: widget.iconcolor);

  Padding link(double wid) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.only(top: 2),
              child: Text(widget.link,
                  style: GoogleFonts.poppins(
                      color: Colors.blue,
                      fontSize: wid * 0.034,
                      fontWeight: FontWeight.w600,
                      textStyle:
                          TextStyle(decoration: TextDecoration.underline)))),
        ],
      ),
    );
  }

  Row button1(double wid, BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: [
          MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => sales())));
              },
              child: Text(widget.b1,
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontSize: wid * 0.025)),
              color: widget.b1color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )),
        ],
      ),
      if (widget.b2 != null) button2(wid),
      if (widget.v1 != null) videoicon(),
    ]);
  }

  Column videoicon() {
    return Column(
      children: [
        IconButton(onPressed: () {}, icon: Icon(widget.v1, color: Colors.blue)),
      ],
    );
  }

  Row button2(double wid) {
    return Row(
      children: [
        MaterialButton(
            onPressed: () {},
            child: Text(widget.b2,
                style: GoogleFonts.poppins(
                    color: Colors.white, fontSize: wid * 0.025)),
            color: widget.b2color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            )),
      ],
    );
  }

  Padding h4(double wid) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(top: 2),
            child: Text(widget.h4,
                style: GoogleFonts.poppins(
                    color: Color.fromARGB(255, 125, 125, 125),
                    fontSize: wid * 0.03,
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  Padding h3(double wid) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(top: 2),
            child: Text(widget.h3,
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    color: Color.fromARGB(255, 125, 125, 125),
                    fontSize: wid * 0.03,
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  Padding h2(double wid) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(top: 2),
            child: Text(widget.h2,
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    color: Color.fromARGB(255, 125, 125, 125),
                    fontSize: wid * 0.03,
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
