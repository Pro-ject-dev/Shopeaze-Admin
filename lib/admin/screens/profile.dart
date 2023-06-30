// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, unnecessary_null_comparison

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/admin/public/variables.dart';
import 'package:ecommerce/admin/screens/adminaddress.dart';
import 'package:ecommerce/admin/screens/business_category_screen.dart';
import 'package:ecommerce/admin/screens/edit_details.dart';
import 'package:ecommerce/admin/screens/imageadd.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

// ignore: camel_case_types
class _profileState extends State<profile> {
  ImagePicker image = ImagePicker();

  File? file;

  File? _image;
  final picker = ImagePicker();

  var url = "";

  var refu = FirebaseFirestore.instance.collection('user');

  String names = "";
  String catego = "";
  String storename = "";
  String number = "";

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('user');
  @override
  String mobile = "";
  String City = "";
  String Country = "";
  String Deliveryaddress = "";
  String Houseaddress = "";
  String Name = "";
  String Pincode = "";
  String State = "";
  String emailaddress = "";
  String funny = "+1";
  String saroja = "";
  String imageview = "https://picsum.photos/seed/picsum/200/600";
  var firestoreDB = FirebaseFirestore.instance
      .collection("user")
      .doc(GetStorage().read('mobile'))
      .snapshots();
  @override
  Widget build(BuildContext context) {
    var hei = MediaQuery.of(context).size.height;
    var wid = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: StreamBuilder<DocumentSnapshot>(
              stream: firestoreDB,
              builder: (context, snapshot) {
                var ans = snapshot.data!['address'];
                var address = ans.split("`");
                return Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(85),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(61, 23, 24, 25)
                                      .withOpacity(0.3),
                                  spreadRadius: 0,
                                  blurRadius: 17,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 85,
                              backgroundImage:
                                  NetworkImage(snapshot.data!['image']),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          IconButton(
                            iconSize: 30,
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => imagheadd(),
                                ),
                              );
                            },
                            icon: Icon(Icons.edit),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Container(
                            height: MediaQuery.of(context).size.height * .35,
                            width: MediaQuery.of(context).size.width * .90,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 89, 172, 255)
                                      .withOpacity(0.3),
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  // offset: Offset(0, 2),
                                ),
                                //you can set more BoxShadow() here
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * .085,
                                  width:
                                      MediaQuery.of(context).size.width * .90,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(245, 0, 0, 0),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text("Customer Details",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255))),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 10),
                                      child: Container(
                                        child: Text(snapshot.data!['username'],
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 8, 8, 8))),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 05),
                                      child: Container(
                                        child: Text(
                                            snapshot.data!['business category'],
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 8, 8, 8))),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 05),
                                      child: Container(
                                        child: Text(
                                            snapshot.data!['business name'],
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 8, 8, 8))),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 05),
                                      child: Container(
                                        child: Text(snapshot.data!['Number'],
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 8, 8, 8))),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 15),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Edit_details(
                                                Category: snapshot
                                                    .data!['business category'],
                                                business_nme: snapshot
                                                    .data!['business name'],
                                                name:
                                                    snapshot.data!['username'],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          // ignore: sort_child_properties_last
                                          child: Center(
                                            child: Text("Edit",
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 17,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255))),
                                          ),
                                          // color: Colors.red,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .06,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .35,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(245, 0, 0, 0),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                        61, 23, 24, 25)
                                                    .withOpacity(0.3),
                                                spreadRadius: 0,
                                                blurRadius: 10,
                                                // offset: Offset(0, 2),
                                              ),
                                              //you can set more BoxShadow() here
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * .085,
                            width: MediaQuery.of(context).size.width * .90,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(245, 0, 0, 0),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text("Store Address",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width * .90,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5, left: 8),
                                child: Text(snapshot.data!['Personal mobile'],
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 8, 8, 8))),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .85,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 3,
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(snapshot.data!['name'],
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 8, 8, 8))),
                              ),
                            ),
                          ),
                          Container(
                            // color: Colors.red,
                            // height: MediaQuery.of(context).size.height * .03,
                            width: MediaQuery.of(context).size.width * .85,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(snapshot.data!['Email'],
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 8, 8, 8))),
                            ),
                          ),
                          Container(
                            // color: Colors.red,
                            // height: MediaQuery.of(context).size.height * .03,
                            width: MediaQuery.of(context).size.width * .85,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                child: Text(
                                    address[0] + " , " + address[1] + ",",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: wid * 0.045,
                                        color: Color.fromARGB(255, 8, 8, 8))),
                              ),
                            ),
                          ),
                          Container(
                            // color: Colors.red,
                            // height: MediaQuery.of(context).size.height * .03,
                            width: MediaQuery.of(context).size.width * .85,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                width: 200,
                                child: Text(
                                    address[2] + " - " + address[3] + ",",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: wid * 0.045,
                                        color: Color.fromARGB(255, 8, 8, 8))),
                              ),
                            ),
                          ),
                          Container(
                            // color: Colors.red,
                            // height: MediaQuery.of(context).size.height * .03,
                            width: MediaQuery.of(context).size.width * .85,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                width: 200,
                                child: Text(address[4] + ",",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: wid * 0.045,
                                        color: Color.fromARGB(255, 8, 8, 8))),
                              ),
                            ),
                          ),
                          Container(
                            // color: Colors.red,
                            // height: MediaQuery.of(context).size.height * .03,
                            width: MediaQuery.of(context).size.width * .85,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                width: 200,
                                child: Text(address[5] + ".",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: wid * 0.045,
                                        color: Color.fromARGB(255, 8, 8, 8))),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                            width: MediaQuery.of(context).size.width * .95,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, bottom: 08),
                                child: InkWell(
                                  onTap: () {
                                    final string =
                                        snapshot.data!['Personal mobile'];
                                    final splitted = string.split(' ');
                                    final funny = splitted[0];
                                    print("funny2:$funny");
                                    final saroja = splitted[1];
                                    print("saroja2:$saroja");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => adminaddress(
                                          snapshot.data!['Personal mobile'],
                                          address[2],
                                          address[5],
                                          address[1],
                                          address[0],
                                          snapshot.data!['name'],
                                          address[3],
                                          address[4],
                                          snapshot.data!['Email'],
                                          funny,
                                          saroja,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(
                                      // ignore: sort_child_properties_last
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 08, left: 12),
                                        child: Text("Change",
                                            style: GoogleFonts.poppins(
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255))),
                                      ),
                                      // color: Colors.red,
                                      width: wid * 0.28,
                                      height: hei * 0.055,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(245, 0, 0, 0),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Color.fromARGB(61, 23, 24, 25)
                                                    .withOpacity(0.3),
                                            spreadRadius: 0,
                                            blurRadius: 10,
                                            // offset: Offset(0, 2),
                                          ),
                                          //you can set more BoxShadow() here
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
