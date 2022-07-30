// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unused_catch_clause, avoid_print

import 'dart:io';

import 'package:JoGenics/components/rounded_password_field.dart';
import 'package:JoGenics/db.dart' as db;
import 'package:JoGenics/components/dialog.dart' as dialog;
import 'package:JoGenics/components/app_bar.dart';
import 'package:JoGenics/components/custom_page_route.dart';
// import 'package:JoGenics/components/rounded_button.dart';
import 'package:JoGenics/components/rounded_input_field.dart';
import 'package:JoGenics/constants.dart';
import 'package:JoGenics/screens/Home/AdminHome/add_products.dart';
import 'package:csv/csv.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Inventory extends StatefulWidget {
  const Inventory({Key? key}) : super(key: key);

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final productController = TextEditingController();
  final passwordController = TextEditingController();
  final newValueController = TextEditingController();

  late List liveData = [];
  late List liveData2 = [];
  List selectedData = [];

  final fields = {
    '',
    'ProductName',
    // 'Quantity',
    'CostPrice',
    'MRP',
    'Lounge',
    'Category',
    'SubCategory',
    'VendorPhone',
  };
  DropdownMenuItem<String> buildFields(String field) => DropdownMenuItem(
      value: field,
      child: Text(
        field,
      ));

  changeIsSearchToFalse() {
    setState(() {
      isSearchInventory = false;
    });
  }

  getUserData1() async {
    // await db.adminSignIn(db.HotelName, db.CurrentLoggedInUserEmail,
    //     db.CurrentLoggedInUserPassword);
    changeIsSearchToFalse();
    return db.ProductsRecord;
  }

  getUserData1b() async {
    // await db.adminSignIn(db.HotelName, db.CurrentLoggedInUserEmail,
    //     db.CurrentLoggedInUserPassword);
    return db.ProductsRecord;
  }

  getUserData2() async {
    await db.fetchInventroy();
    liveData = [];
    liveData2 = [];
    int len = db.ProductsRecord.length + 1;
    for (var data in db.ProductsRecord) {
      liveData.add(data['productid']);
      liveData.add(data['productname']);
      // liveData.add(data['quantity']);
      liveData.add(data['costprice']);
      liveData.add(data['mrp']);
      liveData.add(data['lounge']);
      liveData.add(data['category']);
      liveData.add(data['subcategory']);
      liveData.add(data['vendorphone']);
    }
    late var x = 0;
    late var y = 8;
    for (var i = 1; i < len; i += 1) {
      if (i == 1) {
        liveData2.add(liveData.sublist(x, y));
      } else if (i > 1) {
        x += 8;
        y += 8;
        liveData2.add(liveData.sublist(x, y));
      }
    }
    print('Product data = $liveData2');
    return liveData2;
  }

  deleteRecord() async {
    if (selectedData.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: errorColor, content: Text("No record selected!")));
      return;
    } else {
      if (selectedData.length > 1) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return dialog.ReturnDialog4(
                title: Text(''),
                message:
                    "Do you wish to delete these ${selectedData.length} products?",
                color: navyBlueColor,
                button1Text: 'No',
                onPressed1: () {
                  Navigator.of(context).pop();
                },
                button2Text: 'Yes',
                onPressed2: () {
                  print('can delete now - multiple selection');
                  passwordController.text = '';
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return Center(
                          child: dialog.ReturnDialog4(
                              title: RoundedPasswordFieldA2(
                                  controller: passwordController),
                              message: '',
                              color: primaryColor,
                              button1Text: 'Cancel',
                              onPressed1: () {
                                Navigator.of(context).pop();
                              },
                              button2Text: 'Confirm',
                              onPressed2: () async {
                                if (passwordController.text
                                        .trim()
                                        .toLowerCase()
                                        .hashCode
                                        .toString() ==
                                    db.CurrentLoggedInUserPassword) {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      });
                                  for (var i = 0;
                                      i < selectedData.length;
                                      i += 1) {
                                    print(i);
                                    for (var data in db.ProductsRecord) {
                                      if (data['productid'] ==
                                          selectedData[i][0]) {
                                        try {
                                          if (await db.findProduct(
                                                  selectedData[i][0]) ==
                                              true) {
                                            if (await db.deleteProduct(
                                                    selectedData[i][0]) ==
                                                true) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      backgroundColor:
                                                          primaryColor2,
                                                      content: Text(
                                                          "Operation succeeded. Please wait..")));
                                            }
                                          } else {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor: errorColor,
                                                    content: Text(
                                                        "Record does not exist!")));
                                          }
                                        } on Exception catch (error) {
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: errorColor,
                                                  content: Text(
                                                      "No internet connection!")));
                                        }
                                      }
                                    }
                                  }
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  setState(() {
                                    productController.text = '';
                                    isSearchInventory = null;
                                    selectedData.clear();
                                  });
                                  getUserData1();
                                  getUserData1b();
                                  getUserData2();
                                } else {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: errorColor,
                                          content: Text("Invalid password!")));
                                }
                              }),
                        );
                      });
                },
              );
            });
      } else {
        for (var data in db.ProductsRecord) {
          if (data['productid'] == selectedData[0][0]) {
            print('can delete now - single selection');
            passwordController.text = '';
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return Center(
                    child: dialog.ReturnDialog4(
                        title: RoundedPasswordFieldA2(
                            controller: passwordController),
                        message: '',
                        color: primaryColor,
                        button1Text: 'Cancel',
                        onPressed1: () {
                          Navigator.of(context).pop();
                        },
                        button2Text: 'Confirm',
                        onPressed2: () async {
                          if (passwordController.text
                                  .trim()
                                  .toLowerCase()
                                  .hashCode
                                  .toString() ==
                              db.CurrentLoggedInUserPassword) {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                });
                            try {
                              if (await db.findProduct(selectedData[0][0]) ==
                                  true) {
                                if (await db
                                        .deleteProduct(selectedData[0][0]) ==
                                    true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: primaryColor2,
                                          content: Text(
                                              "Operation succeeded. Please refresh..")));
                                  Navigator.of(context).pop();
                                  setState(() {
                                    productController.text = '';
                                    isSearchInventory = null;
                                    selectedData.clear();
                                  });
                                  Navigator.of(context).pop();
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      });
                                  getUserData1();
                                  getUserData1b();
                                  getUserData2();
                                  Navigator.of(context).pop();
                                }
                              } else {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: errorColor,
                                        content:
                                            Text("Record does not exist!")));
                              }
                            } on Exception catch (error) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: errorColor,
                                      content:
                                          Text("No internet connection!")));
                            }
                          } else {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: errorColor,
                                content: Text("Invalid password!")));
                          }
                        }),
                  );
                });
          }
        }
      }
    }
  }

  updateRecord() async {
    if (selectedData.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: errorColor, content: Text("No record selected!")));
      return;
    } else {
      if (selectedData.length > 1) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: errorColor, content: Text("Invalid selection!")));
        return;
      } else {
        for (var data in db.ProductsRecord) {
          if (data['productid'] == selectedData[0][0]) {
            print('can update now');
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return Center(child: CircularProgressIndicator());
                });
            try {
              if (await db.updateProduct(
                      selectedData[0][0],
                      selectedField!.toLowerCase() == 'productname'
                          ? newValueController.text.trim()
                          : selectedData[0][1],
                      // selectedField!.toLowerCase() == 'quantity'
                      //     ? newValueController.text.trim()
                      //     : selectedData[0][2],
                      selectedField!.toLowerCase() == 'costprice'
                          ? newValueController.text.trim()
                          : selectedData[0][2],
                      selectedField!.toLowerCase() == 'mrp'
                          ? newValueController.text.trim()
                          : selectedData[0][3],
                      selectedField!.toLowerCase() == 'lounge'
                          ? newValueController.text.trim()
                          : selectedData[0][4],
                      selectedField!.toLowerCase() == 'category'
                          ? newValueController.text.trim()
                          : selectedData[0][5],
                      selectedField!.toLowerCase() == 'subcategory'
                          ? newValueController.text.trim()
                          : selectedData[0][6],
                      selectedField!.toLowerCase() == 'vendorphone'
                          ? newValueController.text.trim()
                          : selectedData[0][7]) ==
                  true) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: primaryColor2,
                    content: Text("Operation succeeded. Please wait..")));
              } else {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: errorColor,
                    content: Text("Operation failed!")));
              }
            } on Exception catch (error) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: errorColor,
                  content: Text("No internet connection!")));
            }
          }
        }
        Navigator.of(context).pop();
        setState(() {
          productController.text = '';
          newValueController.text = '';
          selectedField = null;
          isSearchInventory = null;
          selectedData.clear();
        });
        getUserData1();
        getUserData1b();
        getUserData2();
      }
    }
  }

  downloadInventoryRecord() async {
    final downloadFilePathForInventory =
        "${Directory.current.path}/downloads/inventory.csv";
    late List liveData = [];
    late List liveData2 = [];

    final List inventoryHeader = [
      [
        'Product ID',
        'Product Name',
        'Cost Price',
        'MRP',
        'Lounge',
        'Category',
        'Sub Category',
        "Vendor's Contact"
      ]
    ];
    List<List<dynamic>> inventoryRow = [];

    await db.fetchInventroy();
    int len2 = db.ProductsRecord.length + 1;
    for (var data in db.ProductsRecord) {
      liveData.add(data['productid']);
      liveData.add(data['productname']);
      liveData.add(data['costprice']);
      liveData.add(data['mrp']);
      liveData.add(data['lounge']);
      liveData.add(data['category']);
      liveData.add(data['subcategory']);
      liveData.add(data['vendorphone']);
    }
    late var x = 0;
    late var y = 8;
    for (var i = 1; i < len2; i += 1) {
      if (i == 1) {
        liveData2.add(liveData.sublist(x, y));
      } else if (i > 1) {
        x += 8;
        y += 8;
        liveData2.add(liveData.sublist(x, y));
      }
    }

    for (var data in inventoryHeader) {
      inventoryRow.add(data);
    }
    for (var data in liveData2) {
      inventoryRow.add(data);
    }
    String inventoryCsv = const ListToCsvConverter().convert(inventoryRow);
    try {
      File inventoryCsvFile = File(downloadFilePathForInventory);
      await inventoryCsvFile.writeAsString(inventoryCsv);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: primaryColor2,
          content: Text("Operation succeeded..")));
    } on FileSystemException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: errorColor,
          content: Text("Please close 'inventory.csv' first!")));
    }
  }

  @override
  void initState() {
    getUserData2();
    lounge = null;
    category = null;
    subCategory = null;
    selectedField = null;
    super.initState();
  }

  @override
  void dispose() {
    productController.dispose();
    passwordController.dispose();
    newValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: primaryColor2,
        overlayColor: navyBlueColor,
        spacing: size.height * 0.02,
        spaceBetweenChildren: size.height * 0.01,
        overlayOpacity: 0.4,
        children: [
          SpeedDialChild(
            backgroundColor: errorColor,
            foregroundColor: whiteColor,
            child: Icon(Icons.delete),
            label: 'Delete product',
            onTap: () async {
              await deleteRecord();
            },
          ),
          SpeedDialChild(
            backgroundColor: Colors.teal,
            foregroundColor: whiteColor,
            child: Icon(Icons.update),
            label: 'Update product',
            onTap: () async {
              final form = _formKey2.currentState!;
              if (selectedData.isNotEmpty) {
                if (selectedField != null && selectedField != '') {
                  if (form.validate()) {
                    await updateRecord();
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: errorColor,
                      content: Text("No field selected!")));
                  return;
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: errorColor,
                    content: Text("No product selected!")));
                return;
              }
            },
          ),
          SpeedDialChild(
            backgroundColor: Colors.amberAccent,
            foregroundColor: whiteColor,
            child: Icon(Icons.search_rounded),
            label: 'Search product',
            onTap: () async {
              final form = _formKey.currentState!;
              if (form.validate()) {
                setState(() {
                  selectedData.clear();
                  isSearchInventory = true;
                });
              }
            },
          ),
          SpeedDialChild(
            backgroundColor: primaryColor,
            foregroundColor: whiteColor,
            child: Icon(Icons.add),
            label: 'Add product',
            onTap: () async {
              await Navigator.push(
                  context, CustomPageRoute(widget: AddProduct()));
            },
          ),
          SpeedDialChild(
            backgroundColor: primaryColor2,
            foregroundColor: whiteColor,
            child: Icon(Icons.refresh_rounded),
            label: 'Refresh',
            onTap: () async {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Please wait..")));
              setState(() {
                selectedData.clear();
                productController.text = '';
                isSearchInventory = null;
              });
            },
          ),
        ],
      ),
      backgroundColor: customBackgroundColor,
      appBar: buildAppBar(context, "Inventory", blackColor, true),
      body: Column(
        children: [
          SizedBox(height: size.height * 0.02),
          buildSearchArea(context),
          SizedBox(height: size.height * 0.005),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info, size: size.width * 0.015),
              SizedBox(width: size.width * 0.002),
              Text('Download inventory record?',
                  style: TextStyle(
                      color: navyBlueColor, fontSize: size.width * 0.012)),
              SizedBox(width: size.width * 0.004),
              TextButton(
                child: Text(
                  'Download',
                  style: TextStyle(
                      color: primaryColor, fontSize: size.width * 0.012),
                ),
                onPressed: () async {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return Center(child: CircularProgressIndicator());
                      });
                  await downloadInventoryRecord();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          SizedBox(height: size.height * 0.005),
          buildTable(context),
        ],
      ),
    );
  }

  Widget buildSearchArea(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.23,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.22,
                child: Column(
                  children: [
                    Form(
                        key: _formKey,
                        child: RoundedInputFieldMain(
                            controller: productController,
                            width: size.width * 0.17,
                            horizontalGap: size.width * 0.01,
                            verticalGap: size.height * 0.001,
                            radius: size.width * 0.005,
                            mainText: '',
                            labelText: 'Search by product name',
                            icon: Icons.shopping_bag_rounded,
                            isEnabled: true,
                            onChanged: (value) {
                              value = productController.text.trim();
                            })),
                  ],
                ),
              ),
              SizedBox(width: size.width * 0.12),
              SizedBox(
                height: size.height * 0.22,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: transparentColor, width: 2),
                            color: whiteColor,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text('Select a field'),
                              value: selectedField,
                              iconSize: 30,
                              items: fields.map(buildFields).toList(),
                              onChanged: (value) async => setState(() {
                                selectedField = value;
                              }),
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.01),
                        Form(
                          key: _formKey2,
                          child: RoundedInputFieldMain(
                              controller: newValueController,
                              width: size.width * 0.15,
                              horizontalGap: size.width * 0.01,
                              verticalGap: size.height * 0.001,
                              radius: size.width * 0.005,
                              mainText: '',
                              labelText: 'Enter a new parameter',
                              icon: Icons.edit_note_rounded,
                              isEnabled: true,
                              onChanged: (value) {
                                value = newValueController.text.trim();
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTable(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.53,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: FutureBuilder(
          future: isSearchInventory == null ? getUserData1() : getUserData1b(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: DataTable2(
                        columnSpacing: 5,
                        horizontalMargin: 5,
                        bottomMargin: 20,
                        showBottomBorder: true,
                        minWidth: size.width * 0.91,
                        dataRowColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) =>
                                states.contains(MaterialState.selected)
                                    ? primaryColor
                                    : customBackgroundColor),
                        showCheckboxColumn: false,
                        columns: <DataColumn>[
                          DataColumn(label: Text("Product ID")),
                          DataColumn(label: Text("Product Name")),
                          // DataColumn(label: Text("Qty in Stock")),
                          DataColumn(label: Text("Cost Price")),
                          DataColumn(label: Text("MRP")),
                          DataColumn(label: Text("Lounge")),
                          DataColumn(label: Text("Category")),
                          DataColumn(label: Text("Sub Category")),
                          DataColumn(label: Text("Vendor's Phone"))
                        ],
                        rows: isSearchInventory == false
                            ? <DataRow>[
                                for (var item in liveData2)
                                  DataRow(
                                      selected: selectedData.contains(item),
                                      onSelectChanged: (isSelected) {
                                        setState(() {
                                          final isAdding =
                                              isSelected != null && isSelected;
                                          isAdding
                                              ? selectedData.add(item)
                                              : selectedData.remove(item);
                                        });
                                      },
                                      cells: <DataCell>[
                                        for (var item2 in item.sublist(0))
                                          DataCell(Text(item2)),
                                      ])
                              ]
                            : <DataRow>[
                                for (var item in liveData2)
                                  if (item[1].startsWith(
                                      productController.text.trim()))
                                    DataRow(
                                        selected: selectedData.contains(item),
                                        onSelectChanged: (isSelected) {
                                          setState(() {
                                            final isAdding =
                                                isSelected != null &&
                                                    isSelected;
                                            isAdding
                                                ? selectedData.add(item)
                                                : selectedData.remove(item);
                                          });
                                        },
                                        cells: <DataCell>[
                                          for (var item2 in item.sublist(0))
                                            DataCell(Text(item2)),
                                        ]),
                              ]),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
