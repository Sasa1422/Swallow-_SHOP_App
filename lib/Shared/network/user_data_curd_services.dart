// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swallow1/Shared/components/componants.dart';
import 'package:swallow1/Shared/components/constans.dart';
import 'package:swallow1/model_Screen/UserModel.dart';
import 'package:swallow1/model_Screen/address_model.dart';
import 'package:swallow1/modules/auth_Screen/SignInLogic_Screen/signInLogic.dart';

class UserDataCURD{
static Future addNewUser({
  required UserModel userModel,
  required BuildContext context
})async{
  try{
    await firestore
        .collection('users')
        .doc(auth.currentUser!.phoneNumber)
        .set(userModel.toMap())
        .whenComplete((){
      log('Data Added');
      ShowToast.showSuccessToast(
          context: context,
          message: 'User Added Successful'
      );
      Navigator.pushAndRemoveUntil(context,
          PageTransition(
              child: const SignInLogic() ,
              type: PageTransitionType.rightToLeft
          ),
          (rout)=>false);
    });

  }catch(e){
    log(e.toString());
    ShowToast.showErrorToast(
        context: context,
        message: e.toString()
    );
  }
}
static Future<bool> checkUser() async {
  bool userPresent = false;
  try {
    await firestore
        .collection('users')
        .where('mobileNum', isEqualTo: auth.currentUser!.phoneNumber)
        .get()
        .then((value) {
      value.size > 0 ? userPresent = true : userPresent = false;
      log(value.toString());
    });
  } catch (e) {
    log(e.toString());
  }
  log(userPresent.toString());
  return userPresent;
}

static Future addUserAddress(
    {required BuildContext context,
      required AddressModel addressModel,
      required String docID
    }) async {
  try {
    await firestore
        .collection('Address')
        .doc(auth.currentUser!.phoneNumber)
        .collection('address')
        .doc(docID)
        .set(addressModel.toMap())
        .whenComplete(() {
      log('Data Added');
    ShowToast.showSuccessToast(
          context: context, message: 'Address Added Successful');
      Navigator.pop(context);
    });
  } catch (e) {
    log(e.toString());
    ShowToast.showErrorToast(context: context, message: e.toString());
  }
}

static Future<bool> checkUsersAddress() async {
  bool addressPresent = false;
  try {
    await firestore
        .collection('Address')
        .doc(auth.currentUser!.phoneNumber)
        .collection('address')
        .get()
        .then((value) =>
    value.size > 0 ? addressPresent = true : addressPresent = false);
  } catch (e) {
    log(e.toString());
  }
  log(addressPresent.toString());
  return addressPresent;
}
static Future<List<AddressModel>> getAllAddress() async {
  List<AddressModel> allAddress = [];
  AddressModel defaultAddress = AddressModel();
  try {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('Address')
        .doc(auth.currentUser!.phoneNumber)
        .collection('address')
        .get();

    snapshot.docs.forEach((element) {
      allAddress.add(AddressModel.fromMap(element.data()));
      AddressModel currentAddresss = AddressModel.fromMap(element.data());
      if (currentAddresss.isDefault == true) {
        defaultAddress = currentAddresss;
      }
    });
  } catch (e) {
    log('error Found');
    log(e.toString());
  }
  for (var data in allAddress) {
    log(data.toMap().toString());
  }
  return allAddress;
}


static Future getCurrentSelectedAddress() async {
  AddressModel defaultAddress = AddressModel();
  try {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('Address')
        .doc(auth.currentUser!.phoneNumber)
        .collection('address')
        .get();

    snapshot.docs.forEach((element) {
      AddressModel currentAddresss = AddressModel.fromMap(element.data());
      if (currentAddresss.isDefault == true) {
        defaultAddress = currentAddresss;
      }
    });
  } catch (e) {
    log('error Found');
    log(e.toString());
  }
  return defaultAddress;
}

static Future<bool> userIsSeller() async {
  try {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('users')
        .doc(auth.currentUser!.phoneNumber)
        .get();
    if (snapshot.exists) {
      UserModel userModel = UserModel.fromMap(snapshot.data()!);
      log('User Type is: ${userModel.userType!}');
      if (userModel.userType != 'user') {
        return true;
      }
    }
  } catch (e) {
    log(e.toString());
  }
  return false;
}

}