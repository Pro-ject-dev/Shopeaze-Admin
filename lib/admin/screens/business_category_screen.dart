import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/admin/screens/buildapp_screen.dart';
import 'package:ecommerce/admin/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

List<Map<String, dynamic>> businessCategory = [
  {
    "img": "assets/retail.png",
    "name": "Retail & convenience",
  },
  {
    'img': "assets/vegitable.png",
    "name": "Vegetable & Grocery",
  },
  {
    "img": "assets/restaurant.png",
    "name": "Restaurant & Kiosks",
  },
  {
    "img": "assets/bakeries.png",
    "name": "Bakeries & spacialty",
  },
  {
    "img": "assets/fashion.png",
    "name": "Fashion & Accessories",
  },
  {
    "img": "assets/electronics.png",
    "name": "Electronies & Mobile",
  },
  {
    "img": "assets/handmade.png",
    "name": "Handmade & Gifting",
  },
  {
    "img": "assets/other.png",
    "name": "Something else",
  },
];

class ChooseBusiness extends StatefulWidget {
  @override
  State<ChooseBusiness> createState() => _ChooseBusinessState();
  final mobile;
  ChooseBusiness({this.mobile});
}

class _ChooseBusinessState extends State<ChooseBusiness> {
  final getstorage = GetStorage();

  var selectedIndex;
  var formKey = GlobalKey<FormState>();

  var businessName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: const Text(
                    'Set business details...',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
// fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: businessName,
                  decoration: const InputDecoration(
                    hintText: 'Business name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter business name';
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: const Text(
                    'Pick a category',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: businessCategory.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) => ClipRRect(
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        tileColor:
                            selectedIndex == index ? Colors.blue[200] : null,
                        title: Column(
                          children: [
                            Image.asset(
                              businessCategory[index]['img'],
                              width: size.width / 5,
                              height: size.width / 5,
                            ),
                            Text(
                              businessCategory[index]['name'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'Poppins-Regular',
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      if (selectedIndex == null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text(
                          'Select category of business',
                        )));
                      } else {
                        storeCategory(
                          businessName.text,
                          businessCategory[selectedIndex]['name'],
                        )
                            .then((value) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage())))
                            .then((value) => ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        content: Text(
                                  'Business created successfully',
                                ))));
                      }
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 35),
                    padding: const EdgeInsets.all(17),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xff1F1F1F),
                              Color(0xff888C94),
                            ])),
                    child: const Text(
                      'Done',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> storeCategory(
    String businessname,
    String businesscategory,
  ) async {
    var uid = widget.mobile;
    if (uid == null) {
      var key = getstorage.read('mobile');
      uid = key;
    }
    await FirebaseFirestore.instance.collection('user').doc(uid).update({
      "business name": businessname,
      "business category": businesscategory,
      "image":
          'https://th.bing.com/th/id/OIP.Sd2PZhst-BvsHGfYMdDjDgHaHZ?pid=ImgDet&w=192&h=192&c=7&dpr=1.5'
    });
  }
}
