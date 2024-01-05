import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swallow1/Shared/provider/Product_Provider.dart';
import 'package:swallow1/Shared/provider/Users_proudact_provider.dart';
import 'package:swallow1/Shared/provider/address_provider.dart';
import 'package:swallow1/Shared/provider/auth_provider.dart';
import 'package:swallow1/Shared/provider/deel_Of_Day_Provider.dart';
import 'package:swallow1/Shared/styles/theme.dart';
import 'package:swallow1/modules/auth_Screen/SignInLogic_Screen/signInLogic.dart';

import 'Shared/provider/Product_by _category_Provider.dart';
import 'Shared/provider/rating_Provider.dart';
import 'layout_Screen/layoutScreen.dart';
import 'modules/seller/add_product_Screen/add_product_Screen.dart';
import 'modules/seller/seller_persistant_nav_bar/seller_persistant_nav_bar.dart';

Future main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
         ChangeNotifierProvider<authProvider>(
             create: (context)=>authProvider()),
        ChangeNotifierProvider<AddressProvider>(
            create: (context)=>AddressProvider()),
        ChangeNotifierProvider<SellerProductProvider>(
            create: (context)=>SellerProductProvider()),
        ChangeNotifierProvider<UserProductProvider>(
            create: (context)=>UserProductProvider()),
        ChangeNotifierProvider<DealOfTheDayProvider>(
            create: (context)=>DealOfTheDayProvider()),
        ChangeNotifierProvider<ProductsBasedOnCategoryProvider>(
            create: (context)=>ProductsBasedOnCategoryProvider()),
        ChangeNotifierProvider<RatingProvider>(
            create: (_) => RatingProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
           theme: theme,
           home:   const SignInLogic(),
      ),
    );
  }
}
