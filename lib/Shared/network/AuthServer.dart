// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../modules/auth_Screen/SignInLogic_Screen/signInLogic.dart';
import '../../modules/auth_Screen/otp_Screen/otp_Screen.dart';
import '../provider/auth_provider.dart';

class AuthServices {
  static bool checkAuthentication() {
    FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
       if (user != null) {
        return true;
       }
        return false;
   }

  static receiveOTP({
        required BuildContext context,
    required String mobileNo
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: mobileNo,
        verificationCompleted: (PhoneAuthCredential credential) {
          log(credential.toString());
        },
        verificationFailed: (FirebaseAuthException exception) {
          log(exception.toString());
        },
        codeSent: (String verificationID, int? resendToken) {
          context
              .read<authProvider>()
              .upDateverificationId(verID: verificationID);
          context.read<authProvider>().upDatePhoneNum(
            num: mobileNo,
          );
          Navigator.push(
            context,
            PageTransition(
              child:  OTPScreen(mobileNumber: mobileNo),
              type: PageTransitionType.rightToLeft,
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationID) {},
      );
    } catch (e) {
      log(e.toString());
    }
  }

  static verifyOTP({
    required BuildContext context,
    required String otp
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: context.read<authProvider>().verificationId,
        smsCode: otp,
      );
      await auth.signInWithCredential(credential);
      Navigator.push(
          context,
          PageTransition(
            child:const SignInLogic(),
            type: PageTransitionType.rightToLeft,
          )
    );
    } catch (e) {
      log(e.toString());
    }
  }
}