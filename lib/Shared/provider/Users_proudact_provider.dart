import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:swallow1/Shared/network/Users_Product_Service.dart';
import 'package:swallow1/model_Screen/Product_Model.dart';

class UserProductProvider extends ChangeNotifier{
  List<ProductModel> searchProduct=[];
  bool productsFetched =false;

  emptySearchedProductsList(){
    searchProduct=[];
    productsFetched = false;
    notifyListeners();
  }

  getSearchedProducts({required String productName})async{
    searchProduct= await UsersProductService.getProducts(productName);
    productsFetched=true;
    notifyListeners();

  }

}