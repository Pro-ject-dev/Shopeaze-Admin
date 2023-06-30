// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import 'category_add_screen.dart';

// import 'package:image_picker/image_picker.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';

class AddProductScreen extends StatefulWidget {
  String userr;
  String uss;
  String dropdownvalue;

  AddProductScreen(this.userr, this.uss, this.dropdownvalue);
  @override
  State<AddProductScreen> createState() => _AddProductScreen();
}

class _AddProductScreen extends State<AddProductScreen> {
  String drop = "";

  @override
  void initState() {
    getData();
    super.initState();
    drop = widget.dropdownvalue;
    check();
  }

  getData() async {
    await FirebaseFirestore.instance
        .collection("products")
        .doc(GetStorage().read('mobile'))
        .collection('category')
        .get()
        .then((doc) => {
              doc.docs.forEach((element) {
                print(element['Category']);
                var demo = emailList.add(element["Category"]);
              }),
              setState(() {
                emailList = emailList;
              })
            });
  }

  String? selectedValue;
  check() {
    if (drop == 'null') {
      selectedValue = "--select-category--";
    } else {
      selectedValue = "Others";
    }
  }

  final categorylable = "Category";

  List emailList = ["--select-category--", "Others"];
  final _formKey = GlobalKey<FormState>();

  final _category = TextEditingController();
  final _description = TextEditingController();
  final _product_name = TextEditingController();
  final _reduced_price = TextEditingController();
  final _selling_price = TextEditingController();

  ImagePicker image = ImagePicker();
  bool isdeleteall = true;

  File? file;
  var uuid = const Uuid();
  String url = "";
  List<String> imagesUrls = [];

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  List<XFile>? selectedImages = [];
  void selectImages() async {
    isdeleteall = true;
    final selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.length > 5 ||
        selectedImages.isEmpty ||
        imageFileList.length > 5) {
      imageFileList.clear();
      const snackBar = SnackBar(
        content: Text('Please Add upto 5 images per product'),
        duration: Duration(seconds: 5),
        backgroundColor: Colors.teal,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      imageFileList.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList.length.toString());
    setState(() {});
  }

  uploadFilemulti() async {
    try {
      if (imageFileList.length != 5) {
        const snackBar = SnackBar(
          content: Text('Please Add upto 5 images per product'),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.teal,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        for (var image in imageFileList) {
          EasyLoading.show(status: 'loading...');
          Reference imageFile = FirebaseStorage.instance
              .ref()
              .child(_product_name.text)
              .child(uuid.v4());
          // imageFileList.map((e) => imageFile.putFile(e).whenComplete(() => e));
          await imageFile.putFile(File(image.path)).whenComplete(() async {
            url = await imageFile.getDownloadURL();

            // print(url);
            // //upload code
          });

          imagesUrls.add(url);
        }

        addDataProduct();
        EasyLoading.showSuccess(' Successfully Uploaded!');
        add_orders_count();
        clearTextInput();
        imageFileList.clear();
        const snackBar = SnackBar(
          content: Text('Product is Added'),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.teal,
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        imagesUrls.clear();
      }
    } catch (e) {}
  }

  add_orders_count() {
    FirebaseFirestore.instance
        .collection('orders count')
        .doc(GetStorage().read('mobile'))
        .collection('products')
        .doc(_product_name.text)
        .set({'count': 0});
  }

  clearTextInput() {
    selectedValue = "--select-category--";
    imageFileList.clear();
    _description.clear();
    _product_name.clear();
    _reduced_price.clear();
    _selling_price.clear();
    isdeleteall = false;

    // selectedImages!.clear();
  }

  addDataProduct() {
    try {
      FirebaseFirestore.instance
          .collection("products")
          .doc(GetStorage().read('mobile'))
          .collection('products')
          .doc(_product_name.text.toString())
          .set(
        {
          "Category": selectedValue,
          "Description": _description.text,
          "Product_name": _product_name.text,
          "Reduced_price": _reduced_price.text,
          "Selling_price": _selling_price.text,
          "image": imagesUrls[0],
          "url_2": imagesUrls[1],
          "url_3": imagesUrls[2],
          "url_4": imagesUrls[3],
          "url_5": imagesUrls[4],
        },
      );
    } catch (e) {
      const snackBar = SnackBar(
        content: Text('Please Check Your Internet Connection.'),
        duration: Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  var firestoreDB = FirebaseFirestore.instance
      .collection("products")
      .doc(GetStorage().read('mobile'))
      .collection('products')
      .snapshots();

  bool isdelete = true;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreDB,
        builder: (
          context,
          // ignore: non_constant_identifier_names
          Snapshot,
        ) {
          if (!Snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          // ignore: unrelated_type_equality_checks
          if (Snapshot.requireData == false) {
            return Scaffold(
              body: Column(
                children: [
                  Container(
                    // ignore: prefer_const_constructors
                    child: Text("No Data Found"),
                  )
                ],
              ),
            );
          }

          return DefaultTabController(
              length: 2,
              child: GestureDetector(
                onTap: (() => FocusScope.of(context).unfocus()),
                child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.teal,
                      title: const Text("ADD PRODUCT",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white)),
                    ),
                    backgroundColor: Colors.white,
                    body: Column(
                      children: [
                        const TabBar(
                          labelColor: Colors.teal,
                          unselectedLabelColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorWeight: 2,
                          indicatorColor: Colors.teal,
                          labelStyle: TextStyle(fontSize: 17),
                          tabs: [
                            Tab(
                              text: "Add Products",

                              // icon: Icon(Icons.run_circle, color: Colors.white),
                            ),
                            Tab(
                              text: "Add Category",
                              // icon: Icon(Icons.pending_actions, color: Colors.white),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 50,
                              left: 15,
                              right: 15,
                            ),
                            child: TabBarView(
                              physics: const BouncingScrollPhysics(),
                              children: [
                                Add_products(screenHeight, screenWidth),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: catadd(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ));
          ;
        },
      ),
    );
  }

  SingleChildScrollView Add_products(double screenHeight, double screenWidth) {
    return SingleChildScrollView(
      child: Column(children: [
        // TaskLsitData(),

        Row(
          children: [
            IconButton(
                onPressed: () {
                  // getgall();
                  selectImages();
                },
                icon: const Icon(
                  Icons.add_a_photo,
                  color: Colors.teal,
                  size: 50,
                )),
          ],
        ),

        SingleChildScrollView(
          physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.033, left: screenWidth * 0.11),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: imageFileList
                        .map((e) => GestureDetector(
                              key: Key(e.name),
                              onLongPress: () {
                                delete(e.name);
                              },
                              child: Visibility(
                                visible: isdelete,
                                child: Visibility(
                                  visible: isdeleteall,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      // color: Colors.teal,

                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.file(File(e.path),
                                          width: 70,
                                          fit: BoxFit.cover,
                                          height: 50),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList()),
              )
            ],
          ),
        ),

        SizedBox(
          height: screenHeight * 0.05,
        ),
        Container(
            child: const Text(
          "Add upto 5 images per product",
          style: TextStyle(color: Color(0xff8D8D8D), fontSize: 13),
        )),

        Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.03,
                  left: 0,
                  right: 0,
                  bottom: screenHeight * 0.022,
                ),
                child: TextFormField(
                  // controller: _product_name,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Enter Product Name";
                    }
                    return null;
                  },
                  cursorColor: Colors.teal,
                  decoration: const InputDecoration(
                      hoverColor: Colors.teal,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff959595), width: 1.4),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal, width: 1.4),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.4),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal, width: 1.4),
                      ),
                      labelText: 'Product Name',
                      floatingLabelStyle: TextStyle(color: Colors.teal)

                      // hintText: 'Enter Product Name',
                      ),
                  controller: _product_name,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: screenWidth * 0.45,
                    child: TextFormField(
                      // controller: _selling_price,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Enter Selling Price";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.teal,
                      decoration: const InputDecoration(
                          hoverColor: Colors.teal,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xff959595), width: 1.4),
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.teal, width: 1.4),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.4),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.teal, width: 1.4),
                          ),
                          labelText: 'Selling Price',
                          floatingLabelStyle: TextStyle(color: Colors.teal)

                          // hintText: 'Enter Product Name',
                          ),
                      controller: _selling_price,
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.45,
                    child: TextFormField(
                      // controller: _reduced_price,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Enter Reduced Price";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.teal,
                      decoration: const InputDecoration(
                          hoverColor: Colors.teal,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xff959595), width: 1.4),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.teal, width: 1.4),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.4),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.teal, width: 1.4),
                          ),
                          labelText: 'Reduced Price',
                          floatingLabelStyle: TextStyle(color: Colors.teal)

                          // hintText: 'Enter Product Name',
                          ),
                      controller: _reduced_price,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: screenHeight * 0.023),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                      hoverColor: Colors.teal,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff959595), width: 1.4),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal, width: 1.4),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.4),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 0, 155, 140),
                            width: 1.4),
                      ),
                      labelText: "Category",
                      floatingLabelStyle: TextStyle(color: Colors.teal)

                      // hintText: 'Enter Product Name',
                      ),
                  value: selectedValue,
                  isDense: true,
                  onChanged: (newvalue) {
                    setState(() {
                      selectedValue = newvalue!;
                    });
                  },
                  items: emailList.map<DropdownMenuItem>((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                // width: screenWidth * 0.45,
                padding: EdgeInsets.only(top: screenHeight * 0.020),
                child: TextFormField(
                  controller: _description,
                  minLines: 6,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Enter Description";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  cursorColor: Colors.teal,
                  decoration: const InputDecoration(
                      hoverColor: Colors.teal,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff959595), width: 1.4),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal, width: 1.4),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.4),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal, width: 1.4),
                      ),
                      labelText: 'Product Description',
                      floatingLabelStyle: TextStyle(color: Colors.teal)

                      // hintText: 'Enter Product Name',
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.022,
                  bottom: screenHeight * 0.022,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Colors.teal),
                    child: TextButton(
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.blue.withOpacity(0.04);
                              }
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.white.withOpacity(0.12);
                              }
                              return null; // Defer to the widget's default.
                            },
                          ),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () {
                          try {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            _formKey.currentState!.save();
                            uploadFilemulti();
                          } catch (e) {}
                        },
                        child: const Text("Add Product")),
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  void delete(e) {
    setState(() {
      imageFileList.removeAt(0);
      print(imageFileList.length);
    });
  }
}
