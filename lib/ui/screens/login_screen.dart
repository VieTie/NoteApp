import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:noteapp/ui/style/app.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double screenHeight = 0;
  double screenWidth = 0;
  double screenBottom = 0;

  final TextEditingController _phoneController = TextEditingController();
  String initialCountry = 'VN';

  //PhoneNumber numberPhone = PhoneNumber(isoCode: 'VN');
  String numberPhone = "";
  PhoneNumber initialPhone = PhoneNumber(isoCode: 'VN');

  int screenState = 0;
  String otpPin = " ";
  String verID = " ";

  Future<void> verifyPhone(String? phoneNumber) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        auth.signInWithCredential(credential).then((value) => {
              if (kDebugMode) {print("You are logged in successfully!")}
            });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        verID = verificationId;
        setState(() {
          screenState = 1;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> verifyOTP() async {
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
            verificationId: verID, smsCode: otpPin))
        .whenComplete(() {
      final uid = auth.currentUser?.uid;
      User1.static_uid = uid!;
      users
          .doc(auth.currentUser?.uid)
          .set({'uid': uid});
      print('UID: ${User1.static_uid}');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    screenBottom = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
        backgroundColor: mainColor,
        body: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Stack(children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                      padding: EdgeInsets.only(top: screenHeight / 8),
                      child: Column(children: [
                        Text("T - Note",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                color: lightColor,
                                fontSize: screenWidth / 8)),
                        Text("Welcome to join us!",
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                color: lightColor,
                                fontSize: screenWidth / 28))
                      ]))),
              Align(alignment: Alignment.centerLeft, child: circle(5)),
              Transform.translate(
                  offset: const Offset(30, -30),
                  child: Align(
                      alignment: Alignment.centerRight, child: circle(4.5))),
              Center(child: circle(3.5)),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedContainer(
                      height:
                          screenBottom > 0 ? screenHeight : screenHeight / 2,
                      width: screenWidth,
                      color: Colors.white,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth / 12,
                              right: screenWidth / 12,
                              top: screenBottom > 0 ? screenHeight / 12 : 0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                screenState == 0 ? stateRegister() : stateOTP(),
                                GestureDetector(
                                    onTap: () async {
                                      if (screenState == 0) {
                                        if (_phoneController.text.isEmpty) {
                                        } else {
                                          verifyPhone(numberPhone);
                                          // Navigator.of(context).pushReplacement(
                                          //     MaterialPageRoute(
                                          //     builder: (context) => const Home()));
                                        }
                                      } else {
                                        if (otpPin.length >= 6) {
                                          final pref = await SharedPreferences
                                              .getInstance();
                                          pref.setBool('isLoggedIn', true);

                                          verifyOTP();
                                        } else {}
                                      }
                                    },
                                    child: Container(
                                        height: 50,
                                        width: screenWidth,
                                        margin: EdgeInsets.only(
                                            bottom: screenHeight / 12),
                                        decoration: BoxDecoration(
                                            color: mainColor,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: const Center(
                                            child: Text("CONTINUE",
                                                style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1.5,
                                                    fontSize: 18)))))
                              ]))))
            ])));
  }

  Widget stateRegister() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 8),
      const Text("Phone number",
          style: TextStyle(
              fontFamily: "Montserrat",
              color: Colors.black87,
              fontWeight: FontWeight.bold)),
      InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber number) {
            if (kDebugMode) {
              numberPhone = number.phoneNumber!;
              print(number.phoneNumber);
            }
          },
          onInputValidated: (bool value) {
            if (kDebugMode) {
              print(value);
            }
          },
          selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
          selectorTextStyle: const TextStyle(color: Colors.black),
          initialValue: initialPhone,
          textFieldController: _phoneController,
          formatInput: false,
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
          inputBorder: const OutlineInputBorder(),
          onSaved: (PhoneNumber number) {
            if (kDebugMode) {
              print('On Saved: $number');
            }
          })
    ]);
  }

  Widget stateOTP() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            const TextSpan(
                text: "We just sent a code to ",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.black87,
                    fontSize: 18)),
            TextSpan(
                text: numberPhone,
                // text: "0916688474",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            const TextSpan(
                text: "\nEnter the code here and we can continue!",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.black87,
                    fontSize: 12))
          ])),
      const SizedBox(height: 20),
      PinCodeTextField(
          keyboardType: TextInputType.number,
          appContext: context,
          length: 6,
          onChanged: (value) {
            setState(() {
              otpPin = value;
            });
          },
          pinTheme: PinTheme(
              activeColor: mainColor,
              selectedColor: mainColor,
              inactiveColor: Colors.black26)),
      const SizedBox(height: 20),
      RichText(
          text: TextSpan(children: [
        const TextSpan(
            text: "Didn't receive the code? ",
            style: TextStyle(
                fontFamily: "Montserrat", color: Colors.black87, fontSize: 12)),
        WidgetSpan(
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    screenState = 0;
                  });
                },
                child: Text("Resend",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: mainColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold))))
      ]))
    ]);
  }

  Widget circle(double size) {
    return Container(
        height: screenHeight / size,
        width: screenHeight / size,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white));
  }
}

class User1 {
  static String static_uid = '';
  User1();
}
