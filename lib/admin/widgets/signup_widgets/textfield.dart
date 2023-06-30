// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class textField extends StatefulWidget {
  final String label;
  final pass;
  final controller;
  final validator;
  bool obsecure;

  textField(
    BuildContext context, {
    Key? key,
    required this.label,
    this.pass,
    required this.controller,
    required this.validator,
    this.obsecure = true,
  });

  @override
  State<textField> createState() => _textFieldState();
}

class _textFieldState extends State<textField> {
  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;
    final hei = MediaQuery.of(context).size.height;
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 30, right: 30, bottom: 15),
        child: TextFormField(
          obscureText: widget.obsecure,
          controller: widget.controller,
          validator: widget.validator,
          cursorColor: Colors.black,
          decoration: InputDecoration(
              suffixIcon: widget.pass,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              label: Text(widget.label,
                  style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: wid * 0.039,
                      fontWeight: FontWeight.w500))),
        ),
      ),
    );
  }
}
