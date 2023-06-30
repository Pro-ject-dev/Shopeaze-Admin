// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_unnecessary_containers, prefer_const_constructors, curly_braces_in_flow_control_structures
import 'package:ecommerce/admin/screens/AddProductScreen.dart';
import 'package:ecommerce/admin/screens/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

// ignore: camel_case_types
class update_table extends StatefulWidget {
  const update_table({super.key});

  @override
  State<update_table> createState() => _update_tableState();
}

// ignore: camel_case_types
class _update_tableState extends State<update_table> {
  String searchvalue = "";
  var doc = GetStorage().read('mobile');

  urlsaro(String saro) {
    Share.share(
      'check out my website $saro',
      subject: 'Thank You',
    );
  }

  // ignore: unnecessary_new
  imagesaro(String imge) => new Image.network(
        imge,
        fit: BoxFit.fill,
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("products")
                .doc(doc)
                .collection('products')
                .snapshots(),

            // ignore: non_constant_identifier_names
            builder: (context, Snapshot) {
              if (!Snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              // ignore: unrelated_type_equality_checks
              if (Snapshot.requireData == false) {
                return Scaffold(
                  body: Column(
                    children: [
                      Container(
                        child: Text("No Data Found"),
                      )
                    ],
                  ),
                );
              }

              return SingleChildScrollView(
                child: Column(children: [
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
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      // physics: ScrollPhysics(),
                      // scrollDirection: Axis.vertical,
                      itemCount: Snapshot.data!.docs
                          .where((element) => element['Product_name']
                              .toString()
                              .toLowerCase()
                              .contains(searchvalue.toLowerCase()))
                          .length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot = Snapshot
                            .data!.docs
                            .where((element) => element['Product_name']
                                .toString()
                                .toLowerCase()
                                .contains(searchvalue.toLowerCase()))
                            .toList()[index];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 5, left: 10, right: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => edit_product(
                                            image1: documentSnapshot['image'],
                                            image2: documentSnapshot['url_2'],
                                            image3: documentSnapshot['url_3'],
                                            image4: documentSnapshot['url_4'],
                                            image5: documentSnapshot['url_5'],
                                            selling_price: documentSnapshot[
                                                'Selling_price'],
                                            product_name: documentSnapshot[
                                                'Product_name'],
                                            description:
                                                documentSnapshot['Description'],
                                            redced_price: documentSnapshot[
                                                'Reduced_price'])),
                                  );
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * .17,
                                  width:
                                      MediaQuery.of(context).size.width * .95,
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
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(9.5),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .32,
                                          // color: Color.fromARGB(255, 86, 218, 255),
                                          decoration: BoxDecoration(
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
                                                              'Product_name'],
                                                          style: GoogleFonts
                                                              .poppins(
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 50),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10),
                                                        child: InkWell(
                                                          onTap: () {
                                                            urlsaro(
                                                                documentSnapshot[
                                                                    'image']);
                                                          },
                                                          child: Container(
                                                            // color: Colors.red,
                                                            // ignore: prefer_const_constructors
                                                            child: Icon(
                                                              Icons.share,
                                                              size: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
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
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, right: 110),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .20,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .05,
                                                  // color: Colors.red,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "₹ " +
                                                            documentSnapshot[
                                                                'Selling_price'],
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        104,
                                                                        101,
                                                                        101),
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        "₹ " +
                                                            documentSnapshot[
                                                                'Reduced_price'],
                                                        style:
                                                            GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      104,
                                                                      101,
                                                                      101),
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 3.9),
                                                  child: Container(
                                                    // color: Colors.red,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .06,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .03,
                                                    // color: Colors.red,
                                                    child: Align(
                                                        alignment: Alignment
                                                            .bottomLeft,
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
                                                StreamBuilder<QuerySnapshot>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'orders count')
                                                        .doc(GetStorage()
                                                            .read('mobile'))
                                                        .collection('products')
                                                        .snapshots(),
                                                    builder: (context, snap5) {
                                                      print(snap5
                                                          .data!.docs.length);
                                                      return Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .12,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .03,
                                                        // color: Colors.red,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          child: Text(
                                                            snap5
                                                                .data!
                                                                .docs[index]
                                                                    ['count']
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: Color
                                                                  .fromARGB(255,
                                                                      0, 0, 0),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
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
                                                StreamBuilder<QuerySnapshot>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection('Orders')
                                                        .doc(GetStorage()
                                                            .read('mobile'))
                                                        .collection('views')
                                                        .doc(documentSnapshot[
                                                            'Product_name'])
                                                        .collection('views')
                                                        .snapshots(),
                                                    builder: (context, snap) {
                                                      return Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .10,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .03,
                                                        // color: Colors.red,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          child: Text(
                                                            snap.data!.docs
                                                                .length
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: Color
                                                                  .fromARGB(255,
                                                                      0, 0, 0),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 3),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .07,
                                                    height:
                                                        MediaQuery.of(context)
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
                                                                bottom: 01),
                                                        child: Icon(Icons
                                                            .favorite_border),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 2),
                                                  child: StreamBuilder<
                                                          QuerySnapshot>(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection('Orders')
                                                          .doc(GetStorage()
                                                              .read('mobile'))
                                                          .collection('views')
                                                          .doc(documentSnapshot[
                                                              'Product_name'])
                                                          .collection('likes')
                                                          .snapshots(),
                                                      builder:
                                                          (context, snap2) {
                                                        return Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .09,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .03,
                                                          // color: Colors.red,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .bottomLeft,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 01,
                                                                      bottom:
                                                                          01),
                                                              child: Text(
                                                                snap2.data!.docs
                                                                    .length
                                                                    .toString(),
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
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
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ]),
              );
            }));
  }
}
