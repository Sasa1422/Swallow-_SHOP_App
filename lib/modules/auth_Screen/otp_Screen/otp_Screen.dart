import 'package:flutter/material.dart';
import 'package:swallow1/Shared/styles/colors.dart';

import '../../../Shared/network/AuthServer.dart';
import '../auth_Screen.dart';


class OTPScreen extends StatefulWidget {
   OTPScreen({super.key, required this.mobileNumber});
String mobileNumber;
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String currentCountryCode='+20';
  var phoneController=TextEditingController();
  var otpController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height= MediaQuery.of(context).size.height;
    final width= MediaQuery.of(context).size.height;
    final textTheme=Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title:  Image(image: AssetImage('assets/images/amazon_logo.png'),
        height: height*0.04,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Authentication required',
                style: textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Text(
                        '+201149232811',
                        style: textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600),
                      ),
                      TextButton(onPressed:(){
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context)=>
                                      const AuthScreen()),
                                (route) => false
                        );
                      },
                          child:Text(
                            'Change',
                            style: textTheme.bodyMedium!.copyWith(color: grey),

                          ))
                    ],
                  ),
                   Text(
                    'We have sent a One Time Password (OTP) to the'
                        ' mobile number above. Please enter it to complete'
                        ' Varification ',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: textTheme.labelMedium,

                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: height * 0.06,
                    width: width ,
                    child: TextFormField(
                      controller: otpController,
                      cursorColor: black,
                      style: textTheme.displaySmall,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter OTP',
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
                  CommonAuthButton(
                    title: 'Continue',
                    btnWidth: 0.88,
                    onPressed: () {
                      AuthServices.verifyOTP(
                        context: context,
                        otp: otpController.text.trim(),
                      );
                    },
                  ),
                  Center(
                    child: TextButton(
                        onPressed: (){
                          AuthServices.receiveOTP(
                              context: context,
                              mobileNo:
                              '+$currentCountryCode${phoneController.text.trim()}');
                        },
                        child: Text(
                          'Resend OTP'
                        ),),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              const BottomAuthScreenWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
