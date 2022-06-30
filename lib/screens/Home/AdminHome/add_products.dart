// ignore_for_file: prefer_const_constructors, unused_catch_clause, non_constant_identifier_names, library_prefixes, avoid_print

import 'dart:math';

import 'package:JoGenics/components/categories.dart' as fetchCategories;
import 'package:JoGenics/components/app_bar.dart';
import 'package:JoGenics/components/title_case.dart';
import 'package:JoGenics/db.dart' as db;
import 'package:JoGenics/components/dialog.dart' as dialog;
import 'package:JoGenics/components/rounded_button.dart';
import 'package:JoGenics/components/rounded_input_field.dart';
import 'package:JoGenics/constants.dart';
import 'package:JoGenics/main.dart';
import 'package:JoGenics/screens/Home/AdminHome/body.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final random = Random();
  final _formKey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final quantityController = TextEditingController();
  final costPriceController = TextEditingController();
  final mrpController = TextEditingController();
  final phoneController = TextEditingController();
  late String productID = '';

  generateProductID() async {
    var id = random.nextInt(db.SubscriptionPackage == 'standard'
        ? 1000000
        : db.SubscriptionPackage == 'basic'
            ? 500
            : 100);
    try {
      if (await db.checkForValidProductId(id.toString()) == false) {
        // await generateCustomerID();
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return dialog.ReturnDialog4(
                title: Text('Error'),
                message:
                    'Invalid product id! It is possible that your product database is full. If error persist after multiple refresh, you may have to purchase the standard package.',
                color: errorColor,
                button1Text: 'Cancel',
                onPressed1: () {
                  Navigator.of(context).pop();
                },
                button2Text: 'Refresh',
                onPressed2: () async {
                  Navigator.of(context).pop();
                  await generateProductID();
                },
              );
            });
      } else {
        setState(() {
          productID = id.toString();
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: primaryColor2,
            content: Text("Product id generated successfully..")));
      }
    } on Exception catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: errorColor,
          content: Text("No internet connection!")));
    }
  }

  final lounges = {'', 'Regular', 'VIP'};
  DropdownMenuItem<String> buildLounges(String Lounge) => DropdownMenuItem(
      value: Lounge,
      child: Text(
        Lounge,
      ));

  final categories = {''};
  getCategories() async {
    for (var data in fetchCategories.categories) {
      categories.add(data['name'] as String);
    }
  }

  DropdownMenuItem<String> buildCategories(String Category) => DropdownMenuItem(
      value: Category,
      child: Text(
        Category,
      ));

  late var subCategories = {''};
  getSubCategories(category) {
    List liveData = [];
    liveData.clear();
    subCategories = {''};
    subCategory = null;
    for (var data in fetchCategories.sub_categories) {
      if (category == data['category']) {
        liveData.add(data['types']);
        for (var types in liveData[0]) {
          subCategories.add(types['name']);
        }
      }
    }
    return liveData;
  }

  DropdownMenuItem<String> buildSubCategories(String SubCategory) =>
      DropdownMenuItem(
          value: SubCategory,
          child: Text(
            SubCategory,
          ));

  @override
  void initState() {
    lounge = null;
    category = null;
    subCategory = null;
    getCategories();
    generateProductID();
    super.initState();
  }

  @override
  void dispose() {
    productNameController.dispose();
    quantityController.dispose();
    costPriceController.dispose();
    mrpController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MainWindowNavigation(
        leftChild: buildLeftChild(
            fullname: db.CurrentLoggedInUserLastname != ''
                ? db.CurrentLoggedInUserLastname.toTitleCase()
                : db.CurrentLoggedInUserLastname,
            emailaddress: db.CurrentLoggedInUserEmail,
            selected0: false,
            selected1: false,
            selected2: false,
            selected3: false,
            selected4: true,
            selected5: false,
            selected6: false,
            selected7: false,
            selected8: false,
            selectedPage: () => null),
        rightChild: Scaffold(
            backgroundColor: customBackgroundColor,
            appBar: buildAppBar(context, 'Add Product', blackColor, false),
            body: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Product ID: $productID',
                                style: TextStyle(
                                    fontSize: size.width * 0.015,
                                    fontFamily: 'Biko')),
                            SizedBox(width: size.width * 0.02),
                            RoundedButtonRefresh(
                                color: primaryColor,
                                size: size.width * 0.025,
                                onPressed: () async {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Please wait..")));
                                  await generateProductID();
                                }),
                          ],
                        ),
                        SizedBox(height: size.height * 0.03),
                        RoundedInputField3c(
                            controller: productNameController,
                            mainText: '',
                            hintText: "Product name",
                            icon: Icons.shopping_bag_rounded,
                            onChanged: (value) {
                              value = productNameController.text.trim();
                            }),
                        // SizedBox(height: size.height * 0.01),
                        // RoundedInputField3b3(
                        //   width: size.width * 0.5,
                        //   radius: 20,
                        //   controller: quantityController,
                        //   hideText: false,
                        //   mainText: '0',
                        //   hintText: "Quantity in stock",
                        //   warningText: 'Required!',
                        //   icon: Icons.numbers,
                        //   onChanged: (value) {
                        //     value = quantityController.text.trim();
                        //   },
                        // ),
                        SizedBox(height: size.height * 0.01),
                        RoundedInputField3b3(
                          width: size.width * 0.5,
                          radius: 20,
                          controller: costPriceController,
                          hideText: false,
                          mainText: '0',
                          hintText: "Cost price",
                          warningText: 'Required!',
                          icon: Icons.numbers,
                          onChanged: (value) {
                            value = costPriceController.text.trim();
                          },
                        ),
                        SizedBox(height: size.height * 0.01),
                        RoundedInputField3b3(
                          width: size.width * 0.5,
                          radius: 20,
                          controller: mrpController,
                          hideText: false,
                          mainText: '0',
                          hintText: "Market retail price",
                          warningText: 'Required!',
                          icon: Icons.numbers,
                          onChanged: (value) {
                            value = mrpController.text.trim();
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: transparentColor, width: 2),
                            color: whiteColor,
                          ),
                          child: ListTile(
                            leading: Icon(Icons.vertical_shades_sharp,
                                color: primaryColor),
                            title: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text('Lounge'),
                                isExpanded: true,
                                value: lounge,
                                iconSize: 30,
                                items: lounges.map(buildLounges).toList(),
                                onChanged: (value) async => setState(() {
                                  lounge = value;
                                }),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: transparentColor, width: 2),
                            color: whiteColor,
                          ),
                          child: ListTile(
                            leading: Icon(Icons.category_rounded,
                                color: primaryColor),
                            title: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text('Category'),
                                isExpanded: true,
                                value: category,
                                iconSize: 30,
                                items: categories.map(buildCategories).toList(),
                                onChanged: (value) async => setState(() {
                                  category = value;
                                  getSubCategories(category!);
                                }),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: transparentColor, width: 2),
                            color: whiteColor,
                          ),
                          child: ListTile(
                            leading: Icon(Icons.category_outlined,
                                color: primaryColor),
                            title: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text('Sub category'),
                                isExpanded: true,
                                value: subCategory,
                                iconSize: 30,
                                items: subCategories
                                    .map(buildSubCategories)
                                    .toList(),
                                onChanged: (value) async => setState(() {
                                  subCategory = value;
                                }),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        RoundedInputField3b(
                          width: size.width * 0.5,
                          radius: 20,
                          controller: phoneController,
                          hideText: false,
                          mainText: '',
                          hintText: "Vendor's phone number",
                          warningText: 'Enter a valid phone number!',
                          icon: Icons.numbers,
                          onChanged: (value) {
                            value = phoneController.text.trim();
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              color: customBackgroundColor,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RoundedButtonMain(
                        text1: 'Add',
                        text2: 'Adding...',
                        fontSize1: size.width * 0.01,
                        fontSize2: size.width * 0.008,
                        width: size.width * 0.1,
                        horizontalGap: size.width * 0.01,
                        verticalGap: size.height * 0.02,
                        radius: size.width * 0.02,
                        isLoading: false,
                        function: () async {
                          final form = _formKey.currentState!;
                          if (lounge != null &&
                              lounge != '' &&
                              category != null &&
                              category != '' &&
                              subCategory != null &&
                              subCategory != '') {
                            if (form.validate()) {
                              try {
                                for (var data in db.ProductsRecord) {
                                  if (productNameController.text
                                              .trim()
                                              .toLowerCase() !=
                                          data['productid'] &&
                                      lounge!.toLowerCase() != data['lounge']) {
                                    if (await db.addProduct(
                                            productID,
                                            productNameController.text.trim(),
                                            quantityController.text.trim(),
                                            costPriceController.text.trim(),
                                            mrpController.text.trim(),
                                            lounge,
                                            category,
                                            subCategory,
                                            phoneController.text.trim()) ==
                                        true) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: primaryColor2,
                                              content: Text(
                                                  "${productNameController.text.trim().toTitleCase()} added as successfully. Please restart this tab..")));
                                      Navigator.of(context).pop();
                                    } else {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return dialog.ReturnDialog1(
                                              title: Text('Error'),
                                              message: 'Unable to add product!',
                                              color: errorColor,
                                              buttonText: 'Retry',
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            );
                                          });
                                    }
                                  } else {
                                    print('already exist!');
                                  }
                                }
                              } on Exception catch (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: errorColor,
                                        content:
                                            Text("No internet connection!")));
                              }
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: errorColor,
                                content: Text("All fields are required!")));
                          }
                        }),
                  ],
                ),
              ),
            )),
        isLogout: false, destroyApp: true,);
  }
}
