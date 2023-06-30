import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class catadd extends StatefulWidget {
  const catadd({super.key});

  @override
  State<catadd> createState() => _cataddState();
}

class _cataddState extends State<catadd> {
  final _formKey = GlobalKey<FormState>();
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
    if (selectedImages.length > 1 ||
        selectedImages.isEmpty ||
        imageFileList.length > 1) {
      imageFileList.clear();
      const snackBar = SnackBar(
        content: Text('Please Add upto 1 images per product'),
        duration: Duration(seconds: 5),
        backgroundColor: Colors.teal,
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      imageFileList.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList.length.toString());
    setState(() {});
  }

  uploadFilemulti() async {
    EasyLoading.show(status: "Please Wait");

    try {
      if (imageFileList.length != 1) {
        const snackBar = SnackBar(
          content: Text('Please Add upto 1 images per product'),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.teal,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        for (var image in imageFileList) {
          Reference imageFile = FirebaseStorage.instance
              .ref()
              .child(_category.text)
              .child(uuid.v4());

          await imageFile.putFile(File(image.path)).whenComplete(() async {
            url = await imageFile.getDownloadURL();
          });
          imagesUrls.add(url);
          addcategory();

          print(imagesUrls.length);
        }

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
        isdeleteall = false;
      }
    } catch (e) {
      print(e);
    }
  }

  void delete(e) {
    setState(() {
      imageFileList.removeAt(0);
      print(imageFileList.length);
    });
  }

  addcategory() async {
    try {
      await FirebaseFirestore.instance
          .collection("products")
          .doc(GetStorage().read('mobile'))
          .collection('category')
          .doc()
          .set(
        {
          "Category": _category.text,
          "image": imagesUrls[0],
          // "url1": imagesUrls[1],
        },
      );
      EasyLoading.showSuccess(' Successfully Uploaded!')
          .whenComplete(() => Navigator.pop(context));
    } catch (e) {
      const snackBar = SnackBar(
        content: Text('Please Check Your Internet Connection.'),
        duration: Duration(seconds: 5),
      );
      print(e);
    }
  }

  clearTextInput() {
    isdeleteall = false;
    _category.clear();
    imageFileList.clear();
    selectedImages!.clear();
    isdelete = false;
  }

  final _category = TextEditingController();
  bool isdelete = true;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: IconButton(
                        onPressed: () {
                          // getgall();
                          selectImages();
                        },
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Colors.teal,
                          size: 50,
                        )),
                  ),
                ],
              ),
              SingleChildScrollView(
                physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: screenHeight * 0.033, left: 0.30),
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

                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
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
                "Add upto 1 images per product",
                style: TextStyle(color: Colors.teal, fontSize: 13),
              )),
              SizedBox(
                height: screenHeight * 0.050,
              ),
              Container(
                width: screenWidth,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _category,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Enter Category";
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
                          borderSide:
                              BorderSide(color: Colors.teal, width: 1.4),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.4),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.teal, width: 1.4),
                        ),
                        labelText: 'category',
                        floatingLabelStyle: TextStyle(color: Colors.teal)

                        // hintText: 'Enter Product Name',
                        ),
                    // initialValue: "",
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Container(
                width: screenWidth * 0.95,
                decoration: const BoxDecoration(color: Colors.teal),
                child: TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
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
                    child: const Text("Add Category")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
