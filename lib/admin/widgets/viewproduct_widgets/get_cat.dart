// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class cat extends StatefulWidget {
  const cat({super.key});

  @override
  State<cat> createState() => _catState();
}

// ignore: camel_case_types
class _catState extends State<cat> {
  String searchvalue = "";

  var firestoreDB = FirebaseFirestore.instance
      .collection("products")
      .doc(GetStorage().read('mobile'))
      .collection('category')
      .snapshots();

  // ignore: unnecessary_new
  imagesaro(String imge) => new Image.network(
        imge,
        fit: BoxFit.fill,
      );
  urlsaro(String saro) {
    Share.share(
      'check out my website $saro',
      subject: 'Thank You',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: firestoreDB,
        // ignore: non_constant_identifier_names
        builder: (context, Snapshot) {
          // ignore: prefer_const_constructors
          if (!Snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (Snapshot.hasError) {
            // ignore: prefer_const_constructors
            return Scaffold(
              body: Column(
                children: [
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Text("No Data Found"),
                  )
                ],
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    // controller: searchtxt,
                    initialValue: searchvalue,
                    onChanged: (value) {
                      setState(() {
                        searchvalue = value;
                      });

                      print("search:$value");
                      print(searchvalue);
                    },
                    cursorColor: Color.fromARGB(255, 19, 21, 21),

                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search_sharp),
                        suffixIcon: Icon(Icons.more_vert_outlined),
                        hoverColor: Color.fromARGB(255, 89, 90, 91),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        hintText: "search"),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: Snapshot.data!.docs
                          .where((element) => element['Category']
                              .toString()
                              .toLowerCase()
                              .contains(searchvalue.toLowerCase()))
                          .length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot = Snapshot
                            .data!.docs
                            .where((element) => element['Category']
                                .toString()
                                .toLowerCase()
                                .contains(searchvalue.toLowerCase()))
                            .toList()[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // ignore: avoid_unnecessary_containers
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 5, left: 10, right: 10),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * .17,
                                width: MediaQuery.of(context).size.width * .95,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(61, 23, 24, 25)
                                          .withOpacity(0.3),
                                      spreadRadius: 0,
                                      blurRadius: 12,
                                      offset: Offset(0, 2),
                                    ),
                                    //you can set more BoxShadow() here
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(9.5),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .32,
                                        // color: Color.fromARGB(255, 86, 218, 255),
                                        decoration: BoxDecoration(
                                          // color: Color.fromARGB(255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: imagesaro(
                                            documentSnapshot['image']),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .25,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        documentSnapshot[
                                                            'Category'],
                                                        style:
                                                            GoogleFonts.poppins(
                                                                // ignore: prefer_const_constructors
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 60),
                                                child: Row(
                                                  children: [
                                                    // ignore: avoid_unnecessary_containers
                                                    Container(
                                                      // ignore: prefer_const_constructors
                                                      child: InkWell(
                                                        onTap: () {
                                                          urlsaro(
                                                              documentSnapshot[
                                                                  'image']);
                                                        },
                                                        child: Icon(
                                                          Icons.share,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                    // ignore: avoid_unnecessary_containers
                                                    Container(
                                                      // ignore: prefer_const_constructors
                                                      child: Icon(
                                                        Icons
                                                            .more_vert_outlined,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 50,
                                          ),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 3.9),
                                                child: Container(
                                                  // color: Colors.red,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .06,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .03,
                                                  // color: Colors.red,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 10),
                                                        child: Icon(Icons
                                                            .stacked_bar_chart),
                                                      )),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .12,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .03,
                                                // color: Colors.red,
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Text(
                                                    "600k",
                                                    style: GoogleFonts.poppins(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .07,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .03,
                                                // color: Colors.red,
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Icon(Icons
                                                      .remove_red_eye_outlined),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .10,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .03,
                                                // color: Colors.red,
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Text(
                                                    "504",
                                                    style: GoogleFonts.poppins(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 3),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .07,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .03,
                                                  // color: Colors.red,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 01),
                                                      child: Icon(Icons
                                                          .work_outline_rounded),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 2),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .09,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .03,
                                                  // color: Colors.red,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 01),
                                                      child: Text(
                                                        "504",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
