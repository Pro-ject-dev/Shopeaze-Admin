import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/admin/screens/order_view.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class order_details extends StatefulWidget {
  const order_details({super.key});

  @override
  State<order_details> createState() => _order_detailsState();
}

class _order_detailsState extends State<order_details> {
  var status = "";
  Color status_color = Colors.orange;
  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;
    final hei = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text("Order Details"),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Orders')
                .doc(GetStorage().read('mobile'))
                .collection('Orders')
                .orderBy('order_time')
                .snapshots(),
            builder: ((context, snapshot) {
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              if (snapshot.hasData) {
                return Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
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
                                if (documents[index]['status'] == 'Delivered') {
                                  status_color = Colors.black;
                                }
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        var mobile = documents[index]
                                                ['customer_phone']
                                            .split(" ");

                                        var phone = mobile[0] + mobile[1];

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Orderview(
                                                      // doc: documents[index]
                                                      // ['doc'],
                                                      status: documents[index]
                                                          ['status'],
                                                      order_id: documents[index]
                                                          ['order_id'],
                                                      datetime: documents[index]
                                                              ['order_date'] +
                                                          "," +
                                                          documents[index]
                                                              ['order_time'],
                                                      ordermode: documents[
                                                              index][
                                                          'customer_order_type'],
                                                      customer_Mobile:
                                                          phone.toString(),
                                                      customer_address: documents[
                                                              index]
                                                          ['customer_address'],
                                                      customer_name:
                                                          documents[index]
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
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                  top: 10,
                                                  right: 10),
                                              child: Column(children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 50,
                                                      child: ListView.builder(
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: int.parse(
                                                              documents[index]
                                                                  ['length']),
                                                          itemBuilder:
                                                              (context, ind2) {
                                                            return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8),
                                                                child: Row(
                                                                    children: [
                                                                      Container(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            225,
                                                                            225,
                                                                            225),
                                                                        height: hei *
                                                                            0.055,
                                                                        width: wid *
                                                                            0.12,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              Image.network(
                                                                            documents[index]['product_image']['[$ind2]'],
                                                                            height:
                                                                                hei * 0.07,
                                                                            width:
                                                                                wid * 0.14,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ]));
                                                          }),
                                                    ),
                                                    Container(
                                                      height: 50,
                                                      child: ListView.builder(
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: int.parse(
                                                              documents[index]
                                                                  ['length']),
                                                          itemBuilder:
                                                              (context, ind2) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 8),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                      documents[index]
                                                                              ['product_name']
                                                                          [
                                                                          '[$ind2]'],
                                                                      style: GoogleFonts.poppins(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              70,
                                                                              70,
                                                                              70),
                                                                          fontSize: wid *
                                                                              0.038,
                                                                          fontWeight:
                                                                              FontWeight.w600)),
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
                                                                ['order_id'],
                                                            style: GoogleFonts.poppins(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        26,
                                                                        26,
                                                                        26),
                                                                fontSize:
                                                                    wid * 0.038,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                        Text(
                                                            "₹ " +
                                                                documents[index]
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
                                                                    wid * 0.038,
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
                                                                color:
                                                                    Colors.grey,
                                                                fontSize:
                                                                    wid * 0.028,
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
                                                                      .all(3.0),
                                                              child: Text(
                                                                  documents[index]
                                                                      [
                                                                      'customer_order_type'],
                                                                  style: GoogleFonts.poppins(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      fontSize:
                                                                          wid *
                                                                              0.028,
                                                                      textStyle: TextStyle(
                                                                          letterSpacing:
                                                                              0.8),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
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
                                                                color:
                                                                    Colors.grey,
                                                                fontSize:
                                                                    wid * 0.035,
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
                        ),
                      )
                    ],
                  ),
                );
              }
              return Container();
            })));
  }
}

          // StreamBuilder<QuerySnapshot>(stream:FirebaseFirestore.instance.collection('Orders').doc(Getstorage().read('mobile')))
          
           