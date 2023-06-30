import 'dart:ui';

import 'package:ecommerce/admin/widgets/buildapp_widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class buildapp extends StatefulWidget {
  const buildapp({super.key});

  @override
  State<buildapp> createState() => _buildappState();
}

class _buildappState extends State<buildapp> {
  @override
  Widget build(BuildContext context) {
    final hei = MediaQuery.of(context).size.height;
    final wid = MediaQuery.of(context).size.width;

    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Color.fromARGB(255, 125, 124, 124),
                  title: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Text("My store",
                              style: GoogleFonts.poppins(
                                  fontSize: wid * 0.04,
                                  fontWeight: FontWeight.w600))),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 2.0, left: 1.0, bottom: 2.0),
                        child: Text(
                          "TAKING ORDERS",
                          style: GoogleFonts.poppins(fontSize: wid * 0.0223),
                        ),
                      ),
                    ],
                  ),
                  // ignore: prefer_const_literals_to_create_immutables
                  actions: [
                    const Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Icon(Icons.notifications_outlined),
                    )
                  ],
                  leading: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(Icons.menu_outlined),
                  ),
                  //backgroundColor: Color.fromARGB(255, 85, 85, 85),

                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(23),
                  )),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10, right: 70),
                      child: SizedBox(
                        height: 140,
                        child: Image(
                          image: NetworkImage(
                            'https://miro.medium.com/max/1400/1*RlRHormHjgS9KdGyDCPUDQ.jpeg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Text("Good job!",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: wid * 0.049,
                              color: const Color.fromARGB(255, 15, 1, 96))),
                    )
                  ],
                ),
                card(
                  b1: "Build my app",
                  link: "(http://urordr.at/cobinno3v0)",
                  h1: "Your online store is created at",
                  iconcolor: Colors.blue,
                  b1color: Colors.blue,
                ),
                card(
                    b1: "Customise",
                    h1: "customise and brand your store",
                    h2: "set your logo and address",
                    h3: "update business id & Taxation Details",
                    h4: "and payment",
                    iconcolor: const Color.fromARGB(255, 95, 95, 95),
                    b1color: Colors.black,
                    v1: Icons.videocam_outlined),
                card(
                  b1: "Add Now",
                  h1: "Add products to catlog",
                  h2: "Start by adding your best seller",
                  h3: "organise them in categories add picture",
                  iconcolor: const Color.fromARGB(255, 95, 95, 95),
                  b1color: Colors.black,
                  v1: Icons.videocam_outlined,
                  b2: "Bulk uploads",
                  b2color: const Color.fromARGB(255, 95, 95, 95),
                ),
                card(
                  b1: "share",
                  h1: "Share store on whatsapp and social media",
                  h2: "Start by adding your best seller",
                  h3: "organise them in categories add picture",
                  iconcolor: const Color.fromARGB(255, 95, 95, 95),
                  b1color: Colors.black,
                  v1: Icons.videocam_outlined,
                  b2: "QR code",
                  b2color: const Color.fromARGB(255, 95, 95, 95),
                ),
              ],
            ),
          ),
        ),
        debugShowCheckedModeBanner: false);

    //
  }
}
