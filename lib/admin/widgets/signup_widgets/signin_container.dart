import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class sigin_container extends StatefulWidget {
  final label;
  final logo;

  sigin_container(BuildContext context,
      {Key? key, required this.label, this.logo});

  @override
  State<sigin_container> createState() => _sigin_containerState();
}

class _sigin_containerState extends State<sigin_container> {
  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;
    final hei = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: hei * 0.067,
          width: wid * 0.8,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 233, 233, 233),
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 30),
                  child: Container(
                    height: hei * 0.045,
                    child: Image(
                      image: NetworkImage(widget.logo),
                    ),
                  )),
              Text(widget.label,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500))
            ],
          )),
    );
  }
}
