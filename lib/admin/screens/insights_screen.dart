import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/admin/public/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class insights extends StatefulWidget {
  const insights({super.key});

  @override
  State<insights> createState() => _insightsState();
}

class _insightsState extends State<insights> {
  var initial = 'Today';
  var items = ['Today', '7 days', '30 days', 'All Time'];
  @override
  Widget build(BuildContext context) {
    var hei = MediaQuery.of(context).size.height;
    var wid = MediaQuery.of(context).size.width;
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Orders')
                .doc(GetStorage().read('mobile'))
                .collection('Orders')
                .snapshots(),
            builder: (context, snapshot) {
              return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Orders')
                      .doc(GetStorage().read('mobile'))
                      .collection('Orders')
                      .where('status', isEqualTo: 'Delivered')
                      .snapshots(),
                  builder: (context, snapshot1) {
                    return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Orders')
                            .doc(GetStorage().read('mobile'))
                            .collection('visits')
                            .snapshots(),
                        builder: (context, snapshot2) {
                          return Column(
                            children: [
                              appbar(
                                title: "Insights",
                                prefixicon: Icon(Icons.arrow_back),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("STORE PERFORMANCE",
                                        style: GoogleFonts.poppins(
                                            fontSize: wid * 0.045,
                                            fontWeight: FontWeight.w500)),
                                    DropdownButton(
                                        value: initial,
                                        items: items.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(
                                              items,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.brown,
                                                  fontSize: wid * 0.028,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            initial = newValue!;
                                          });
                                        }),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: hei * 0.02,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: 30.0, left: 30.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        insights_icon(
                                            hei: hei,
                                            wid: wid,
                                            image: 'assets/store.png',
                                            text: snapshot2.data!.docs.length
                                                .toString(),
                                            title: "visits"),
                                        SizedBox(
                                          height: hei * 0.05,
                                        ),
                                        insights_icon(
                                            hei: hei,
                                            wid: wid,
                                            image: 'assets/sales.png',
                                            text: snapshot1.data!.docs.length
                                                .toString(),
                                            title: "sales"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: hei * 0.03,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        insights_icon(
                                            hei: hei,
                                            wid: wid,
                                            image: 'assets/orders.png',
                                            text: snapshot.data!.docs.length
                                                .toString(),
                                            title: "orders"),
                                        SizedBox(
                                          height: hei * 0.05,
                                        ),
                                        insights_icon(
                                            hei: hei,
                                            wid: wid,
                                            image: 'assets/conversion.png',
                                            text:
                                                ((snapshot1.data!.docs.length /
                                                                snapshot
                                                                    .data!
                                                                    .docs
                                                                    .length) *
                                                            100)
                                                        .roundToDouble()
                                                        .toString() +
                                                    " %",
                                            title: "conversion"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("DATA REPORTS",
                                        style: GoogleFonts.poppins(
                                            fontSize: wid * 0.045,
                                            fontWeight: FontWeight.w500)),
                                    DropdownButton(
                                        value: initial,
                                        items: items.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(
                                              items,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.brown,
                                                  fontSize: wid * 0.028,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            initial = newValue!;
                                          });
                                        }),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: hei * 0.02,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  icon_container(
                                      hei: hei,
                                      wid: wid,
                                      image: 'assets/orders.png',
                                      text: 'orders'),
                                  icon_container(
                                      hei: hei,
                                      wid: wid,
                                      image: 'assets/sales.png',
                                      text: 'Performance'),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("TOP LISTS",
                                        style: GoogleFonts.poppins(
                                            fontSize: wid * 0.045,
                                            fontWeight: FontWeight.w500)),
                                    DropdownButton(
                                        value: initial,
                                        items: items.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(
                                              items,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.brown,
                                                  fontSize: wid * 0.028,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            initial = newValue!;
                                          });
                                        }),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: hei * 0.01,
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("1.",
                                            style: GoogleFonts.poppins(
                                                color: Colors.brown,
                                                fontSize: wid * 0.028,
                                                fontWeight: FontWeight.w700)),
                                        textwidget(
                                            text: 'Sample Product',
                                            wid: wid,
                                            title: '10 oct 22'),
                                        textwidget(
                                            text: '615',
                                            wid: wid,
                                            title: 'Sales'),
                                        textwidget(
                                            text: '4',
                                            wid: wid,
                                            title: 'Orders'),
                                        Icon(
                                          Icons.share,
                                          size: 18,
                                          color: Colors.brown,
                                        ),
                                      ],
                                    ),
                                    Divider()
                                  ],
                                ),
                              )
                            ],
                          );
                        });
                  });
            }));
  }
}

class icon_container extends StatelessWidget {
  const icon_container({
    Key? key,
    required this.hei,
    required this.wid,
    required this.image,
    required this.text,
  }) : super(key: key);

  final double hei;
  final double wid;
  final image;
  final text;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: hei * 0.15,
        width: wid * 0.35,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: 2,
              offset: Offset(2, 2),
              color: Color.fromARGB(255, 206, 206, 206))
        ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 10),
                height: hei * 0.11,
                width: wid * 0.25,
                child: ImageIcon(
                  AssetImage(image),
                )),
            SizedBox(
              height: hei * 0.005,
            ),
            Container(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                    color: Colors.brown,
                    fontSize: wid * 0.04,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ));
  }
}

class insights_icon extends StatelessWidget {
  const insights_icon({
    Key? key,
    required this.hei,
    required this.wid,
    required this.image,
    required this.text,
    required this.title,
  }) : super(key: key);

  final double hei;
  final double wid;
  final image, text, title;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Container(
            height: hei * 0.06,
            width: wid * 0.12,
            child: ImageIcon(
              AssetImage(image),
            )),
        SizedBox(width: wid * 0.035),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: GoogleFonts.poppins(
                  color: Colors.brown,
                  fontSize: wid * 0.045,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: wid * 0.035,
                  fontWeight: FontWeight.w500),
            )
          ],
        )
      ],
    ));
  }
}

class textwidget extends StatelessWidget {
  const textwidget({
    Key? key,
    required this.text,
    required this.wid,
    required this.title,
  }) : super(key: key);

  final text;
  final double wid;
  final title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: GoogleFonts.poppins(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: wid * 0.035,
              fontWeight: FontWeight.w700),
        ),
        Text(
          title,
          style: GoogleFonts.poppins(
              color: Color.fromARGB(255, 170, 170, 170),
              fontSize: wid * 0.035,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
