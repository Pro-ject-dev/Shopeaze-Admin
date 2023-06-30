import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class appbar extends StatefulWidget {
  final prefixicon, suffixicon, title;
  appbar({this.prefixicon, this.suffixicon, this.title});

  @override
  State<appbar> createState() => _appbarState();
}

class _appbarState extends State<appbar> {
  @override
  Widget build(BuildContext context) {
    final hei = MediaQuery.of(context).size.height;
    final wid = MediaQuery.of(context).size.width;
    return AppBar(
        actions: [
          if (widget.suffixicon != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: widget.suffixicon,
            )
        ],
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(
              fontSize: wid * 0.045, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: widget.prefixicon,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color.fromARGB(255, 125, 124, 124),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)));
  }
}
