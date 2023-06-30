import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/admin/screens/profile.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class imagheadd extends StatefulWidget {
  @override
  State<imagheadd> createState() => _imagheaddState();
}

class _imagheaddState extends State<imagheadd> {
  ImagePicker image = ImagePicker();

  File? file;

  String url = "";

  getgall() async {
    var img = await image.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 600,
      maxWidth: 600,
    );
    setState(() {
      file = File(img!.path);
    });
  }

  getcamera() async {
    var img = await image.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxHeight: 600,
      maxWidth: 600,
    );
    setState(() {
      file = File(img!.path);
    });
  }

  uploadFile() async {
    EasyLoading.show(status: 'loading...');
    Reference imageFile = FirebaseStorage.instance.ref().child("CSE");
    await imageFile.putFile(file!).whenComplete(() async {
      url = await imageFile.getDownloadURL();

      print(url);
      add();
      EasyLoading.showSuccess(' Successfully Uploaded!');
    }).whenComplete(() => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => profile(),
          ),
        ));
  }

  add() {
    FirebaseFirestore.instance
        .collection("user")
        .doc(GetStorage().read('mobile'))
        .update(
      {
        "image": url,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(241, 23, 15, 15),
          title: Text("ImageSelect",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                  color: Color.fromARGB(255, 255, 252, 252))),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
              ),
              InkWell(
                onTap: () {
                  getgall();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.all(15),
                      height: MediaQuery.of(context).size.height * .35,
                      width: MediaQuery.of(context).size.width * .85,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 252, 252, 252),
                        border: Border.all(color: Colors.blueAccent),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: file == null
                            // ignore: prefer_const_constructors
                            ? Icon(
                                Icons.image,
                                size: 50,
                              )
                            : Image.file(file!, fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        onPressed: () {
                          getgall();
                        },
                        child: Text(
                          "Gallery",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        )),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        getcamera();
                      },
                      child: Text(
                        "Camera",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {
                    uploadFile();
                  },
                  child: Text(
                    "save",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
