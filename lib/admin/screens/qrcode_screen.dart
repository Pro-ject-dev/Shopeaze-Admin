import 'dart:io';

import 'package:ecommerce/admin/public/variables.dart';
import 'package:ecommerce/admin/public/appbar.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class qrcode extends StatefulWidget {
  const qrcode({super.key});

  @override
  State<qrcode> createState() => _qrcodeState();
}

@override
class _qrcodeState extends State<qrcode> {
  @override
  Widget build(BuildContext context) {
    var hei = MediaQuery.of(context).size.height;
    var wid = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(hei * 0.075),
          child: appbar(
            prefixicon: const Icon(Icons.arrow_back_sharp),
            title: "QRCODE",
          ), //appbar--------->widgets
        ),
        body: Column(
          children: [
            SizedBox(
              height: hei * 0.12,
            ),
            Stack(children: [
              Container(
                child: Stack(children: [
                  Center(
                    child: Container(
                      height: hei * 0.55,
                      width: wid * 0.84,
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(1, 4),
                                blurRadius: 4,
                                color: Color.fromARGB(255, 210, 210, 210))
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  Center(
                    child: Container(
                      // ignore: sort_child_properties_last
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Text(
                          "SCAN AND ORDER",
                          style: GoogleFonts.poppins(
                              fontSize: wid * 0.05, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      height: hei * 0.21,
                      width: wid * 0.84,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 125, 124, 124),

                          //color: const Color.fromARGB(255, 125, 124, 124),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2,
                                color: Color.fromARGB(255, 231, 231, 231))
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                    ),
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Column(children: [
                  Center(
                    child: SizedBox(
                        width: wid * 0.8,
                        height: hei * 0.23,
                        child: Image.asset("assets/qrcode1.png")),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 23.0),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          icon(
                            hei: hei,
                            wid: wid,
                            image: 'assets/order.png',
                            txt1: "PRE ORDER",
                            txt2: "FROM HOME &",
                            txt3: "PICKUP",
                            txt4: "FROM STORE",
                          ),
                          divider(),
                          icon(
                            hei: hei,
                            wid: wid,
                            image: 'assets/scooty.png',
                            txt1: "ORDER",
                            txt2: "HOME",
                            txt3: "DELIVERY",
                          ),
                          divider(),
                          icon(
                            hei: hei,
                            wid: wid,
                            image: 'assets/os.png',
                            txt1: "ORDER",
                            txt2: "AT STORE &",
                            txt3: "GET HANDOVER.",
                            txt4: "BEAT THE QUEUE",
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(b_name,
                      style: GoogleFonts.poppins(
                          fontSize: wid * 0.038, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  Text("powered by",
                      style: GoogleFonts.poppins(
                          fontSize: wid * 0.018, fontWeight: FontWeight.w600)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.delivery_dining_rounded,
                          color: Color.fromARGB(255, 160, 160, 160)),
                      const SizedBox(
                        width: 5,
                      ),
                      Text("Shopeaze",
                          style: GoogleFonts.poppins(
                              fontSize: wid * 0.038,
                              fontWeight: FontWeight.w600)),
                    ],
                  )
                ]),
              ),
            ]),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: wid * 0.8,
              height: hei * 0.054,
              child: MaterialButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                // ignore: sort_child_properties_last
                child: Text("SHARE QR CODE",
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontWeight: FontWeight.w500)),
                color: const Color.fromARGB(255, 125, 124, 124),
              ),
            )
          ],
        ));
  }

  VerticalDivider divider() {
    return const VerticalDivider(
      color: Colors.black,
      width: 0.1,
      thickness: 1,
      indent: 10,
      endIndent: 0.1,
    );
  }
}

class icon extends StatelessWidget {
  const icon({
    Key? key,
    required this.hei,
    required this.wid,
    this.txt1,
    this.txt2,
    this.txt3,
    this.txt4,
    this.image,
  }) : super(key: key);

  final hei;
  final wid;
  final txt1;

  final txt2;

  final txt3;
  final txt4;

  final image;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
          height: hei * 0.045, width: wid * 0.2, child: Image.asset(image)),
      text(title: txt1),
      text(title: txt2),
      text(title: txt3),
      text(title: txt4),
    ]);
  }
}

class text extends StatelessWidget {
  final title;
  text({this.title});

  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;
    if (title != null) {
      return Text(
        title,
        style: GoogleFonts.lato(
          color: const Color.fromARGB(255, 126, 126, 126),
          fontSize: wid * 0.025,
          fontWeight: FontWeight.w600,
          textStyle:
              const TextStyle(letterSpacing: 0.2, wordSpacing: 0.2, shadows: [
            Shadow(
              blurRadius: 1.0,
              color: Color.fromARGB(227, 210, 210, 210),
            ),
          ]),
        ),
      );
    }
    return Container();
  }
}
