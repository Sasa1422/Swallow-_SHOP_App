import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:swallow1/Shared/styles/colors.dart';

import '../../Shared/network/AuthServer.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
 bool inLogin=true;
 String currentCountryCode='+20';
 var phoneController=TextEditingController();
 var nameController =TextEditingController();


 @override
  Widget build(BuildContext context) {
    final height= MediaQuery.of(context).size.height;
    final width= MediaQuery.of(context).size.height;
    final textTheme=Theme.of(context).textTheme;

    return  Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle:true ,
        title:  Image(
          image: const AssetImage(
              'assets/images/amazon_logo.png'),
        height: height*0.04,

        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              height: height,
              width: width,
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.03,
                vertical: height * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcom',
                    style: textTheme.displaySmall!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20,),
                  Builder(builder: (context){
                    if(inLogin){
                      return SignIn(width, height, textTheme, context);
                    }
                       return CreateAccount(width, height, textTheme, context);
                  }),
                  const SizedBox(height: 30,),
                  const BottomAuthScreenWidget(),
                ],
              ),
            ),
        ),
      ),
    );
  }
 Container SignIn(
     double width, double height, TextTheme textTheme, BuildContext context) {
   return Container(
     width: width,
     decoration: BoxDecoration(
       border: Border.all(
         color: greyShade3,
       ),
     ),
     child: Column(
       children: [
         Container(
           height: height * 0.06,
           width: width,
           decoration: BoxDecoration(
             border: Border(
               bottom: BorderSide(color: greyShade3),
             ),
             color: greyShade1,
           ),
           padding: EdgeInsets.symmetric(horizontal: width * 0.02),
           child:  InkWell(
             onTap: () {
               setState(() {
                 inLogin = false;
               });
             },
             child: Row(
               children: [
                 Container(
                     height: height * 0.02,
                     width: height * 0.02,
                     decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         border: Border.all(color: grey),
                         color: white),
                     alignment: Alignment.center,
                     child: Icon(
                       Icons.circle,
                       size: height * 0.015,
                       color: inLogin ? transparent : secondaryColor,
                     ),
                   ),

                 SizedBox(height: 20,),
                 RichText(
                   text: TextSpan(
                     children: [
                       TextSpan(
                           text: 'Create Account. ',
                           style: textTheme.bodySmall!
                               .copyWith(fontWeight: FontWeight.bold)),
                       TextSpan(
                           text: 'New to Amazon? ', style: textTheme.bodySmall)
                     ],
                   ),
                 ),
               ],
             ),
           ),
         ),
         Container(
           width: width,
           padding: EdgeInsets.symmetric(
             horizontal: width * 0.03,
             vertical: height * 0.01,
           ),
           child: Column(
             children: [
               InkWell(
               onTap: () {
                        setState(() {
                           inLogin = true;
                      });
                    },
                 child: Row(
                   children: [
                     Container(
                         height: height * 0.02,
                         width: height * 0.02,
                         decoration: BoxDecoration(
                             shape: BoxShape.circle,
                             border: Border.all(color: grey),
                             color: white),
                         alignment: Alignment.center,
                         child: Icon(
                           Icons.circle,
                           size: height * 0.015,
                           color: inLogin ? secondaryColor : transparent,
                         ),
                       ),

                     SizedBox(height: 20,),
                     RichText(
                       text: TextSpan(
                         children: [
                           TextSpan(
                               text: 'Sign in. ',
                               style: textTheme.bodySmall!
                                   .copyWith(fontWeight: FontWeight.bold)),
                           TextSpan(
                               text: 'Already a Customer',
                               style: textTheme.bodySmall)
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
               SizedBox(height: 20,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   InkWell(
                     onTap: () {
                       showCountryPicker(
                           context: context,
                           onSelect: (val) {
                             setState(() {
                               currentCountryCode = '+${val.phoneCode}';
                             });
                           });
                     },
                     child: Container(
                       height: height * 0.06,
                       width: width * 0.1,
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                         border: Border.all(
                           color: grey,
                         ),
                         color: greyShade2,
                         borderRadius: BorderRadius.circular(
                           5,
                         ),
                       ),
                       child: Text(
                         currentCountryCode,
                         style: textTheme.displaySmall!.copyWith(
                           fontWeight: FontWeight.w600,
                         ),
                       ),
                     ),
                   ),
                   SizedBox(
                     height: height * 0.06,
                     width: width * 0.25,
                     child: TextFormField(
                       controller: phoneController,
                       cursorColor: black,
                       style: textTheme.displaySmall,
                       keyboardType: TextInputType.number,
                       decoration: InputDecoration(
                         hintText: 'Mobile number',
                         hintStyle: textTheme.bodySmall,
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(5),
                           borderSide: BorderSide(
                             color: grey,
                           ),
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(5),
                           borderSide: const BorderSide(
                             color: secondaryColor,
                           ),
                         ),
                         disabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(5),
                           borderSide: BorderSide(
                             color: grey,
                           ),
                         ),
                         enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(5),
                           borderSide: BorderSide(
                             color: grey,
                           ),
                         ),
                       ),
                     ),
                   )
                 ],
               ),
               SizedBox(height: 20,),
               CommonAuthButton(
                 title: 'Continue',
                 onPressed: () {
                 AuthServices.receiveOTP(
                       context: context,
                       mobileNo:
                       '$currentCountryCode${phoneController.text.trim()}');
                 },
                 btnWidth: 0.88,
               ),
               SizedBox(height: 20,),

               RichText(
                 text: TextSpan(
                   children: [
                     TextSpan(
                       text: 'By Continuing you agree to Amazon\'s ',
                       style: textTheme.labelMedium,
                     ),
                     TextSpan(
                       text: 'Conditions of use ',
                       style: textTheme.labelMedium!.copyWith(color: blue),
                     ),
                     TextSpan(
                       text: 'and ',
                       style: textTheme.labelMedium,
                     ),
                     TextSpan(
                       text: 'Privacy Notice',
                       style: textTheme.labelMedium!.copyWith(color: blue),
                     )
                   ],
                 ),
               ),
             ],
           ),
         ),
       ],
     ),
   );
 }

 Container CreateAccount(
     double width, double height, TextTheme textTheme, BuildContext context) {
   return Container(
     width: width,
     decoration: BoxDecoration(
       border: Border.all(
         color: greyShade3,
       ),
     ),
     child: Column(
       children: [
         Container(
           width: width,
           padding: EdgeInsets.symmetric(
             horizontal: width * 0.03,
             vertical: height * 0.02,
           ),
           child: Column(
             children: [
               Row(
                 children: [
                   InkWell(
                     onTap: () {
                       setState(() {
                         inLogin = false;
                       });
                     },
                     child: Container(
                       height: height * 0.02,
                       width: height * 0.02,
                       decoration: BoxDecoration(
                           shape: BoxShape.circle,
                           border: Border.all(color: grey),
                           color: white),
                       alignment: Alignment.center,
                       child: Icon(
                         Icons.circle,
                         size: height * 0.015,
                         color: inLogin ? transparent : secondaryColor,
                       ),
                     ),
                   ),
                   SizedBox(height: 20,),
                   RichText(
                     text: TextSpan(
                       children: [
                         TextSpan(
                             text: 'Create Account. ',
                             style: textTheme.bodySmall!
                                 .copyWith(fontWeight: FontWeight.bold)),
                         TextSpan(
                             text: 'New to Amazon?',
                             style: textTheme.bodySmall)
                       ],
                     ),
                   ),
                 ],
               ),
               SizedBox(height: 20,),
               SizedBox(
                 height: height * 0.06,
                 child: TextField(
                   controller: nameController,
                   decoration: InputDecoration(
                     hintText: 'First and Last Name',
                     hintStyle: textTheme.bodySmall,
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(5),
                       borderSide: BorderSide(
                         color: grey,
                       ),
                     ),
                     focusedBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(5),
                       borderSide: const BorderSide(
                         color: secondaryColor,
                       ),
                     ),
                     disabledBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(5),
                       borderSide: BorderSide(
                         color: grey,
                       ),
                     ),
                     enabledBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(5),
                       borderSide: BorderSide(
                         color: grey,
                       ),
                     ),
                   ),
                 ),
               ),
               SizedBox(height: 20,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   InkWell(
                     onTap: () {
                       showCountryPicker(
                           context: context,
                           onSelect: (val) {
                             setState(() {
                               currentCountryCode = '+${val.phoneCode}';
                             });
                           });
                     },
                     child: Container(
                       height: height * 0.06,
                       width: width * 0.1,
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                         border: Border.all(
                           color: grey,
                         ),
                         color: greyShade2,
                         borderRadius: BorderRadius.circular(
                           5,
                         ),
                       ),
                       child: Text(
                         currentCountryCode,
                         style: textTheme.displaySmall!.copyWith(
                           fontWeight: FontWeight.w600,
                         ),
                       ),
                     ),
                   ),
                   SizedBox(
                     height: height * 0.06,
                     width: width * 0.25,
                     child: TextFormField(
                       controller: phoneController,
                       cursorColor: black,
                       style: textTheme.displaySmall,
                       keyboardType: TextInputType.number,
                       decoration: InputDecoration(
                         hintText: 'Mobile number',
                         hintStyle: textTheme.bodySmall,
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(5),
                           borderSide: BorderSide(
                             color: grey,
                           ),
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(5),
                           borderSide: const BorderSide(
                             color: secondaryColor,
                           ),
                         ),
                         disabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(5),
                           borderSide: BorderSide(
                             color: grey,
                           ),
                         ),
                         enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(5),
                           borderSide: BorderSide(
                             color: grey,
                           ),
                         ),
                       ),
                     ),
                   )
                 ],
               ),
               SizedBox(height: 20,),

               Text(
                 'By enrolling your mobile phone number, you concent to receive automated security notifications via text message from Amazon.\nMessage and data rates may apply.',
                 style: textTheme.bodyMedium,
               ),
               SizedBox(height: 20,),

               CommonAuthButton(
                 title: 'Continue',
                 btnWidth: 0.88,
                 onPressed: () {
                   AuthServices.receiveOTP(
                       context: context,
                       mobileNo:
                       '+$currentCountryCode${phoneController.text.trim()}');
                 },
               ),
              const SizedBox(height: 20,),
               RichText(
                 text: TextSpan(
                   children: [
                     TextSpan(
                       text: 'By Continuing you agree to Amazon\'s ',
                       style: textTheme.labelMedium,
                     ),
                     TextSpan(
                       text: 'Conditions of use ',
                       style: textTheme.labelMedium!.copyWith(color: blue),
                     ),
                     TextSpan(
                       text: 'and ',
                       style: textTheme.labelMedium,
                     ),
                     TextSpan(
                       text: 'Privacy Notice',
                       style: textTheme.labelMedium!.copyWith(color: blue),
                     )
                   ],
                 ),
               ),
             ],
           ),
         ),
         Container(
           height: height * 0.06,
           width: width,
           decoration: BoxDecoration(
             border: Border(
               top: BorderSide(color: greyShade3),
             ),
             color: greyShade1,
           ),
           padding: EdgeInsets.symmetric(horizontal: width * 0.03),
           child:  InkWell(
             onTap: () {
               setState(() {
                 inLogin = true;
               });
             },
             child: Row(
               children: [
                 Container(
                     height: height * 0.02,
                     width: height * 0.02,
                     decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         border: Border.all(color: grey),
                         color: white),
                     alignment: Alignment.center,
                     child: Icon(
                       Icons.circle,
                       size: height * 0.015,
                       color: inLogin ? secondaryColor : transparent,
                     ),
                   ),
               SizedBox(height: 20,),
                 RichText(
                   text: TextSpan(
                     children: [
                       TextSpan(
                           text: 'Sign In ',
                           style: textTheme.bodyMedium!
                               .copyWith(fontWeight: FontWeight.bold)),
                       TextSpan(
                           text: 'Already a Customer? ',
                           style: textTheme.bodyMedium)
                     ],
                   ),
                 ),
               ],
             ),
           ),
         ),
       ],
     ),
   );
 }
}
class BottomAuthScreenWidget extends StatelessWidget {
  const BottomAuthScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          height: 2,
          width: width,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [white, greyShade3, white])),
        ),
       const SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Condition of Use',
              style: textTheme.labelMedium!.copyWith(
                color: blue,
              ),
            ),
            Text(
              'Privacy Notice',
              style: textTheme.labelMedium!.copyWith(
                color: blue,
              ),
            ),
            Text(
              'Help',
              style: textTheme.labelMedium!.copyWith(
                color: blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30,),
        Text(
          '© 1996-2023, Amazon.com, Inc. or its affiliates',
          style: textTheme.labelMedium!.copyWith(
            color: grey,
          ),
        ),
      ],
    );
  }
}

class CommonAuthButton extends StatelessWidget {
  CommonAuthButton(
      {super.key,
        required this.title,
        required this.onPressed,
        required this.btnWidth});
  String title;
  VoidCallback onPressed;
  double btnWidth;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width * btnWidth, height * 0.06),
        backgroundColor: amber,
      ),
      child: Text('Continue', style: textTheme.displaySmall),
    );
  }
}