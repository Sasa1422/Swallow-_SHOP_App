import 'package:flutter/material.dart';
import 'package:swallow1/Shared/network/user_data_curd_services.dart';
import '../../model_Screen/address_model.dart';

class AddressProvider extends ChangeNotifier {
  List<AddressModel> allAdressModel = [];
  AddressModel currentSelectedAddress = AddressModel();
  bool fetchedCurrentSelectedAddress = false;
  bool fetchedAllAddress = false;
  bool addressPresent = false;

  getAllAddress() async {
    allAdressModel = await UserDataCURD.getAllAddress();
    fetchedAllAddress = true;
    notifyListeners();
  }

  getCurrentSelectedAddress() async {
    currentSelectedAddress = await UserDataCURD.getCurrentSelectedAddress();
    addressPresent = await UserDataCURD.checkUsersAddress();
    fetchedCurrentSelectedAddress = true;
    notifyListeners();
  }
}
