import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/admin/public/route_method.dart';
import 'package:ecommerce/admin/screens/buildapp_screen.dart';
import 'package:ecommerce/admin/screens/business_category_screen.dart';
import 'package:ecommerce/admin/screens/home_screen.dart';
import 'package:ecommerce/admin/screens/signup_screen.dart';
import 'package:extended_phone_number_input/consts/enums.dart';
import 'package:extended_phone_number_input/phone_number_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var phonenumber;

  var _password = TextEditingController();

  var _loginKey = GlobalKey<FormState>();

  var _passwordVisibility = true;
  final getStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('sign in',
                style: TextStyle(
                  fontSize: 27,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(
              height: 30,
            ),
            Form(
                key: _loginKey,
                child: Column(
                  children: [
                    PhoneNumberInput(
                      initialCountry: 'IN',
                      hint: "Mobile number",
                      allowPickFromContacts: false,
                      errorText: "invalid mobile.no",
                      countryListMode: CountryListMode.dialog,
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      onChanged: (p0) {
                        setState(() {
                          phonenumber = p0.toString();
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: _passwordVisibility,
                      controller: _password,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(_passwordVisibility == true
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _passwordVisibility = !_passwordVisibility;
                              });
                            },
                          ),
                          hintText: 'password',
                          hintStyle: const TextStyle(
                            fontFamily: 'Poppins-Regular',
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field is required';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_loginKey.currentState!.validate()) {
                          verify(phonenumber, _password.text);
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
                          'sign in',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins-Regular',
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'or',
                      style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an accout?',
                          style: TextStyle(
                            fontFamily: 'Poppins-Regular',
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const signup())));
                          },
                          child: const Text(
                            'sign up',
                            style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  verify(String phonenumber, String password) async {
    print(phonenumber);
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('Number', isEqualTo: '$phonenumber')
        .where('password', isEqualTo: password)
        .get();
    if (snapshot.docs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        'Phone number and password not matched',
      )));
    }
    if (snapshot.docs.isNotEmpty) {
      print(' record found');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        'Sign in success',
      )));
//choose business
      user();

      check(context, HomePage(), ChooseBusiness());
    }
  }

  user() {
    getStorage.write("id", 1);
    getStorage.write("mobile", phonenumber.toString());
  }
}
