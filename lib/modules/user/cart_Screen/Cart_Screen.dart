import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:swallow1/Shared/network/Users_Product_Service.dart';
import 'package:swallow1/model_Screen/user_product_model.dart';

import '../../../Shared/styles/colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width,height*0.1),
        child: Container(
          padding: EdgeInsets.only(
              left: width * 0.03,
              right: width * 0.03,
              bottom: height * 0.012,
              top: height * 0.045),
          decoration:BoxDecoration(
              gradient: LinearGradient(
                colors: appBarGradientColor,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,

              )
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width:width *.8,
                child: TextField(
                  onTap: (){
                    log('Redirecting you to Search product Screen');
                  },
                  cursorColor: black,
                  decoration:InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Search Swallow in',
                    prefixIcon: IconButton(icon:const Icon(Icons.search,color: Colors.black,),
                      onPressed: (){},
                    ),
                    suffixIcon: IconButton(icon:const Icon(Icons.camera_alt_outlined,color: Colors.grey,),
                      onPressed: (){},
                    ),
                    contentPadding: EdgeInsets.all(10),
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: grey),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: grey),
                    ),
                    enabledBorder:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: grey),
                    ),
                    disabledBorder:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: grey),
                    ),
                    errorBorder:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: grey),
                    ),
                  ) ,
                ),
              ),
              IconButton(onPressed: (){}, icon: const Icon(Icons.mic),color: Colors.grey,)


            ],
          ),
        ),

      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder(
                    stream: UsersProductService.fetchCartProducts(),
                    builder: (context,snapshout){
                      if(snapshout.data!.isEmpty){
                        return Center(child: Text(
                          'Opps! You don\'t have any Product in Cart',
                          style: textTheme.bodyMedium,
                        ),);
                      }
                      if(snapshout.hasData){
                        List<UserProductModel> cartProuduct=snapshout.data!;
                       return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(text:
                            TextSpan(
                                children:[
                                  TextSpan(text: 'Subtotal',
                                      style:textTheme.bodyLarge ),
                                  TextSpan(text: 'L.E ${cartProuduct.fold(0.0, (previousValue, product) => previousValue +(product.discountedPrice!*product.productCount!)).toStringAsFixed(0)}',
                                      style:textTheme.displaySmall!
                                          .copyWith(fontWeight: FontWeight.bold) ),
                                ]
                            ),
                            ),
                            const SizedBox(height: 10,),
                            SizedBox(
                              height: height*.06,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.teal,
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        RichText(
                                          textAlign: TextAlign.justify,
                                          text:
                                          TextSpan(
                                              children:[ TextSpan(
                                                text: 'your Order is eligible for FREE Delivery. ',style: textTheme.bodySmall!.copyWith(color: teal),
                                              ),
                                                TextSpan(text: 'Select this option at checkout.',style: textTheme.bodySmall),
                                                TextSpan(
                                                  text: 'Details ',style: textTheme.bodySmall!.copyWith(color: teal),
                                                ),
                                              ]
                                          ),
                                        ),

                                      ],
                                    ),
                                  )
                                ],
                              ),

                            ),
                            const SizedBox(height: 20,),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: amber,minimumSize: Size(width, height*.06),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                onPressed: (){},
                                child: Text('Preceed to Buy',
                                  style: textTheme.bodyMedium,
                                )
                            ),
                            const SizedBox(height: 5,),
                            Divider(
                              color: grey,
                              height: height*.02,
                            ),
                            const SizedBox(height: 5,),
                            ListView.builder(
                                itemCount: cartProuduct.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context,index){
                                  UserProductModel currenProuduct=cartProuduct[index];
                                  return  Container(
                                    height: height*.3,
                                    width: width,
                                    padding: EdgeInsets.symmetric(vertical: height*.01),
                                    margin: EdgeInsets.symmetric(
                                      vertical: height*.02,
                                      horizontal: width*.009,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: greyShade1
                                    ),
                                    child:Row(children: [
                                      Expanded(
                                        flex: 4,
                                        child: Column(children: [
                                           Image(image: NetworkImage(
                                              currenProuduct.imagesURL![0],
                                          ),
                                            fit: BoxFit.contain,
                                          ),
                                          SizedBox(height: 10,),
                                          Container(
                                            height: height*.06,
                                            width: width*.4,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: greyShade3),),
                                            child:Row(children: [
                                              Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    height: double.infinity,
                                                      width: double.infinity,

                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(

                                                        border: Border(right: BorderSide(color: greyShade3),
                                                        ),
                                                      ),
                                                      child: IconButton(
                                                        onPressed: ()async{
                                                          if(currenProuduct.productCount==1){
                                                            await UsersProductService
                                                                .removeProductfromCart(
                                                                productId: currenProuduct.productID!,
                                                                context: context);
                                                          }
                                                          await  UsersProductService.updateCountCartProduct(
                                                              productId: currenProuduct.productID!,
                                                              newCount:currenProuduct.productCount!-1 ,
                                                              context: context);
                                                        },
                                                        icon: const Icon(Icons.remove),))),
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  color: white,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    currenProuduct.productCount.toString(),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    height: double.infinity,
                                                      width: double.infinity,

                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                        
                                                        border: Border(left:BorderSide(color: greyShade3),
                                                        ),
                                                      ),
                                                      child: IconButton(
                                                        onPressed: ()async{
                                                        await  UsersProductService.updateCountCartProduct(
                                                            productId: currenProuduct.productID!,
                                                            newCount:currenProuduct.productCount!+1 ,
                                                            context: context);
                                                        },
                                                        icon: const Icon(Icons.add),)
                                                  )
                                              ),
                                            ],
                                            ) ,
                                          )
                                        ],),
                                      ),
                                      const SizedBox(width: 20,),
                                      Expanded(
                                          flex:7,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                currenProuduct.name!,
                                                style: textTheme.bodyLarge,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 10,),
                                              Text(
                                                ' L.E ${currenProuduct.discountedPrice!.toStringAsFixed(0)}',
                                                style: textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(height: 10,),
                                              Text(
                                                'MRP: L.E  ${currenProuduct.price!.toStringAsFixed(0)}',
                                                style: textTheme.labelMedium!.copyWith(color: grey),
                                              ),
                                              const SizedBox(height: 10,),
                                              Text(
                                                currenProuduct.discountedPrice!>499? 'Eligible For Free Shipping':'Extra Delivery Charges Applied',
                                                style: textTheme.labelMedium!.copyWith(color: grey),
                                              ),
                                              const SizedBox(height: 10,),
                                              Text(
                                                'inStok',
                                                style: textTheme.bodySmall!.copyWith(color:teal),
                                              ),
                                              const SizedBox(height: 10,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: ()async{
                                                      await UsersProductService
                                                          .removeProductfromCart(
                                                          productId: currenProuduct.productID!,
                                                          context: context);
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor:white,
                                                      side:BorderSide(
                                                          color:greyShade3
                                                      ),
                                                    ),
                                                    child: Text(
                                                      'Delet',
                                                      style: textTheme.bodySmall!.copyWith(color: Colors.black),),
                                                  ),
                                                  Container(
                                                    child: ElevatedButton(
                                                        onPressed: (){},
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor:white,
                                                          side:BorderSide(
                                                              color:greyShade3
                                                          ),
                                                        ),
                                                        child: Text(
                                                          'Save for later',
                                                          style: textTheme.bodySmall!.copyWith(color: Colors.black),)),
                                                  )
                                                ],
                                              )
                                            ],
                                          )),
                                    ],),
                                  );
                                }

                            )
                          ],
                        );
                      }else if(snapshout.hasError){
                        return  const Center(child: Text('Opps! Error Found'));
                      }else{
                        return const Center(child: Text('Opps! No Product Add To Cart'),);
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
