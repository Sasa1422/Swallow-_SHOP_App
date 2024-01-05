import 'package:flutter/material.dart';
import 'package:swallow1/Shared/network/user_data_curd_services.dart';
import 'package:swallow1/model_Screen/address_model.dart';
import 'package:uuid/uuid.dart';
import '../../../Shared/components/constans.dart';
import '../../../Shared/styles/colors.dart';
import 'Widget/Address_Screen_textField.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  var nameController=TextEditingController();
  var mobilController=TextEditingController();
  var houseController=TextEditingController();
  var areaController=TextEditingController();
  var landMarkController=TextEditingController();
  var pinCodeController=TextEditingController();
  var townController=TextEditingController();
  var stateController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar:PreferredSize(
        preferredSize:Size(width, height*.08),
        child:Container(
          padding: EdgeInsets.only(
              left: width * 0.03,
              right: width * 0.03,
              bottom: height * 0.012,
              top: height * 0.045),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: appBarGradientColor,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,

              )
          ),
          child:  Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: const AssetImage(
                    'assets/images/amazon_black_logo.png'),
                height: height*0.05,

              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_none,
                  color: black,
                  size: height * 0.035,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: black,
                  size: height * 0.035,
                ),
              ),

            ],
          ),
        ),
      ),
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(
            horizontal: width*.03,
            vertical: height*.02
        ),
        child:SingleChildScrollView(
          child: Column(
            children: [
              AddressScreenTextField(
                title: 'Enter your name',
                hintText: 'Enter your name',
                textController: nameController,
              ),
              const SizedBox(height: 10,),
              AddressScreenTextField(
                title: 'Enter your Mobile Number',
                hintText: 'Enter your Mobile Number',
                textController: mobilController,
              ),
              const SizedBox(height: 10,),
              AddressScreenTextField(
                title: 'Enter your House No.',
                hintText: 'Enter your house number',
                textController: houseController,
              ),
              const SizedBox(height: 10,),
              AddressScreenTextField(
                title: 'Enter your Area',
                hintText: 'Area',
                textController: areaController,
              ),
              const SizedBox(height: 10,),
              AddressScreenTextField(
                title: 'Enter your LandMark',
                hintText: 'Landmark',
                textController: landMarkController,
              ),
              const SizedBox(height: 10,),
              AddressScreenTextField(
                title: 'Enter your PINCODE',
                hintText: 'pincode',
                textController: pinCodeController,
              ),
              const SizedBox(height: 10,),
              AddressScreenTextField(
                title: 'Enter your Town',
                hintText: 'Town',
                textController: townController,
              ),
              const SizedBox(height: 10,),
              AddressScreenTextField(
                title: 'Enter your State',
                hintText: 'State',
                textController: stateController,
              ),
              const SizedBox(height: 10,),
              ElevatedButton(onPressed: (){
                Uuid uuid = Uuid();
                String docID = uuid.v1();
                AddressModel addressModel = AddressModel(
                  name: nameController.text.trim(),
                  mobileNumber: mobilController.text.trim(),
                  authenticatedMobileNumber: auth.currentUser!.phoneNumber,
                  houseNumber: houseController.text.trim(),
                  area: areaController.text.trim(),
                  landMark: landMarkController.text.trim(),
                  pincode: pinCodeController.text.trim(),
                  town: townController.text.trim(),
                  state: stateController.text.trim(),
                  docID: docID,
                  isDefault: true,
                );

                UserDataCURD.addUserAddress(
                  context: context,
                  addressModel: addressModel,
                  docID: docID,
                );
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: amber,
                  minimumSize: Size(
                    width,
                    height * 0.06,
                  ),
                ),
                  child: Text(
                      'Add Address',
                    style: textTheme.bodyMedium,
                  ),
              ),
              const SizedBox(height: 10,),

            ],
          ),
        ) ,
      ),
    );
  }
}
