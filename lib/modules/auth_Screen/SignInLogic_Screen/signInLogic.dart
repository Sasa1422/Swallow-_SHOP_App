// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swallow1/Shared/network/AuthServer.dart';
import 'package:swallow1/Shared/network/user_data_curd_services.dart';
import 'package:swallow1/modules/auth_Screen/auth_Screen.dart';
import 'package:swallow1/modules/seller/seller_persistant_nav_bar/seller_persistant_nav_bar.dart';
import '../../../layout_Screen/layoutScreen.dart';
import '../../user/User_data_input/user_data_input_Screen.dart';

class SignInLogic extends StatefulWidget {
  const SignInLogic({super.key});

  @override
  State<SignInLogic> createState() => _SignInLogicState();
}

class _SignInLogicState extends State<SignInLogic> {

  checkUser() async{
    bool userAlreadythere = await UserDataCURD.checkUser();

    if(userAlreadythere==true){
      bool UserIsSeller=await UserDataCURD.userIsSeller();
      log('start');
      if(UserIsSeller == true){
        Navigator.push(context,
            PageTransition(
                child: const SellerBottomNavBar() ,
                type: PageTransitionType.rightToLeft
            )
        );
      }
      else{
        Navigator.push(context,
            PageTransition(
                child: const UserBottomNavBar() ,
                type: PageTransitionType.rightToLeft
            )
        );
      }
    }else{
      Navigator.push(context,
        PageTransition(
          child: const UserDataInputScreen() ,
          type: PageTransitionType.rightToLeft
      )
  );
}

  }
  checkAuthentication(){
    bool userIsAuthenticated= AuthServices.checkAuthentication();
    userIsAuthenticated
        ? checkUser()
        :Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child:const AuthScreen() ,
            type:PageTransitionType.rightToLeft
        ),
            (route) => false
    );
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkAuthentication();
    });
  }
  @override
  Widget build(BuildContext context) {
    return const  Scaffold(
      body: Image(
        image: AssetImage('assets/images/amazon_splash_screen.png'),
        fit: BoxFit.fill,
      ),
    );
  }
}
