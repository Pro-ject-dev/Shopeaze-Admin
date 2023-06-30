// ignore_for_file: sort_child_properties_last, unnecessary_new

import 'package:ecommerce/admin/screens/customers_screen.dart';
import 'package:ecommerce/admin/screens/qrcode_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class sales_card extends StatefulWidget {
  const sales_card({super.key});

  @override
  State<sales_card> createState() => _sales_cardState();
}

class _sales_cardState extends State<sales_card> {
  @override
  Widget build(BuildContext context) {
    var hei = MediaQuery.of(context).size.height;
    var wid = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 15.0),
                    child: Text(
                      "Promote your business..",
                      style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w700,
                          fontSize: wid * 0.041),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 15.0),
                    child: Text(
                      "http://urordr.at/cobinno3v0",
                      style: GoogleFonts.poppins(
                          color: Colors.blue,
                          textStyle: const TextStyle(
                              decoration: TextDecoration.underline),
                          fontWeight: FontWeight.w500,
                          fontSize: wid * 0.0384),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 16.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: hei * 0.036,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                  width: 1.0, color: Colors.blue),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            share();
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.whatsapp,
                                color: Colors.blue,
                                size: 18,
                              ),
                              Text(
                                "share",
                                style: GoogleFonts.poppins(
                                    color: Colors.blue, fontSize: wid * 0.03),
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    SizedBox(
                      height: hei * 0.036,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                  width: 1.0, color: Colors.blue),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const qrcode()));
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.qr_code_2_sharp,
                                color: Colors.blue,
                                size: 18,
                              ),
                              Text(
                                "QR code",
                                style: GoogleFonts.poppins(
                                    color: Colors.blue, fontSize: wid * 0.03),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            child: Image.asset('assets/img2.png'),
            height: hei * 0.2,
            width: wid * 0.2,
          ),
        ],
      ),
      height: hei * 0.173,
      width: wid * 0.9,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                blurRadius: 5,
                color: Color.fromARGB(255, 234, 232, 232),
                offset: Offset(1, 7)),
          ]),
    );
  }
}
