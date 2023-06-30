// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/admin/screens/AddProductScreen.dart';
import 'package:ecommerce/admin/widgets/viewproduct_widgets/get_cat.dart';
import 'package:ecommerce/admin/widgets/viewproduct_widgets/list.dart';
import 'package:ecommerce/admin/screens/viewproduct.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class summa extends StatefulWidget {
  const summa({super.key});

  @override
  State<summa> createState() => _summaState();
}

// ignore: camel_case_types
class _summaState extends State<summa> {
  int _currentIndex = 0;
  var firestoreDB = FirebaseFirestore.instance.collection("user").snapshots();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Text("Catalog",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                    color: Colors.black)),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          // ignore: prefer_const_literals_to_create_immutables
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddProductScreen("", "", 'null')));
                },
                child: ImageIcon(
                  AssetImage(
                    "assets/three_dot.png",
                  ),
                  size: 30,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBar(
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                unselectedLabelColor: Color.fromARGB(255, 9, 8, 8),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color.fromARGB(161, 9, 9, 10),
                ),
                tabs: [
                  Tab(
                    child: Container(
                      child: Text(
                        "PRODUCT",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    // ignore: avoid_unnecessary_containers
                    child: Container(
                      child: Center(
                          child: Text(
                        "CATEGORY",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    ),
                  ),
                  Tab(
                    child: Container(
                      child: Center(
                          child: Text(
                        "LISTS",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 2, bottom: 10),
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    update_table(),
                    cat(),
                    name(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
