// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/admin/screens/buildapp_screen.dart';
import 'package:ecommerce/admin/screens/login_screen.dart';
import 'package:ecommerce/admin/public/variables.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class otp_page extends StatefulWidget {
  final mobile, email, username, password;

  otp_page(BuildContext context,
      {super.key,
      required this.mobile,
      required this.email,
      required this.username,
      required this.password});

  @override
  State<otp_page> createState() => _otp_pageState();
}

class _otp_pageState extends State<otp_page> {
  final GlobalKey<ScaffoldState> _scafoldkey = GlobalKey<ScaffoldState>();
  final TextEditingController _otp = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  String verificationID = "";

  bool otpVisibility = true;

  // final otp_field = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String _verification_id = "";
    var hei = MediaQuery.of(context).size.height;
    var wid = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scafoldkey,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
              ),
              Image(
                  image: NetworkImage(
                      'https://cdn.dribbble.com/users/3821672/screenshots/7172846/media/bdcf195a8ceaf94cd2e55ee274095c91.gif')),
              Text("OTP Verification",
                  style: GoogleFonts.poppins(
                      fontSize: wid * 0.05, fontWeight: FontWeight.w600)),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Enter the OTP sent to ",
                      style: GoogleFonts.poppins(
                          fontSize: wid * 0.030,
                          color: Color.fromARGB(255, 134, 134, 134),
                          fontWeight: FontWeight.w600)),
                  Text(widget.mobile,
                      style: GoogleFonts.nunito(
                          fontSize: wid * 0.03, fontWeight: FontWeight.w800)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 25, bottom: 25, left: 15, right: 15),
                child: Pinput(
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsRetrieverApi,
                  length: 6,
                  controller: _otp,
                  onSubmitted: (pin) async {
                    await otp_verify(pin, context);
                  },
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't receive the OTP ?",
                      style: GoogleFonts.poppins(
                          fontSize: wid * 0.030,
                          color: Color.fromARGB(255, 134, 134, 134),
                          fontWeight: FontWeight.w600)),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      phoneSignIn(phoneNumber: widget.mobile);
                    },
                    child: Text("RESEND OTP",
                        style: GoogleFonts.poppins(
                            fontSize: wid * 0.030,
                            color: Color.fromARGB(255, 2, 8, 117),
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  otp_verify(_otp.text, context);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: hei * 0.068,
                  width: wid * 0.85,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 0, 0, 0),
                      Color.fromARGB(255, 157, 157, 157)
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(8),
                    // ignore: prefer_const_literals_to_create_immutables
                  ),
                  child: Text("Verify & Proceed",
                      style: GoogleFonts.poppins(
                          fontSize: wid * 0.046,
                          color: Colors.white,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> otp_verify(String pin, BuildContext context) async {
    return await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
            verificationId: pup.toString(), smsCode: pin))
        .then((value) async {
      if (value.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'Register successfully',
        )));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
        signup();
        createuser();
      }
    });
  }

  Future<void> phoneSignIn({required String phoneNumber}) async {
    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: _onCodeSent,
        codeAutoRetrievalTimeout: _onCodeTimeout);
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("verification completed ${authCredential.smsCode}");
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      //this.otp.text = authCredential.smsCode!;
    });
    if (authCredential.smsCode != null) {
      try {
        UserCredential credential =
            await user!.linkWithCredential(authCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'provider-already-linked') {
          await auth.signInWithCredential(authCredential);
        }
      }
      setState(() {
        otpVisibility = false;
      });
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      showMessage("The phone number entered is invalid!");
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    this.verificationID = verificationId;
    print("code sent");
    setState(() {
      pup = verificationID.toString();
    });
  }

  _onCodeTimeout(String timeout) {
    showMessage("OTP is Timed Out");
  }

  void signup() {
    FirebaseFirestore.instance.collection('user').doc(widget.mobile).set({
      "username": widget.username,
      "Email": widget.email,
      "Number": widget.mobile,
      "password": widget.password,
      "uid": FirebaseAuth.instance.currentUser!.uid.toString(),
      "business name": null,
      "address": null,
    });
  }

  void createuser() {
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: widget.email, password: widget.password);
  }

  void showMessage(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () async {
                  Navigator.of(builderContext).pop();
                },
              )
            ],
          );
        }).then((value) {
      setState(() {
        otpVisibility = false;
      });
    });
  }
}
