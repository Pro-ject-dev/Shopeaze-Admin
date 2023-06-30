// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/admin/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class Orderview extends StatefulWidget {
  final order_id,
      datetime,
      status_color,
      ordermode,
      customer_address,
      customer_Mobile,
      customer_name,
      status,
      dox;

  Orderview({
    required this.order_id,
    required this.datetime,
    required this.customer_name,
    required this.customer_address,
    required this.customer_Mobile,
    required this.status,
    required this.ordermode,
    required this.status_color,
    required this.dox,
  });

  @override
  State<Orderview> createState() => _OrderviewState();
}

class _OrderviewState extends State<Orderview> {
  @override
  void initState() {
    oreders_count();
    super.initState();
  }

  var order;
  List items = [];
  List quant = [];
  String doc = "";

  String product_name = "";
  String order_id = "";
  String datetime = "";
  Color status_color = Colors.red;
  String total = "";
  String quantity = "";
  String price = "";
  String ordermodes = "";
  String customer_address = "";
  String customer_Mobile = "";
  String customer_name = "";
  String dox = "";

  setdata() {
    setState(() {
      order_id = widget.order_id;
      datetime = widget.datetime;
      status_color = widget.status_color;
      ordermodes = widget.ordermode;
      customer_address = widget.customer_address;
      customer_Mobile = widget.customer_Mobile;
      customer_name = widget.customer_name;
      status = widget.status;
      dox = widget.dox;
    });
  }

  var customer = FirebaseFirestore.instance
      .collection('Orders')
      .doc(GetStorage().read('mobile'))
      .collection("Orders");
  var ch = "Pending Confirmation";
  update(length) {
    if (widget.status == 'Pending Confirmation') {
      setState(() {
        ch = "Processing";
      });
    }
    if (widget.status == 'Processing') {
      setState(() {
        ch = "Delivered";
        store_order_count(length);
      });
    }
    FirebaseFirestore.instance
        .collection('Orders')
        .doc(widget.customer_Mobile)
        .collection("Orders")
        .doc(widget.dox)
        .update({'status': ch})
        .whenComplete(
            () => customer.doc(widget.dox.toString()).update({'status': ch}))
        .whenComplete(() => Navigator.pop(context));
  }

  can() {
    setState(() {
      ch = "Cancelled";
    });
    FirebaseFirestore.instance
        .collection('Orders')
        .doc(widget.customer_Mobile)
        .collection("Orders")
        .doc(widget.dox)
        .update({
          "status": ch,
        })
        .whenComplete(() => customer.doc(widget.dox).update({
              "status": ch,
            }))
        .whenComplete(() => Navigator.pop(context));
  }

  var status;
  bool state = false;
  bool process = false;
  bool delivered = false;
  bool cancel = false;
  bool buttonoff = true;
  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;
    final hei = MediaQuery.of(context).size.height;
    if (widget.status == 'Pending Confirmation') {
      setState(() {
        status = "Pending";
        state = true;
      });
    }
    if (widget.status == 'Processing') {
      setState(() {
        process = true;
      });
    }
    if (widget.status == 'Delivered') {
      setState(() {
        process = true;
        delivered = true;
        buttonoff = false;
      });
    }
    if (widget.status == 'Cancelled') {
      setState(() {
        process = true;
        delivered = true;
        cancel = true;
        buttonoff = false;
      });
    }
    return Scaffold(
        appBar:
            AppBar(title: Text("Order Details"), backgroundColor: Colors.grey),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Orders')
                      .doc(GetStorage().read('mobile'))
                      .collection('Orders')
                      .doc(widget.dox.toString())
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Container(
                            height: 19,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: int.parse(snapshot.data!['length']),
                                itemBuilder: (context, ind) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 2),
                                    child: Row(
                                      children: [
                                        Text(
                                            snapshot.data!['product_name']
                                                    ['[$ind]'] +
                                                ",",
                                            style: GoogleFonts.poppins(
                                                color: Color.fromARGB(
                                                    255, 26, 26, 26),
                                                fontSize: wid * 0.038,
                                                fontWeight: FontWeight.w600))
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.order_id,
                                  style: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 26, 26, 26),
                                      fontSize: wid * 0.038,
                                      fontWeight: FontWeight.w600)),
                              Row(
                                children: [
                                  CircleAvatar(
                                      radius: 4.5,
                                      backgroundColor: widget.status_color),
                                  SizedBox(width: 5),
                                  Text(
                                      state ? status : snapshot.data!['status'],
                                      style: GoogleFonts.poppins(
                                          color: Colors.grey,
                                          fontSize: wid * 0.035,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.datetime,
                                    style: GoogleFonts.poppins(
                                        color:
                                            Color.fromARGB(255, 213, 213, 213),
                                        fontSize: wid * 0.032,
                                        fontWeight: FontWeight.w600)),
                              ]),
                          SizedBox(height: 10),
                          Divider(
                            thickness: 2,
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: 13,
                                  backgroundColor: Colors.orange,
                                  child: Text("1",
                                      style: GoogleFonts.poppins(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: wid * 0.032,
                                          fontWeight: FontWeight.w600))),
                              SizedBox(width: 15),
                              Text("Pending Confirmation",
                                  style: GoogleFonts.poppins(
                                      color: Colors.orange,
                                      fontSize: wid * 0.035,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: 13,
                                  backgroundColor:
                                      process ? Colors.orange : Colors.white,
                                  child: Text("2",
                                      style: GoogleFonts.poppins(
                                          color: process
                                              ? Colors.white
                                              : Color.fromARGB(255, 0, 0, 0),
                                          fontSize: wid * 0.032,
                                          fontWeight: FontWeight.w600))),
                              SizedBox(width: 15),
                              Text("Processing",
                                  style: GoogleFonts.poppins(
                                      color:
                                          process ? Colors.orange : Colors.grey,
                                      fontSize: wid * 0.035,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: 13,
                                  backgroundColor:
                                      delivered ? Colors.orange : Colors.white,
                                  child: Text("3",
                                      style: GoogleFonts.poppins(
                                          color: delivered
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: wid * 0.032,
                                          fontWeight: FontWeight.w600))),
                              SizedBox(width: 15),
                              Text("Completed",
                                  style: GoogleFonts.poppins(
                                      color: delivered
                                          ? Colors.orange
                                          : Colors.grey,
                                      fontSize: wid * 0.035,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: 13,
                                  backgroundColor: cancel
                                      ? Color.fromARGB(255, 242, 42, 11)
                                      : Colors.white,
                                  child: Text("4",
                                      style: GoogleFonts.poppins(
                                          color: cancel
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: wid * 0.032,
                                          fontWeight: FontWeight.w600))),
                              SizedBox(width: 15),
                              Text("Cancelled",
                                  style: GoogleFonts.poppins(
                                      color: cancel
                                          ? Color.fromARGB(255, 255, 7, 7)
                                          : Colors.grey,
                                      fontSize: wid * 0.035,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(
                            thickness: 2,
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text("1 ITEM",
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: wid * 0.038,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Row(
                            children: [
                              Text("",
                                  style: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: wid * 0.038,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Container(
                            height: 60,
                            child: ListView.builder(
                                itemCount: int.parse(snapshot.data!['length']),
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8.0),
                                        child: Text(
                                            snapshot.data!['quantity']
                                                    ['[$index]'] +
                                                " X " +
                                                "₹ " +
                                                snapshot.data!['price']
                                                    ['[$index]'],
                                            style: GoogleFonts.readexPro(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: wid * 0.038,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                      Text(
                                          "₹ " +
                                              snapshot.data!['total_price']
                                                  ['[$index]'] +
                                              ".00",
                                          style: GoogleFonts.readexPro(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: wid * 0.038,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  );
                                }),
                          ),
                          SizedBox(height: 10),
                          Divider(
                            thickness: 2,
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Item Total",
                                  style: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: wid * 0.038,
                                      fontWeight: FontWeight.w600)),
                              Text("₹ " + snapshot.data!['grand_total'] + ".00",
                                  style: GoogleFonts.readexPro(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: wid * 0.038,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Grand Total",
                                  style: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: wid * 0.038,
                                      fontWeight: FontWeight.w600)),
                              Text("₹ " + snapshot.data!['grand_total'] + ".00",
                                  style: GoogleFonts.readexPro(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: wid * 0.038,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(
                            thickness: 2,
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text("ORDER DETAILS",
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: wid * 0.038,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Order mode",
                                  style: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: wid * 0.038,
                                      fontWeight: FontWeight.w600)),
                              Text(widget.ordermode,
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: wid * 0.038,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(
                            thickness: 2,
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text("CUSTOMER DETAILS",
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: wid * 0.038,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text("Name",
                                  style: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: wid * 0.038,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Row(
                            children: [
                              Text(widget.customer_name,
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: wid * 0.038,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text("Mobile",
                                  style: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: wid * 0.038,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Row(
                            children: [
                              Text(widget.customer_Mobile,
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: wid * 0.038,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text("Address",
                                  style: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: wid * 0.038,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: wid * 0.7,
                                child: Text(widget.customer_address,
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontSize: wid * 0.038,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 07,
                          ),
                          Visibility(
                            visible: buttonoff,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 60),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                      ),
                                      onPressed: () {
                                        update(snapshot.data!['length']);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            process ? "Delivery" : "Confirm"),
                                      )),
                                ),
                                // ignore: prefer_const_constructors
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                    ),
                                    onPressed: () {
                                      can();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Cancel"),
                                    )),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                    return Container();
                  })),
        ));
  }

  oreders_count() async {
    final data = await FirebaseFirestore.instance
        .collection('Orders')
        .doc(GetStorage().read('mobile'))
        .collection('Orders')
        .doc(widget.dox.toString())
        .get();
    items.add(data.get('product_name'));
    quant.add(data.get('quantity'));
    print(items);
    print(quant);
  }

  Future store_order_count(length) async {
    print(items[0]['[0]'].toString().length);
    print(items.length);
    for (var i = 0; i < int.parse(length); i++) {
      await FirebaseFirestore.instance
          .collection('orders count')
          .doc(GetStorage().read('mobile'))
          .collection('products')
          .doc(items[0]['[$i]'].toString())
          .update({'count': FieldValue.increment(int.parse(quant[0]['[$i]']))});
    }
  }
}
