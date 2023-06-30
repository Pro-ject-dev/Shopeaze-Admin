// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/admin/screens/profile.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class adminaddress extends StatefulWidget {
  String mobile;
  String city;
  String country;
  String deliveryaddress;
  String houseaddress;
  String name;
  String pincode;
  String state;
  String emailaddress;
  String funny;
  String saroja;

  adminaddress(
    this.mobile,
    this.city,
    this.country,
    this.deliveryaddress,
    this.houseaddress,
    this.name,
    this.pincode,
    this.state,
    this.emailaddress,
    this.funny,
    this.saroja,
  );

  @override
  State<adminaddress> createState() => _adminaddressState();
}

class _adminaddressState extends State<adminaddress> {
  String phones = "";
  String emailadd = "";
  String addname = "";
  String addhouse = "";
  String adddelivery = "";
  String addcity = "";
  String addpincode = "";
  String addstate = "";
  String addcountry = "";
  String hell = "";
  @override
  void initState() {
    setdata();
    super.initState();
  }

  clearTextInput() {}

  setdata() {
    setState(() {
      phones = widget.saroja;
      emailadd = widget.emailaddress;
      addname = widget.name;
      addhouse = widget.houseaddress;
      adddelivery = widget.deliveryaddress;
      addcity = widget.city;
      addpincode = widget.pincode;
      addstate = widget.state;
      addcountry = widget.country;
      hell = widget.funny;
    });
    if (hell == null) {
      setState(() {
        hell = "+91";
      });
    }
  }

  address() {
    var dial = countryCode?.dialCode;
    if (dial == null) {
      setState(() {
        dial = widget.funny;
      });
    }
    FirebaseFirestore.instance
        .collection("user")
        .doc(GetStorage().read('mobile'))
        .update({
      // ignore: prefer_interpolation_to_compose_strings
      "Personal mobile": dial! + " " + phones,
      "Email": emailadd,
      "name": addname,
      'address': addhouse +
          "`" +
          adddelivery +
          "`" +
          addcity +
          "`" +
          addpincode +
          "`" +
          addstate +
          "`" +
          addcountry
    });
    clearTextInput();
  }

  final countrypicker = const FlCountryCodePicker();
  CountryCode? countryCode;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Text("Customer Details",
                      style: GoogleFonts.adamina(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color.fromARGB(255, 8, 8, 8))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .06,
                  width: MediaQuery.of(context).size.width * .95,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 10),
                    child: Row(
                      children: [
                        Container(
                          // ignore: sort_child_properties_last
                          child: countryCode != null
                              ? countryCode!.flagImage
                              : null,

                          height: MediaQuery.of(context).size.height * .06,
                          width: MediaQuery.of(context).size.width * .15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 05),
                          child: InkWell(
                            onTap: () async {
                              final code = await countrypicker.showPicker(
                                  context: context);
                              countryCode = code;
                              setState(() {
                                countryCode = code;
                                print(countryCode?.dialCode);
                              });
                            },
                            child: Container(
                              // ignore: sort_child_properties_last
                              child: Center(
                                child: Text(countryCode?.dialCode ?? hell,
                                    style: GoogleFonts.poppins(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Color.fromARGB(
                                            255, 255, 255, 255))),
                              ),
                              // color: Colors.red,
                              height: MediaQuery.of(context).size.height * .06,
                              width: MediaQuery.of(context).size.width * .15,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 14, 13, 13),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(61, 23, 24, 25)
                                        .withOpacity(0.3),
                                    spreadRadius: 0,
                                    blurRadius: 10,
                                    // offset: Offset(0, 2),
                                  ),
                                  //you can set more BoxShadow() here
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Container(
                            height: MediaQuery.of(context).size.height * .06,
                            width: MediaQuery.of(context).size.width * .63,
                            child: TextFormField(
                              initialValue: phones,
                              onChanged: ((value) {
                                setState(() {
                                  phones = value;
                                  // print(phones);
                                });
                              }),
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              // controller: _product_name,
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return "Enter Phone Number";
                                }
                                return null;
                              },
                              cursorColor: Color.fromARGB(255, 19, 21, 21),

                              decoration: const InputDecoration(
                                  hoverColor: Color.fromARGB(255, 89, 90, 91),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff959595), width: 1.4),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 89, 90, 91),
                                        width: 1.4),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1.4),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 89, 90, 91),
                                        width: 1.4),
                                  ),
                                  labelText: 'Phone Number',
                                  floatingLabelStyle: TextStyle(
                                      color: Color.fromARGB(255, 11, 125, 239))

                                  // hintText: 'Enter Product Name',
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * .06,
                //   width: MediaQuery.of(context).size.width * .95,
                // ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      child: Container(
                        child: Text("Email",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color.fromARGB(255, 8, 8, 8))),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5, right: 5),
                  child: TextFormField(
                    initialValue: emailadd,
                    onChanged: ((value) {
                      setState(() {
                        emailadd = value;
                        // value = widget.emailaddress;
                        // print(emailadd);
                      });
                    }),
                    // controller: _product_name,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Enter Email";
                      }
                      return null;
                    },
                    cursorColor: Color.fromARGB(255, 19, 21, 21),

                    decoration: const InputDecoration(
                        hoverColor: Color.fromARGB(255, 89, 90, 91),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff959595), width: 1.4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 89, 90, 91),
                              width: 1.4),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.4),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 89, 90, 91),
                              width: 1.4),
                        ),
                        labelText: 'Email',
                        floatingLabelStyle:
                            TextStyle(color: Color.fromARGB(255, 11, 125, 239))

                        // hintText: 'Enter Product Name',
                        ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Container(
                        child: Text("Name",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color.fromARGB(255, 8, 8, 8))),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5, right: 5),
                  child: TextFormField(
                    initialValue: addname,
                    onChanged: ((value) {
                      setState(() {
                        addname = value;
                        // value = widget.emailaddress;
                        // print(addname);
                      });
                    }),
                    // controller: _product_name,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Enter Name";
                      }
                      return null;
                    },
                    cursorColor: Color.fromARGB(255, 19, 21, 21),

                    decoration: const InputDecoration(
                        hoverColor: Color.fromARGB(255, 89, 90, 91),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff959595), width: 1.4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 89, 90, 91),
                              width: 1.4),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.4),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 89, 90, 91),
                              width: 1.4),
                        ),
                        labelText: 'Name',
                        floatingLabelStyle:
                            TextStyle(color: Color.fromARGB(255, 11, 125, 239))

                        // hintText: 'Enter Product Name',
                        ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Container(
                        child: Text("Street",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color.fromARGB(255, 8, 8, 8))),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5, right: 5),
                  child: TextFormField(
                    initialValue: addhouse,
                    onChanged: ((value) {
                      setState(() {
                        addhouse = value;
                        // value = widget.emailaddress;
                        // print(addhouse);
                      });
                    }),
                    // controller: _product_name,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Enter your home address";
                      }
                      return null;
                    },
                    cursorColor: Color.fromARGB(255, 19, 21, 21),

                    decoration: const InputDecoration(
                        hoverColor: Color.fromARGB(255, 89, 90, 91),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff959595), width: 1.4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 89, 90, 91),
                              width: 1.4),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.4),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 89, 90, 91),
                              width: 1.4),
                        ),
                        labelText: 'Enter your street',
                        floatingLabelStyle:
                            TextStyle(color: Color.fromARGB(255, 11, 125, 239))

                        // hintText: 'Enter Product Name',
                        ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Container(
                        child: Text("Landmark",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color.fromARGB(255, 8, 8, 8))),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5, right: 5),
                  child: TextFormField(
                    initialValue: adddelivery,
                    onChanged: ((value) {
                      setState(() {
                        adddelivery = value;
                        // value = widget.emailaddress;
                        // print(adddelivery);
                      });
                    }),
                    // controller: _product_name,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Enter your Landmark address";
                      }
                      return null;
                    },
                    cursorColor: Color.fromARGB(255, 19, 21, 21),

                    decoration: const InputDecoration(
                        hoverColor: Color.fromARGB(255, 89, 90, 91),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff959595), width: 1.4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 89, 90, 91),
                              width: 1.4),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.4),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 89, 90, 91),
                              width: 1.4),
                        ),
                        labelText: 'Enter your Landmark address',
                        floatingLabelStyle:
                            TextStyle(color: Color.fromARGB(255, 11, 125, 239))

                        // hintText: 'Enter Product Name',
                        ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Container(
                        child: Text("City",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color.fromARGB(255, 8, 8, 8))),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5, right: 5),
                  child: TextFormField(
                    initialValue: addcity,
                    onChanged: ((value) {
                      setState(() {
                        addcity = value;
                        // value = widget.emailaddress;
                        // print(addcity);
                      });
                    }),
                    // controller: _product_name,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Enter your city";
                      }
                      return null;
                    },
                    cursorColor: Color.fromARGB(255, 19, 21, 21),

                    decoration: const InputDecoration(
                        hoverColor: Color.fromARGB(255, 89, 90, 91),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff959595), width: 1.4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 89, 90, 91),
                              width: 1.4),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.4),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 89, 90, 91),
                              width: 1.4),
                        ),
                        labelText: 'Enter your city',
                        floatingLabelStyle:
                            TextStyle(color: Color.fromARGB(255, 11, 125, 239))

                        // hintText: 'Enter Product Name',
                        ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Container(
                        child: Text("Pincode",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color.fromARGB(255, 8, 8, 8))),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5, right: 5),
                  child: TextFormField(
                    initialValue: addpincode,
                    onChanged: ((value) {
                      setState(() {
                        addpincode = value;
                        // value = widget.emailaddress;
                        // print(addpincode);
                      });
                    }),
                    keyboardType: TextInputType.number,

                    // controller: _product_name,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Enter your pincode";
                      }
                      return null;
                    },
                    cursorColor: Color.fromARGB(255, 19, 21, 21),

                    decoration: const InputDecoration(
                        hoverColor: Color.fromARGB(255, 89, 90, 91),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff959595), width: 1.4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 89, 90, 91),
                              width: 1.4),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.4),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 89, 90, 91),
                              width: 1.4),
                        ),
                        labelText: 'Enter your pincode',
                        floatingLabelStyle:
                            TextStyle(color: Color.fromARGB(255, 11, 125, 239))

                        // hintText: 'Enter Product Name',
                        ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Container(
                        child: Text("State",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color.fromARGB(255, 8, 8, 8))),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5, right: 5),
                  child: TextFormField(
                    initialValue: addstate,
                    onChanged: ((value) {
                      setState(() {
                        addstate = value;
                        // value = widget.emailaddress;
                        // print(addstate);
                      });
                    }),
                    // controller: _product_name,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Enter your state";
                      }
                      return null;
                    },
                    cursorColor: Color.fromARGB(255, 19, 21, 21),
                    decoration: const InputDecoration(
                        hoverColor: Color.fromARGB(255, 89, 90, 91),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff959595), width: 1.4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 89, 90, 91),
                              width: 1.4),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.4),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 89, 90, 91),
                              width: 1.4),
                        ),
                        labelText: 'Enter your state',
                        floatingLabelStyle:
                            TextStyle(color: Color.fromARGB(255, 11, 125, 239))

                        // hintText: 'Enter Product Name',
                        ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Container(
                        child: Text(
                          "Country",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color.fromARGB(255, 8, 8, 8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5, right: 5),
                  child: TextFormField(
                    initialValue: addcountry,
                    onChanged: ((value) {
                      setState(() {
                        addcountry = value;
                        // value = widget.emailaddress;
                        // print(addcountry);
                      });
                    }),
                    // controller: _product_name,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Enter your country";
                      }
                      return null;
                    },
                    cursorColor: Color.fromARGB(255, 19, 21, 21),
                    decoration: const InputDecoration(
                        hoverColor: Color.fromARGB(255, 89, 90, 91),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff959595), width: 1.4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 89, 90, 91),
                              width: 1.4),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.4),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 89, 90, 91),
                              width: 1.4),
                        ),
                        labelText: 'Enter your country',
                        floatingLabelStyle:
                            TextStyle(color: Color.fromARGB(255, 11, 125, 239))

                        // hintText: 'Enter Product Name',
                        ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                  width: MediaQuery.of(context).size.width * .95,
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();

                    address();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => profile(),
                      ),
                    );
                  },
                  child: Text(
                    "Save",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Color.fromARGB(255, 255, 255, 255),
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
}
