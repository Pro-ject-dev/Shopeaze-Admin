// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:ecommerce/admin/screens/otp_screen.dart';

import 'package:ecommerce/admin/public/variables.dart';
import 'package:ecommerce/admin/widgets/signup_widgets/signin_container.dart';
import 'package:ecommerce/admin/widgets/signup_widgets/textfield.dart';
import 'package:extended_phone_number_input/consts/enums.dart';
import 'package:extended_phone_number_input/phone_number_input.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController whatsapp = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController otp = TextEditingController();

  bool _obscureText = true;
  bool otpVisibility = false;

  String verificationID = "";

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;
    final hei = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        const SizedBox(height: 90),
                        Text("sign up",
                            style: GoogleFonts.poppins(
                                fontSize: wid * 0.065,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 20),
                        textField(
                          context,
                          obsecure: false,
                          label: "username",
                          controller: username,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "please enter username";
                            }
                          },
                        ),
                        textField(context,
                            label: "Email",
                            controller: email,
                            obsecure: false, validator: (value) {
                          if (value.isEmpty) {
                            return "please enter Email";
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return "Enter valid email";
                          }
                          ;
                        }),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 30, right: 30, bottom: 15),
                          child: PhoneNumberInput(
                            initialCountry: 'IN',
                            hint: "Mobile number",
                            allowPickFromContacts: false,
                            errorText: "invalid mobile.no",
                            countryListMode: CountryListMode.dialog,
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            onChanged: (p0) {
                              setState(() => whatsapp.text = p0.toString());
                              print(whatsapp);
                            },
                          ),
                        ),

                        textField(
                          context,
                          obsecure: _obscureText,
                          label: "Password",
                          pass: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color.fromARGB(255, 1, 17, 110),
                              ),
                              onPressed: _toggle),
                          controller: password,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "please enter password";
                            } else if (value.length < 8) {
                              return "Password strength is low";
                            }
                          },
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              phoneSignIn(phoneNumber: whatsapp.text);
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: hei * 0.072,
                            width: wid * 0.8,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 0, 0, 0),
                                    Color.fromARGB(255, 157, 157, 157)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight),
                              borderRadius: BorderRadius.circular(8),
                              // ignore: prefer_const_literals_to_create_immutables
                            ),
                            child: Text("sign up",
                                style: GoogleFonts.poppins(
                                    fontSize: wid * 0.046,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Text(
                            "or",
                            style: GoogleFonts.poppins(
                                fontSize: wid * 0.043,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Are you existing user ?",
                                  style: GoogleFonts.poppins(
                                      fontSize: wid * 0.032,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(
                                width: 7,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "sign in",
                                  style: GoogleFonts.poppins(
                                      fontSize: wid * 0.04,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        //
                        sigin_container(context,
                            label: "Log in with Facebook",
                            logo:
                                'https://www.teahub.io/photos/full/11-115962_facebook-logo-png-transparent-background-facebook-png.png'),
                        sigin_container(
                          context,
                          label: "Log in with Google",
                          logo:
                              'https://th.bing.com/th/id/R.c8bf7c087ca9793d094042845707ffac?rik=fjZN1AYH30vXIw&riu=http%3a%2f%2fpngimg.com%2fuploads%2fgoogle%2fgoogle_PNG19635.png&ehk=ZmsumEtoeJQhKoUzQTZO2TEbYPBu0%2b7EFdjmJ3qljls%3d&risl=&pid=ImgRaw&r=0',
                        )
                      ],
                    ),
                  ),
                )),
          ),
        ));
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
      this.otp.text = authCredential.smsCode!;
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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => otp_page(
                  context,
                  mobile: whatsapp.text,
                  email: email.text,
                  username: username.text,
                  password: password.text,
                ))));
  }

  _onCodeTimeout(String timeout) {
    showMessage("OTP is Timed Out");
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
