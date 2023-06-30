import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/admin/screens/adminaddress.dart';
import 'package:ecommerce/admin/screens/buildapp_screen.dart';
import 'package:ecommerce/admin/screens/customers_screen.dart';
import 'package:ecommerce/admin/screens/insights_screen.dart';
import 'package:ecommerce/admin/screens/order_screen.dart';
import 'package:ecommerce/admin/screens/order_view.dart';
import 'package:ecommerce/admin/screens/profile.dart';
import 'package:ecommerce/admin/widgets/viewproduct_widgets/get_details.dart';
import 'package:ecommerce/admin/screens/sales_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var status_color;
  @override
  Widget build(BuildContext context) {
    var hei = MediaQuery.of(context).size.height;
    var wid = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Store name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          actions: [
            Container(
              padding: EdgeInsets.all(5),
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 2, color: Colors.teal)),
                icon: const Icon(Icons.store),
                onPressed: () {},
                label: const Text(
                  'view',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('user')
                    .doc(GetStorage().read('mobile'))
                    .snapshots(),
                builder: (context, snapshot) {
                  return GestureDetector(
                    onTap: () {
                      if (snapshot.data!['address'] == null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => adminaddress("", "", "",
                                    "", "", "", "", "", "", "+91", ""))));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => profile())));
                      }
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(snapshot.data!['image']),
                    ),
                  );
                }),
            SizedBox(
              width: 5,
            )
          ],
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              const CarouselContainer(),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'QUICK LINKS',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(width: 2, color: Colors.teal)),
                    icon: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Icon(Icons.help_center),
                    ),
                    onPressed: () {},
                    label: const Text(
                      'Help',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              //links
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => summa())));
                    },
                    child: Column(children: [
                      Image.asset(
                        'assets/catalog.png',
                        height: 50,
                        width: 50,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Catalog',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => sales())));
                    },
                    child: Column(children: [
                      Image.asset(
                        'assets/grow.png',
                        height: 50,
                        width: 50,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Grow',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => insights())));
                    },
                    child: Column(children: [
                      Image.asset(
                        'assets/insight.png',
                        height: 50,
                        width: 50,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Insights',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => customer())));
                    },
                    child: Column(children: [
                      Image.asset(
                        'assets/customers.png',
                        height: 50,
                        width: 50,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Customers',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => buildapp())));
                    },
                    child: Column(children: [
                      Image.asset(
                        'assets/settings.png',
                        height: 50,
                        width: 50,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ]),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => sales())));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.teal,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            SizedBox(
                              child: Text(
                                'Promote your business',
                                style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900),
                              ),
                              width: 200,
                            ),
                            SizedBox(
                              child: Text(
                                'Simple do-it-yourself',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              width: 250,
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            Expanded(
                                child: Image.asset(
                              'assets/announcemnt.png',
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'RECENT ORDERS',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(width: 2, color: Colors.teal)),
                    icon: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Icon(Icons.shopping_bag),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => order_details()));
                    },
                    label: const Text(
                      'All Orders',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Orders')
                      .doc(GetStorage().read('mobile'))
                      .collection('Orders')
                      .orderBy('order_time')
                      .limit(2)
                      .snapshots(),
                  builder: ((context, snapshot) {
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text(
                          "No Orders Found",
                          style: GoogleFonts.poppins(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: wid * 0.038,
                              fontWeight: FontWeight.w400),
                        ),
                      );
                    }
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;
                    if (snapshot.hasData) {
                      return Center(
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              child: ListView.builder(
                                  primary: true,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.all(10),
                                  physics: const ScrollPhysics(),
                                  itemCount: documents.length,
                                  itemBuilder: ((context, index) {
                                    if (documents[index]['status'] ==
                                        'Pending Confirmation') {
                                      status_color = Colors.orange;
                                    }
                                    if (documents[index]['status'] ==
                                        'Processing') {
                                      status_color = Colors.green;
                                    }
                                    if (documents[index]['status'] ==
                                        'Delivered') {
                                      status_color = Colors.black;
                                    }
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Orderview(
                                                          // doc: documents[index]
                                                          // ['doc'],
                                                          status:
                                                              documents[index]
                                                                  ['status'],
                                                          order_id:
                                                              documents[index]
                                                                  ['order_id'],
                                                          datetime: documents[
                                                                      index][
                                                                  'order_date'] +
                                                              "," +
                                                              documents[index][
                                                                  'order_time'],
                                                          ordermode: documents[
                                                                  index][
                                                              'customer_order_type'],
                                                          customer_Mobile:
                                                              documents[index][
                                                                  'customer_phone'],
                                                          customer_address:
                                                              documents[index][
                                                                  'customer_address'],
                                                          customer_name: documents[
                                                                  index]
                                                              ['customer_name'],
                                                          status_color:
                                                              status_color,
                                                          dox: documents[index]
                                                              ['doc'],
                                                        )));
                                          },
                                          child: Container(
                                              height: hei * 0.18,
                                              width: wid * 0.93,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        blurRadius: 10,
                                                        offset: Offset(1, 1),
                                                        color: Color.fromARGB(
                                                            255, 234, 234, 234))
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          top: 10,
                                                          right: 10),
                                                  child: Column(children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 50,
                                                          child:
                                                              ListView.builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemCount: int.parse(
                                                                      documents[
                                                                              index]
                                                                          [
                                                                          'length']),
                                                                  itemBuilder:
                                                                      (context,
                                                                          ind2) {
                                                                    return Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                8),
                                                                        child: Row(
                                                                            children: [
                                                                              Container(
                                                                                color: Color.fromARGB(255, 225, 225, 225),
                                                                                height: hei * 0.055,
                                                                                width: wid * 0.12,
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(4.0),
                                                                                  child: Image.network(
                                                                                    documents[index]['product_image']['[$ind2]'],
                                                                                    height: hei * 0.07,
                                                                                    width: wid * 0.14,
                                                                                    fit: BoxFit.fill,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ]));
                                                                  }),
                                                        ),
                                                        Container(
                                                          height: 50,
                                                          child:
                                                              ListView.builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemCount: int.parse(
                                                                      documents[
                                                                              index]
                                                                          [
                                                                          'length']),
                                                                  itemBuilder:
                                                                      (context,
                                                                          ind2) {
                                                                    return Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              8),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Text(
                                                                              documents[index]['product_name']['[$ind2]'],
                                                                              style: GoogleFonts.poppins(color: Color.fromARGB(255, 70, 70, 70), fontSize: wid * 0.038, fontWeight: FontWeight.w600)),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }),
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                documents[index]
                                                                    [
                                                                    'order_id'],
                                                                style: GoogleFonts.poppins(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            26,
                                                                            26,
                                                                            26),
                                                                    fontSize:
                                                                        wid *
                                                                            0.038,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                            Text(
                                                                "₹ " +
                                                                    documents[
                                                                            index]
                                                                        [
                                                                        'grand_total'] +
                                                                    ".00",
                                                                style: GoogleFonts.readexPro(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            26,
                                                                            26,
                                                                            26),
                                                                    fontSize:
                                                                        wid *
                                                                            0.038,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600))
                                                          ],
                                                        ),
                                                        SizedBox(height: 2),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                documents[index]
                                                                        [
                                                                        'order_date'] +
                                                                    "," +
                                                                    documents[
                                                                            index]
                                                                        [
                                                                        'order_time'],
                                                                style: GoogleFonts.poppins(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        wid *
                                                                            0.028,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                            Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          73,
                                                                          73,
                                                                          73),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          3.0),
                                                                  child: Text(
                                                                      documents[
                                                                              index][
                                                                          'customer_order_type'],
                                                                      style: GoogleFonts.poppins(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255),
                                                                          fontSize: wid *
                                                                              0.028,
                                                                          textStyle: TextStyle(
                                                                              letterSpacing:
                                                                                  0.8),
                                                                          fontWeight:
                                                                              FontWeight.w600)),
                                                                ))
                                                          ],
                                                        ),
                                                        SizedBox(height: 7),
                                                        Row(
                                                          children: [
                                                            CircleAvatar(
                                                                radius: 4.5,
                                                                backgroundColor:
                                                                    status_color),
                                                            SizedBox(width: 5),
                                                            Text(
                                                                documents[index]
                                                                    ['status'],
                                                                style: GoogleFonts.poppins(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        wid *
                                                                            0.035,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ]))),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    );
                                  })),
                            )
                          ],
                        ),
                      );
                    }
                    return Center(child: Text("No Orders found"));
                  }))
            ])));
  }
}

//carousel

class CarouselContainer extends StatelessWidget {
  const CarouselContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var slideWidth = size.width * 0.73;
    return Container(
      child: CarouselSlider(
        items: [
          Container(
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(15),
            ),
            width: slideWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //  crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Image.asset(
                    "assets/store.png",
                    height: 70,
                    width: 70,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    'Customize your online store ',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.concertOne(
                      textStyle:
                          const TextStyle(fontSize: 25, color: Colors.red),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(15),
            ),
            width: slideWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //  crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Image.asset(
                    "assets/chat.png",
                    height: 70,
                    width: 70,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    'Your review means the world to us ',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.concertOne(
                      textStyle:
                          const TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(15),
            ),
            width: slideWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Image.asset(
                    "assets/new-product.png",
                    height: 70,
                    width: 70,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    'Check out the new features relased ',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.concertOne(
                      textStyle:
                          const TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(15),
            ),
            width: slideWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //  crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Image.asset(
                    "assets/friendship.png",
                    height: 70,
                    width: 70,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    'Share your store link for customers to place orders ',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.concertOne(
                      textStyle:
                          const TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(15),
            ),
            width: slideWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //  crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Image.asset(
                    "assets/smartphone.png",
                    height: 70,
                    width: 70,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    'Refer your friends and unlock rewards ',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.concertOne(
                      textStyle:
                          const TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 13 / 5,
        ),
      ),
    );
  }
}
