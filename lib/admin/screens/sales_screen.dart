import 'package:ecommerce/admin/screens/customers_screen.dart';
import 'package:ecommerce/admin/screens/login_screen.dart';
import 'package:ecommerce/admin/widgets/promotebusiness_widgets/cat_card.dart';
import 'package:ecommerce/admin/widgets/promotebusiness_widgets/sales_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class sales extends StatefulWidget {
  const sales({super.key});

  @override
  State<sales> createState() => _salesState();
}

class _salesState extends State<sales> {
  final getstorage = GetStorage();
  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;
    final hei = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: hei * 0.183,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 125, 124, 124),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: Color.fromARGB(255, 134, 134, 134),
                  )
                ],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(49),
                    bottomRight: Radius.circular(49)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, left: 30),
                    child: Column(
                      children: [
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(
                                Icons.arrow_back_ios_outlined,
                                size: 15,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Container(
                              width: wid * 0.4,
                              child: Text(
                                "Grow your brand and sales",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: wid * 0.048),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: SizedBox(
                          height: hei * 0.095,
                          child: Image.asset(
                            'assets/img1.png',
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )),
          SizedBox(height: hei * 0.04),
          const Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 30.0),
            child: sales_card(),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: GestureDetector(
                  onTap: () {},
                  child: cat_card(
                    icon: 'assets/card1.png',
                    title1: "Loyality referrals",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: cat_card(
                  icon: 'assets/card2.png',
                  title1: "offers & coupons",
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: cat_card(
                  icon: 'assets/card3.png',
                  title1: "custom Domain",
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: cat_card(
                    icon: 'assets/card4.png',
                    title1: "Retargergeting Analysis",
                  ),
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: (() {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => customer())));
            }),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 8),
                child: cat_card(
                  icon: 'assets/card5.png',
                  title1: "Visitor Leads",
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
