import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/admin/widgets/viewproduct_widgets/get_cat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class Edit_details extends StatefulWidget {
  final name, Category, business_nme;
  Edit_details(
      {required this.name, required this.Category, required this.business_nme});

  @override
  State<Edit_details> createState() => _Edit_detailsState();
}

class _Edit_detailsState extends State<Edit_details> {
  final _formKey = GlobalKey<FormState>();
  var name, store_name, cat_name;
  @override
  Widget build(BuildContext context) {
    var hei = MediaQuery.of(context).size.height;
    var wid = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
            child: Form(
      key: _formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(height: hei * 0.09),
        Text("Edit Details",
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: wid * 0.065,
                fontWeight: FontWeight.w600)),
        Textfield(
          lable_text: "Name",
          initial: widget.name,
          validator: (value) {
            if (value == null && value.isEmpty) {
              return "Please Enter Your Name";
            }
          },
          change: (value) {
            setState(() {
              name = value;
            });
          },
        ),
        Textfield(
          lable_text: "Category",
          validator: (value) {
            if (value == null && value.isEmpty) {
              return "Please Enter Category";
            }
          },
          initial: widget.Category,
          change: (value) {
            setState(() {
              cat_name = value;
            });
          },
        ),
        Textfield(
          lable_text: "Store Name",
          initial: widget.business_nme,
          validator: (value) {
            if (value == "" && value.isEmpty) {
              return "Please Enter Store Name";
            }
          },
          change: (value) {
            setState(() {
              store_name = value;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        MaterialButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                update();
              } else {
                return;
              }
            },
            child: Text(
              "Save",
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            color: Colors.black)
      ]),
    )));
  }

  void update() {
    if (cat_name == null) {
      cat_name = widget.Category;
    }
    if (name == null) {
      name = widget.name;
    }
    if (store_name == null) {
      store_name = widget.business_nme;
    }
    FirebaseFirestore.instance
        .collection('user')
        .doc(GetStorage().read('mobile'))
        .update({
      "business category": cat_name,
      "business name": store_name,
      "username": name
    }).whenComplete(() => Navigator.pop(context));
  }
}

class Textfield extends StatelessWidget {
  final lable_text, validator, initial, change;
  Textfield(
      {required this.lable_text,
      required this.validator,
      required this.initial,
      required this.change});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25, left: 15.0, right: 15.0),
      child: TextFormField(
        initialValue: initial,
        cursorColor: Color.fromARGB(255, 82, 82, 82),
        decoration: InputDecoration(
            hoverColor: Color.fromARGB(255, 51, 52, 52),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff959595), width: 1.4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 51, 52, 52), width: 1.4),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.4),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 51, 52, 52), width: 1.4),
            ),
            label: Text(lable_text.toString())),
        validator: validator,
        onChanged: change,
      ),
    );
  }
}
