import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class edit_product extends StatefulWidget {
  edit_product(
      {required this.selling_price,
      required this.product_name,
      required this.description,
      required this.redced_price,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.image5});
  final selling_price,
      product_name,
      description,
      redced_price,
      image1,
      image2,
      image3,
      image4,
      image5;
  @override
  State<edit_product> createState() => _edit_product();
}

class _edit_product extends State<edit_product> {
  bool imgg = true;
  final categorylable = "Category";
  String? selectedValue;
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
      // imageFileList.addAll(selectedImages);
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

  clearTextInput() {
    // selectedValue = "Category";
    imageFileList.clear();
    _description.clear();
    _product_name.clear();
    _reduced_price.clear();
    _selling_price.clear();
    isdeleteall = false;

    // selectedImages!.clear();
  }

  addDataProduct() {
    var l = GetStorage().read('mobile');
    try {
      FirebaseFirestore.instance
          .collection("products")
          .doc(l)
          .collection('products')
          .doc()
          .set(
        {
          "Category": selectedValue,
          "Description": widget.description,
          "Product_name": widget.product_name,
          "Reduced_price": widget.redced_price,
          "Selling_price": widget.selling_price,
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

  bool isdelete = true;

  @override
  Widget build(BuildContext context) {
    var ff = widget.product_name;
    List<String> listOfValue = ['1', '2', '3', '4', '5'];
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
        length: 1,
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
                        text: "DETAILS",

                        // icon: Icon(Icons.run_circle, color: Colors.white),
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
                          SingleChildScrollView(
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
                                physics: const ScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: screenHeight * 0.033,
                                          left: screenWidth * 0.11),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4),
                                                          decoration:
                                                              BoxDecoration(
                                                            // color: Colors.teal,

                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child: Image.file(
                                                                File(e.path),
                                                                width: 70,
                                                                fit: BoxFit
                                                                    .cover,
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
                                "Add upto 1 images per product",
                                style: TextStyle(
                                    color: Color(0xff8D8D8D), fontSize: 13),
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
                                        initialValue: widget.product_name,
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
                                              borderSide: BorderSide(
                                                  color: Color(0xff959595),
                                                  width: 1.4),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.teal,
                                                  width: 1.4),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 1.4),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.teal,
                                                  width: 1.4),
                                            ),
                                            labelText: 'Product Name',
                                            floatingLabelStyle:
                                                TextStyle(color: Colors.teal)

                                            // hintText: 'Enter Product Name',
                                            ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: screenWidth * 0.45,
                                          child: TextFormField(
                                            initialValue: widget.selling_price,
                                            validator: (value) {
                                              if (value != null &&
                                                  value.isEmpty) {
                                                return "Enter Selling Price";
                                              }
                                              return null;
                                            },
                                            keyboardType: TextInputType.number,
                                            cursorColor: Colors.teal,
                                            decoration: const InputDecoration(
                                                hoverColor: Colors.teal,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xff959595),
                                                      width: 1.4),
                                                ),
                                                errorStyle: TextStyle(
                                                    color: Colors.red),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.teal,
                                                      width: 1.4),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.red,
                                                      width: 1.4),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.teal,
                                                      width: 1.4),
                                                ),
                                                labelText: 'Selling Price',
                                                floatingLabelStyle: TextStyle(
                                                    color: Colors.teal)

                                                // hintText: 'Enter Product Name',
                                                ),
                                          ),
                                        ),
                                        Container(
                                          width: screenWidth * 0.45,
                                          child: TextFormField(
                                            initialValue: widget.redced_price,
                                            validator: (value) {
                                              if (value != null &&
                                                  value.isEmpty) {
                                                return "Enter Reduced Price";
                                              }
                                              return null;
                                            },
                                            keyboardType: TextInputType.number,
                                            cursorColor: Colors.teal,
                                            decoration: const InputDecoration(
                                                hoverColor: Colors.teal,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xff959595),
                                                      width: 1.4),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.teal,
                                                      width: 1.4),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.red,
                                                      width: 1.4),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.teal,
                                                      width: 1.4),
                                                ),
                                                labelText: 'Reduced Price',
                                                floatingLabelStyle: TextStyle(
                                                    color: Colors.teal)

                                                // hintText: 'Enter Product Name',
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: screenHeight * 0.023),
                                      child: DropdownButtonFormField(
                                        decoration: const InputDecoration(
                                            hoverColor: Colors.teal,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xff959595),
                                                  width: 1.4),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.teal,
                                                  width: 1.4),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 1.4),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.teal,
                                                  width: 1.4),
                                            ),
                                            labelText: "Category",
                                            floatingLabelStyle:
                                                TextStyle(color: Colors.teal)

                                            // hintText: 'Enter Product Name',
                                            ),
                                        value: selectedValue,
                                        isExpanded: true,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedValue = value;
                                          });
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            selectedValue = value;
                                          });
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "can't empty";
                                          } else {
                                            return null;
                                          }
                                        },
                                        items: listOfValue.map((String val) {
                                          return DropdownMenuItem(
                                            value: val,
                                            child: Text(
                                              val,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Container(
                                      // width: screenWidth * 0.45,
                                      padding: EdgeInsets.only(
                                          top: screenHeight * 0.020),
                                      child: TextFormField(
                                        initialValue: widget.description,
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
                                              borderSide: BorderSide(
                                                  color: Color(0xff959595),
                                                  width: 1.4),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.teal,
                                                  width: 1.4),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 1.4),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.teal,
                                                  width: 1.4),
                                            ),
                                            labelText: 'Product Description',
                                            floatingLabelStyle:
                                                TextStyle(color: Colors.teal)

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
                                          decoration: const BoxDecoration(
                                              color: Colors.teal),
                                          child: TextButton(
                                              style: ButtonStyle(
                                                overlayColor:
                                                    MaterialStateProperty
                                                        .resolveWith<Color?>(
                                                  (Set<MaterialState> states) {
                                                    if (states.contains(
                                                        MaterialState
                                                            .hovered)) {
                                                      return Colors.blue
                                                          .withOpacity(0.04);
                                                    }
                                                    if (states.contains(
                                                            MaterialState
                                                                .focused) ||
                                                        states.contains(
                                                            MaterialState
                                                                .pressed)) {
                                                      return Colors.white
                                                          .withOpacity(0.12);
                                                    }
                                                    return null; // Defer to the widget's default.
                                                  },
                                                ),
                                                foregroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.white),
                                              ),
                                              onPressed: () {
                                                try {
                                                  if (!_formKey.currentState!
                                                      .validate()) {
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }

  void delete(e) {
    setState(() {
      imageFileList.removeAt(0);
      print(imageFileList.length);
    });
  }
}
