import 'package:ecommerce/admin/screens/qrcode_screen.dart';
import 'package:ecommerce/admin/public/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_share/flutter_share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class customer extends StatefulWidget {
  const customer({super.key});

  @override
  State<customer> createState() => _customerState();
}

class _customerState extends State<customer> {
  var status;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var hei = MediaQuery.of(context).size.height;
    var wid = MediaQuery.of(context).size.width;
    var link = "https://urordr.at/demoui";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(hei * 0.075),
        child: appbar(
          prefixicon: Icon(Icons.arrow_back_sharp),
          suffixicon: Icon(Icons.search),
          title: "CUSTOMERS",
        ),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: SizedBox(
                height: hei * 0.3,
                width: wid * 1,
                child: Image.asset('assets/img3.jpg')),
          ),
          TEXT(wid, "CUSTOMERS WILL APPEAR ONCE ORDERS", Colors.black, 0.04,
              FontWeight.w500),
          const SizedBox(
            height: 15,
          ),
          TEXT(
              wid,
              "In the meantime get orders on your store by sharing Your store link with your customers over WhatsApp and social media to maximise outreach.",
              const Color.fromARGB(255, 125, 124, 124),
              0.031,
              FontWeight.w500),
          const SizedBox(
            height: 15,
          ),
          TEXT(wid, link, Colors.blue, 0.04, FontWeight.w500),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ICONS(hei, "assets/share.png", "Share", wid, () {
                  share();
                }),
                ICONS(hei, "assets/copy.png", "Copy", wid, () {
                  Clipboard.setData(ClipboardData(text: link));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                    'link copied successfully',
                  )));
                }),
                ICONS(hei, "assets/qrcode.png", "QR Code", wid, () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => qrcode())));
                }),
                ICONS(hei, "assets/copyy.png", "Open", wid, () {
                  launchUrl(Uri.parse('https://www.google.com'));
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector ICONS(double hei, var image, text, double wid, var click) {
    return GestureDetector(
      onTap: click,
      child: Column(
        children: [
          SizedBox(height: hei * 0.09, child: Image.asset(image)),
          Text(text,
              style: GoogleFonts.poppins(
                  fontSize: wid * 0.035, fontWeight: FontWeight.w500))
        ],
      ),
    );
  }

  Row TEXT(double wid, var text, var color, var f_size, var bold) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: wid * 0.98,
          child: Text(text,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: wid * f_size, color: color, fontWeight: bold)),
        )
      ],
    );
  }
}

void share() async {
  await FlutterShare.share(
    title: 'Selling with Shopeaze',
    text:
        'ordering from our store is easier than ever before. Now you can quickly create your order by clicking on https://www.google.com. on checkout,you will be asked to send the order by WhatsApp to confirm. we will get in touch to handle payments and further actions. So stay safe and continue enjoying our products. ',
    linkUrl: ' https://www.google.com',
  );
}
