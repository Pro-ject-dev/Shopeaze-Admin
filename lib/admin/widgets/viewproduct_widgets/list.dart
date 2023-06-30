import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class name extends StatefulWidget {
  const name({super.key});

  @override
  State<name> createState() => _nameState();
}

class _nameState extends State<name> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            // ignore: sized_box_for_whitespace
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .50,
              // ignore: prefer_const_constructors
              child: Center(
                child: Text(
                  "Coming soon.....",
                  style: GoogleFonts.poppins(
                      // ignore: prefer_const_constructors
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
