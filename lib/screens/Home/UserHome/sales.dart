// ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, use_build_context_synchronously, unused_catch_clause, library_prefixes
import 'package:JoGenics/components/title_case.dart';
import 'dart:io';
import 'dart:math';
import 'package:JoGenics/components/dialog.dart' as dialog;
import 'package:JoGenics/components/rounded_button.dart';
import 'package:JoGenics/components/rounded_input_field.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pdf/widgets.dart' as pdfWidget;
import 'package:pdf/pdf.dart';
import 'package:JoGenics/constants.dart';
import 'package:JoGenics/db.dart' as db;
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:esc_pos_printer/esc_pos_printer.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';

class Sales extends StatefulWidget {
  const Sales({Key? key}) : super(key: key);

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  final _formKeySearchProduct = GlobalKey<FormState>();
  final _formKeyPOSConfirmation = GlobalKey<FormState>();
  final productController = TextEditingController();
  final quantityController = TextEditingController();
  final posRefController = TextEditingController();
  final passwordController = TextEditingController();
  final lounges = {'', 'REGULAR', 'VIP'};
  late var waiters = {''};
  final modesOfPayment = {
    '',
    'CASH',
    'POS',
    'TRANSFER',
  };
  late int quantity = 0;
  late DateTime currentDate = DateTime.now();
  late String currentDate2 = '';
  late String currentTime = '';
  late int invoiceNumber = 0;
  late int tempInvoiceNumber;

  late List templiveData1 = [];
  late List templiveData1b = [];
  late List liveData = [];
  late List liveData2 = [];
  List selectedData = [];
  late List tempCartalog = [];
  late List cartalog = [];
  List selectedData2 = [];
  late List tempList = [];
  late List bookmarks = [];
  late int bookmarksIndex = 0;
  late int total = 0;
  late int bookmarksSize = 0;

  String dir = "${Directory.current.path}/downloads/invoices/";

  final random = Random();
  generateInvoiceNumber() async {
    var invoiceNo = random.nextInt(db.SubscriptionPackage == 'standard'
        ? 1000000
        : db.SubscriptionPackage == 'basic'
            ? 1000
            : 100);
    try {
      if (await db.checkForValidInvoiceNumber(invoiceNo.toString()) == false) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return dialog.ReturnDialog4(
                title: Text('Error'),
                message:
                    'Invalid invoice number! It is possible that your invoice database is full. If error persist after multiple refresh, you may have to purchase the standard package.',
                color: errorColor,
                button1Text: 'Cancel',
                onPressed1: () {
                  Navigator.of(context).pop();
                },
                button2Text: 'Refresh',
                onPressed2: () async {
                  Navigator.of(context).pop();
                  await generateInvoiceNumber();
                },
              );
            });
      } else {
        setState(() {
          invoiceNumber = invoiceNo;
        });
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     backgroundColor: primaryColor2,
        //     content: Text("Invoice number generated successfully..")));
      }
    } on Exception catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: errorColor,
          content:
              Text("No internet connection! Cannot generate invoice number.")));
    }
  }

  getWaiters() async {
    await db.fetchEmployees();
    waiters = {''};
    for (var data in db.Employees) {
      if (data['designation'] == 'waiter') {
        waiters.add(data['firstname']);
      }
    }
  }

  DropdownMenuItem<String> buildLounges(String Lounge) => DropdownMenuItem(
      value: Lounge,
      child: Text(
        Lounge,
      ));
  DropdownMenuItem<String> buildWaiters(String Waiter) => DropdownMenuItem(
      value: Waiter,
      child: Text(
        Waiter,
      ));

  DropdownMenuItem<String> buildModesOfPayment(String mode) => DropdownMenuItem(
      value: mode,
      child: Text(
        mode,
      ));

  changeIsSearchToFalse() {
    setState(() {
      isSearchInventory2 = false;
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

  getUserData1c() async {
    // await db.adminSignIn(db.HotelName, db.CurrentLoggedInUserEmail,
    //     db.CurrentLoggedInUserPassword);
    return db.ProductsRecord;
  }

  getUserData2(lounge) async {
    await db.fetchInventroy();
    liveData = [];
    liveData2 = [];
    templiveData1 = [];
    templiveData1b = [];
    int len = db.ProductsRecord.length + 1;
    for (var data in db.ProductsRecord) {
      if (lounge.toLowerCase() == data['lounge']) {
        liveData.add(data['productid']);
        liveData.add(data['productname']);
        liveData.add(data['costprice']);
        liveData.add(data['lounge']);
      }

      if (lounge.toLowerCase() == data['lounge']) {
        templiveData1.add(data['productid']);
        templiveData1.add(data['productname']);
        // templiveData1.add(data['quantity']);
        templiveData1.add(data['costprice']);
        templiveData1.add(data['mrp']);
        templiveData1.add(data['lounge']);
        templiveData1.add(data['category']);
        templiveData1.add(data['subcategory']);
        templiveData1.add(data['vendorphone']);
      }
    }
    late var x = 0;
    late var y = 4;
    for (var i = 1; i < len; i += 1) {
      if (i == 1) {
        liveData2.add(liveData.sublist(x, y));
      } else if (i > 1) {
        x += 4;
        y += 4;
        liveData2.add(liveData.sublist(x, y));
      }
    }
    late var a = 0;
    late var b = 8;
    for (var j = 1; j < len; j += 1) {
      if (j == 1) {
        templiveData1b.add(templiveData1.sublist(a, b));
      } else if (j > 1) {
        a += 8;
        b += 8;
        templiveData1b.add(templiveData1.sublist(a, b));
      }
    }
    print('Product data = $liveData2');
    print('Temporal Product data = $templiveData1b');
    return liveData2;
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateFormat serverFormater2 = DateFormat('HH:mm:ss');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    final String formatted2 = serverFormater2.format(displayDate);
    currentDate2 = formatted;
    currentTime = formatted2;
    return currentDate2;
  }

  saveInvoiceAsPdf(
      invoicenumber, date, time, waiter, total, modeofpayment) async {
    final downloadFilePath =
        "${Directory.current.path}/downloads/invoices/$invoicenumber.pdf";
    final pdf = pdfWidget.Document();

    pdf.addPage(
      pdfWidget.Page(
        build: (pdfWidget.Context context) => pdfWidget.Center(
          child: pdfWidget.Container(
            width: 460,
            child: pdfWidget.Column(children: [
              pdfWidget.Text(
                  "${db.HotelName.toUpperCase()}\n${db.HotelAddress.toTitleCase()}\n${db.HotelProvince.toTitleCase()}, ${db.HotelCountry.toTitleCase()}\nEmail: ${db.HotelEmailAddress}\nPhone: ${db.HotelPhone}",
                  style: pdfWidget.TextStyle(fontSize: 10)),
              pdfWidget.SizedBox(height: 10),
              pdfWidget.Row(
                  mainAxisAlignment: pdfWidget.MainAxisAlignment.spaceBetween,
                  children: [
                    pdfWidget.Text(
                        "Invoice Number: $invoicenumber\nDate: $date\nTime: $time",
                        style: pdfWidget.TextStyle(fontSize: 10)),
                    pdfWidget.Text(
                        "Waiter/Waitress: ${waiter.toUpperCase()}\nMode of Payment: $modeofpayment",
                        style: pdfWidget.TextStyle(fontSize: 10)),
                  ]),
              pdfWidget.Divider(),
              pdfWidget.SizedBox(height: 2),
              pdfWidget.Table.fromTextArray(
                headers: ['DESCRIPTION', 'QTY', 'PRICE'],
                data: [for (var i in cartalog) i],
                // data: [cartalog[0], cartalog[1], cartalog[2]],
                border: null,
                headerStyle:
                    pdfWidget.TextStyle(fontWeight: pdfWidget.FontWeight.bold),
                headerDecoration:
                    pdfWidget.BoxDecoration(color: PdfColors.grey300),
                cellHeight: 10,
                cellAlignments: {
                  0: pdfWidget.Alignment.centerLeft,
                  1: pdfWidget.Alignment.centerRight,
                  2: pdfWidget.Alignment.centerRight,
                  3: pdfWidget.Alignment.centerRight,
                  4: pdfWidget.Alignment.centerRight,
                  5: pdfWidget.Alignment.centerRight,
                },
              ),
              pdfWidget.Container(
                  alignment: pdfWidget.Alignment.centerRight,
                  child: pdfWidget.Column(
                      crossAxisAlignment: pdfWidget.CrossAxisAlignment.end,
                      children: [
                        pdfWidget.Divider(height: 1),
                        pdfWidget.SizedBox(height: 5),
                        pdfWidget.Text(
                            "Total(${db.HotelCurrency.toUpperCase()}): $total",
                            style: pdfWidget.TextStyle(
                                fontWeight: pdfWidget.FontWeight.bold)),
                        pdfWidget.SizedBox(height: 5),
                        pdfWidget.Divider(height: 1),
                      ]))
            ]),
          ),
        ),
      ),
    );

    // final file = File('example.pdf');
    File invoiceFile = File(downloadFilePath);
    await invoiceFile.writeAsBytes(await pdf.save());
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  saveBillAsPdf(invoicenumber, date, time, waiter, total) async {
    final downloadFilePath =
        "${Directory.current.path}/downloads/invoices/$invoicenumber.pdf";
    final pdf = pdfWidget.Document();

    pdf.addPage(
      pdfWidget.Page(
        build: (pdfWidget.Context context) => pdfWidget.Center(
          child: pdfWidget.Container(
            width: 460,
            child: pdfWidget.Column(children: [
              pdfWidget.Text(
                  "${db.HotelName.toUpperCase()}\n${db.HotelAddress.toTitleCase()}\n${db.HotelProvince.toTitleCase()}, ${db.HotelCountry.toTitleCase()}\nEmail: ${db.HotelEmailAddress}\nPhone: ${db.HotelPhone}",
                  style: pdfWidget.TextStyle(fontSize: 10)),
              pdfWidget.SizedBox(height: 10),
              pdfWidget.Row(
                  mainAxisAlignment: pdfWidget.MainAxisAlignment.spaceBetween,
                  children: [
                    pdfWidget.Text("Date: $date\nTime: $time",
                        style: pdfWidget.TextStyle(fontSize: 10)),
                    pdfWidget.Text(
                        "Bill Number: $invoicenumber\nWaiter/Waitress: ${waiter.toUpperCase()}",
                        style: pdfWidget.TextStyle(fontSize: 10)),
                  ]),
              pdfWidget.Divider(),
              pdfWidget.SizedBox(height: 2),
              pdfWidget.Table.fromTextArray(
                headers: ['DESCRIPTION', 'QTY', 'PRICE'],
                data: [for (var i in cartalog) i],
                // data: [cartalog[0], cartalog[1], cartalog[2]],
                border: null,
                headerStyle:
                    pdfWidget.TextStyle(fontWeight: pdfWidget.FontWeight.bold),
                headerDecoration:
                    pdfWidget.BoxDecoration(color: PdfColors.grey300),
                cellHeight: 10,
                cellAlignments: {
                  0: pdfWidget.Alignment.centerLeft,
                  1: pdfWidget.Alignment.centerRight,
                  2: pdfWidget.Alignment.centerRight,
                  3: pdfWidget.Alignment.centerRight,
                  4: pdfWidget.Alignment.centerRight,
                  5: pdfWidget.Alignment.centerRight,
                },
              ),
              pdfWidget.Container(
                  alignment: pdfWidget.Alignment.centerRight,
                  child: pdfWidget.Column(
                      crossAxisAlignment: pdfWidget.CrossAxisAlignment.end,
                      children: [
                        pdfWidget.Divider(height: 1),
                        pdfWidget.SizedBox(height: 5),
                        pdfWidget.Text(
                            "Total(${db.HotelCurrency.toUpperCase()}): $total",
                            style: pdfWidget.TextStyle(
                                fontWeight: pdfWidget.FontWeight.bold)),
                        pdfWidget.SizedBox(height: 5),
                        pdfWidget.Divider(height: 1),
                      ]))
            ]),
          ),
        ),
      ),
    );
    File invoiceFile = File(downloadFilePath);
    await invoiceFile.writeAsBytes(await pdf.save());
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  book(invoicenumber, waiter, total, modeofpayment, orders) {
    if (cartalog.isNotEmpty) {
      bookmarks.add({
        'invoicenumber': invoicenumber,
        'lounge': lounge!.toLowerCase(),
        'waiter': waiter,
        'modeofpayment': modeofpayment,
        'posref': posRefController.text,
        'total': total,
        'orders': orders,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: errorColor, content: Text("Cartalog is empty!")));
    }
  }

  clearCart() {
    setState(() {
      waiter = null;
      posRefOrConfirmation = null;
      posRefController.text = '';
      tempList = [];
      cartalog = [];
      selectedData.clear();
      selectedData2.clear();
      total = 0;
      bookmarksIndex = 0;
    });
  }

  @override
  void initState() {
    getUserData2('regular');
    getWaiters();
    lounge = 'REGULAR';
    waiter = null;
    posRefOrConfirmation = null;
    generateInvoiceNumber();
    super.initState();
    // setState(() {
    //   Process.run('$dir/images/installerX64/install.exe', [' start '])
    //       .then((ProcessResult results) {
    //     print("port poen");
    //   });
    // });
  }

  @override
  void dispose() {
    super.dispose();
    productController.dispose();
    quantityController.dispose();
    posRefController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: primaryColor2,
        overlayColor: navyBlueColor,
        spacing: size.height*0.02,
        spaceBetweenChildren: size.height*0.01,
        overlayOpacity: 0.4,
        children: [
          SpeedDialChild(
            backgroundColor: errorColor,
            foregroundColor: whiteColor,
            child: Icon(Icons.delete),
            label: 'Clear cart',
            onTap: () async {
              if (cartalog.isNotEmpty) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return dialog.ReturnDialog4(
                        title: Text('Confirm'),
                        message: 'Do you wish to clear cartalog?',
                        color: navyBlueColor,
                        button1Text: 'No',
                        onPressed1: () {
                          Navigator.of(context).pop();
                        },
                        button2Text: 'Yes',
                        onPressed2: () {
                          Navigator.of(context).pop();
                          clearCart();
                        },
                      );
                    });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: errorColor,
                    content: Text("Cartalog is empty!")));
              }
            },
          ),
          SpeedDialChild(
            backgroundColor: Colors.redAccent,
            foregroundColor: whiteColor,
            child: Icon(Icons.remove),
            label: 'Remove item',
            onTap: () async {
              if (selectedData2.isNotEmpty) {
                if (selectedData2.length == 1) {
                  print(selectedData2);
                  print(tempList);
                  setState(() {
                    cartalog.removeWhere(
                        (element) => element[0] == selectedData2[0][0]);
                    tempList.remove(selectedData2[0][0].toLowerCase());
                    selectedData2.removeAt(0);
                  });
                  num totalPrice = 0;
                  if (cartalog.isNotEmpty) {
                    for (var data in cartalog) {
                      totalPrice += int.parse(data[2]);
                      setState(() {
                        total = totalPrice as int;
                      });
                    }
                  } else {
                    setState(() {
                      total = 0;
                    });
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: errorColor,
                      content: Text("Invalid selection!")));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: errorColor,
                    content: Text("No item in cartalog selected!")));
              }
            },
          ),
          SpeedDialChild(
            backgroundColor: Colors.amberAccent,
            foregroundColor: whiteColor,
            child: Icon(Icons.search_rounded),
            label: 'Search product',
            onTap: () async {
              final form = _formKeySearchProduct.currentState!;
              if (form.validate()) {
                setState(() {
                  selectedData.clear();
                  isSearchInventory2 = true;
                });
              }
            },
          ),
          SpeedDialChild(
            backgroundColor: primaryColor2,
            foregroundColor: whiteColor,
            child: Icon(Icons.refresh_rounded),
            label: 'Refresh',
            onTap: () async {
              generateInvoiceNumber();
              setState(() {
                selectedData.clear();
                productController.text = '';
                isSearchInventory2 = null;
              });
            },
          ),
        ],
      ),
      backgroundColor: customBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          color: primaryColor,
          onPressed: () {
            bookmarks.isEmpty
                ? showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return dialog.ReturnDialog4(
                        title: Text('Confirm Logout'),
                        message: 'Do you wish to logout?',
                        color: navyBlueColor,
                        button1Text: 'Cancel',
                        onPressed1: () {
                          Navigator.of(context).pop(context);
                        },
                        button2Text: 'Yes',
                        onPressed2: () {
                          Navigator.of(context).pop(context);
                          Navigator.of(context).pop(context);
                        },
                      );
                    })
                : showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return dialog.ReturnDialog1(
                        title: Text('Logout Error'),
                        message:
                            'Unable to logout!\nYou still have $bookmarksSize bookmark(s) left.',
                        color: errorColor,
                        buttonText: 'Ok',
                        onPressed: () {
                          Navigator.of(context).pop(context);
                        },
                      );
                    });
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Sales',
          style: TextStyle(
            fontSize: size.width * 0.012,
            fontWeight: FontWeight.w800,
            color: blackColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.01),
            buildSearchArea(context),
            SizedBox(height: size.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text('Inventory',
                        style: TextStyle(
                            fontFamily: 'Biko',
                            fontSize: size.width * 0.012,
                            fontWeight: FontWeight.bold,
                            color: navyBlueColor)),
                    buildInventory(context),
                  ],
                ),
                SizedBox(width: size.width * 0.05),
                Column(
                  children: [
                    Text('Cartalog',
                        style: TextStyle(
                            fontFamily: 'Biko',
                            fontSize: size.width * 0.012,
                            fontWeight: FontWeight.bold,
                            color: navyBlueColor)),
                    buildCartalog(context),
                  ],
                )
              ],
            ),
            SizedBox(height: size.height * 0.02)
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: customBackgroundColor,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundedButtonGeneral(
                    text1: 'Add to Cart',
                    text2: 'Adding..',
                    color: primaryColor2,
                    isLoading: false,
                    update: () async {
                      if (selectedData.isNotEmpty) {
                        if (selectedData.length == 1) {
                          if (quantity != 0) {
                            for (var data in selectedData) {
                              // int qty = int.parse(data[1]) - quantity;
                              // if (qty > 0) {
                              if (!tempList.contains(data[1])) {
                                setState(() {
                                  cartalog.add([
                                    data[1].toUpperCase(),
                                    quantity.toString(),
                                    (int.parse(data[2]) * quantity).toString()
                                  ]);
                                  tempCartalog.add([
                                    data[1].toUpperCase(),
                                    quantity.toString(),
                                    (int.parse(data[2]) * quantity).toString()
                                  ]);
                                  tempList.add(
                                    data[1],
                                  );
                                  quantity = 0;
                                  selectedData.clear();
                                });
                                num totalPrice = 0;
                                for (var data in cartalog) {
                                  totalPrice += int.parse(data[2]);
                                  setState(() {
                                    total = totalPrice as int;
                                  });
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    backgroundColor: errorColor,
                                    content: Text(
                                        "${data[1]} is already in cartalog!")));
                              }
                              // } else {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //       SnackBar(
                              //           backgroundColor: errorColor,
                              //           content: Text(
                              //               "${data[0]} is out of stock!")));
                              // }
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: errorColor,
                                content: Text("Quantity must not be nil!")));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: errorColor,
                              content: Text(
                                  "Invalid selection! Only one product allowed at a time.")));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: errorColor,
                            content:
                                Text("No product in inventory selected!")));
                      }
                    }),
                RoundedButtonGeneral2(
                    text1: 'Book',
                    text2: '$bookmarksSize',
                    color: primaryColor2,
                    isLoading: false,
                    update: () async {
                      if (lounge != null && lounge != '') {
                        if (waiter != null && waiter != '') {
                          if (posRefOrConfirmation != null &&
                              posRefOrConfirmation != '') {
                            await book(
                                invoiceNumber,
                                waiter!.toLowerCase(),
                                total.toString(),
                                posRefOrConfirmation!.toLowerCase(),
                                cartalog.toList());
                            await saveBillAsPdf(
                              invoiceNumber.toString(),
                              currentDate2,
                              currentTime,
                              waiter!,
                              total,
                            );
                            setState(() {
                              waiter = null;
                              posRefOrConfirmation = null;
                              posRefController.text = '';
                              tempList.clear();
                              cartalog.clear();
                              selectedData2.clear();
                              total = 0;
                              bookmarksSize = bookmarks.length;
                            });
                            generateInvoiceNumber();
                            for (var data in bookmarks) {
                              if (data['orders'].length == 0) {
                                setState(() {
                                  bookmarks.remove(data);
                                  bookmarksSize = bookmarks.length;
                                });
                              }
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: errorColor,
                                content:
                                    Text("Mode of payment not selected!")));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: errorColor,
                              content: Text("No waiter selected!")));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: errorColor,
                            content: Text("No lounge selected!")));
                      }
                    }),
                IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_rounded,
                        color: primaryColor2, size: size.width * 0.015),
                    onPressed: () {
                      print('Prev');
                      print(bookmarks);
                      print(bookmarksIndex);
                      if (bookmarksIndex < bookmarks.length + 1) {
                        print(bookmarks);
                        bookmarksIndex >= 0
                            ? setState(() {
                                tempList.clear();
                                bookmarksIndex--;
                                invoiceNumber =
                                    bookmarks[bookmarksIndex]['invoicenumber'];
                                lounge = bookmarks[bookmarksIndex]['lounge']
                                    .toUpperCase();
                                waiter = bookmarks[bookmarksIndex]['waiter'];
                                posRefOrConfirmation = bookmarks[bookmarksIndex]
                                        ['modeofpayment']
                                    .toUpperCase();
                                posRefController.text =
                                    bookmarks[bookmarksIndex]['posref'];
                                total = int.parse(
                                    bookmarks[bookmarksIndex]['total']);
                                cartalog = bookmarks[bookmarksIndex]['orders'];
                                for (var data in bookmarks[bookmarksIndex]
                                    ['orders']) {
                                  tempList.add(data[0].toLowerCase());
                                }
                              })
                            : null;
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: errorColor,
                            content: Text("The end!")));
                      }
                    }),
                IconButton(
                    icon: Icon(Icons.arrow_forward_ios_rounded,
                        color: primaryColor2, size: size.width * 0.015),
                    onPressed: () {
                      print('Next');
                      print(bookmarks);
                      print(bookmarksIndex);
                      if (bookmarksIndex < bookmarks.length - 1) {
                        print(bookmarks);
                        setState(() {
                          tempList.clear();
                          bookmarksIndex++;
                          invoiceNumber =
                              bookmarks[bookmarksIndex]['invoicenumber'];
                          lounge =
                              bookmarks[bookmarksIndex]['lounge'].toUpperCase();
                          waiter = bookmarks[bookmarksIndex]['waiter'];
                          posRefOrConfirmation = bookmarks[bookmarksIndex]
                                  ['modeofpayment']
                              .toUpperCase();
                          posRefController.text =
                              bookmarks[bookmarksIndex]['posref'];
                          total = int.parse(bookmarks[bookmarksIndex]['total']);
                          cartalog = bookmarks[bookmarksIndex]['orders'];
                          for (var data in bookmarks[bookmarksIndex]
                              ['orders']) {
                            tempList.add(data[0].toLowerCase());
                          }
                        });
                      }
                    }),
                Text("Total(${db.HotelCurrency.toUpperCase()}): $total",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.015)),
                RoundedButtonGeneral(
                    text1: 'Confirm',
                    text2: 'Processing..',
                    color: primaryColor2,
                    isLoading: false,
                    update: () async {
                      final form = _formKeyPOSConfirmation.currentState!;
                      if (lounge != null && lounge != '') {
                        if (waiter != null && waiter != '') {
                          if (posRefOrConfirmation != null &&
                              posRefOrConfirmation != '') {
                            if (form.validate()) {
                              if (cartalog.isNotEmpty) {
                                try {
                                  convertDateTimeDisplay(
                                      DateTime.now().toString());
                                  if (await db.sellProducts(
                                          invoiceNumber,
                                          currentDate2,
                                          db.CurrentLoggedInUserEmail,
                                          waiter!,
                                          posRefOrConfirmation!,
                                          posRefController.text.trim(),
                                          total.toString(),
                                          cartalog) ==
                                      true) {
                                    await saveInvoiceAsPdf(
                                        invoiceNumber.toString(),
                                        currentDate2,
                                        currentTime,
                                        waiter!,
                                        total,
                                        posRefOrConfirmation!.toTitleCase());
                                    setState(() {
                                      tempInvoiceNumber = invoiceNumber;
                                      bookmarks.isEmpty
                                          ? cartalog.clear()
                                          : null;
                                      tempList.clear();
                                      selectedData.clear();
                                      selectedData2.clear();
                                      total = 0;
                                      waiter = null;
                                      posRefOrConfirmation = null;
                                      posRefController.text = '';
                                      productController.text = '';
                                      isSearchInventory2 = true;
                                      bookmarksSize = bookmarks.length;
                                    });
                                    generateInvoiceNumber();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: primaryColor2,
                                            content:
                                                Text("Operation succeeded..")));
                                    print(tempInvoiceNumber);
                                    for (var data in bookmarks) {
                                      if (data['invoicenumber'] ==
                                          tempInvoiceNumber) {
                                        print('found');
                                        setState(() {
                                          bookmarks.remove(data);
                                          bookmarksSize = bookmarks.length;
                                          cartalog = [];
                                        });
                                      }
                                    }
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: errorColor,
                                        content: Text("Cartalog is empty!")));
                              }
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: errorColor,
                                content: Text("Select a mode of payment!")));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: errorColor,
                              content: Text("Select a waiter!")));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: errorColor,
                            content: Text("Select a lounge!")));
                      }
                    }),
              ],
            )),
      ),
    );
  }

  Widget buildSearchArea(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.36,
      child: Column(
        children: [
          SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * 0.005),
                  border: Border.all(color: transparentColor, width: 2),
                  color: whiteColor,
                ),
                child: ListTile(
                  leading:
                      Icon(Icons.vertical_shades_sharp, color: primaryColor),
                  title: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text('Select lounge'),
                      isExpanded: true,
                      value: lounge,
                      iconSize: 30,
                      items: lounges.map(buildLounges).toList(),
                      onChanged: (value) async => setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please wait..")));
                        lounge = value;
                        setState(() {
                          getUserData2(lounge!.toLowerCase());
                          cartalog.clear();
                          clearCart();
                        });
                      }),
                    ),
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.02),
              Container(
                width: size.width * 0.22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * 0.005),
                  border: Border.all(color: transparentColor, width: 2),
                  color: whiteColor,
                ),
                child: ListTile(
                  leading: Icon(Icons.person, color: primaryColor),
                  title: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text('Select waiter'),
                      isExpanded: true,
                      value: waiter,
                      iconSize: 30,
                      items: waiters.map(buildWaiters).toList(),
                      onChanged: (value) async => setState(() {
                        waiter = value;
                      }),
                    ),
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.02),
              Container(
                width: size.width * 0.22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * 0.005),
                  border: Border.all(color: transparentColor, width: 2),
                  color: whiteColor,
                ),
                child: ListTile(
                  leading: Icon(Icons.payments_rounded, color: primaryColor),
                  title: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text('Mode of payment'),
                      isExpanded: true,
                      value: posRefOrConfirmation,
                      iconSize: 30,
                      items: modesOfPayment.map(buildModesOfPayment).toList(),
                      onChanged: (value) async => setState(() {
                        posRefOrConfirmation = value;
                        // posRefOrConfirmation == 'CASH'
                        //     ? posRefController.text = 'NIL'
                        //     : posRefOrConfirmation == 'POS'
                        //         ? posRefController.text = 'Awaiting..'
                        //         : posRefController.text = 'Yet to be confirmed';
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Form(
                  key: _formKeySearchProduct,
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
              Form(
                key: _formKeyPOSConfirmation,
                child: RoundedInputFieldMain2c(
                    controller: posRefController,
                    width: size.width * 0.3,
                    horizontalGap: size.width * 0.01,
                    verticalGap: size.height * 0.001,
                    radius: size.width * 0.005,
                    mainText: '',
                    labelText: 'POS reference number/Transfer confirmation',
                    warningText1: 'Enter a valid POS reference number',
                    warningText2:
                        "required! (e.g: 'Comfirmed by ${db.CurrentLoggedInUserEmail})",
                    currentUser: db.CurrentLoggedInUserEmail,
                    validator: posRefOrConfirmation,
                    // isEnabled: true,
                    icon: Icons.numbers,
                    onChanged: (value) {
                      value = posRefController.text.trim();
                    }),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Quantity:',
                style: TextStyle(
                    fontSize: size.width * 0.015, color: navyBlueColor),
              ),
              SizedBox(width: size.width * 0.02),
              IconButton(
                  onPressed: () {
                    setState(() {
                      quantity > 0 ? quantity-- : null;
                    });
                  },
                  icon: Icon(Icons.remove, size: size.width * 0.015)),
              SizedBox(width: size.width * 0.01),
              Text(
                quantity.toString(),
                style: TextStyle(
                    fontSize: size.width * 0.015, color: primaryColor),
              ),
              SizedBox(width: size.width * 0.01),
              IconButton(
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  icon: Icon(Icons.add, size: size.width * 0.015)),
              SizedBox(width: size.width * 0.45),
              // RoundedButtonMain(
              //     text1: 'Update Inventory',
              //     text2: 'Updating...',
              //     fontSize1: size.width * 0.01,
              //     fontSize2: size.width * 0.008,
              //     width: size.width * 0.13,
              //     horizontalGap: size.width * 0.01,
              //     verticalGap: size.height * 0.02,
              //     radius: size.width * 0.02,
              //     isLoading: false,
              //     function: () async {
              //       if (tempCartalog.isNotEmpty) {
              //         passwordController.text = '';
              //         showDialog(
              //             barrierDismissible: false,
              //             context: context,
              //             builder: (context) {
              //               return Center(
              //                   child: dialog.ReturnDialog4(
              //                       title: RoundedPasswordFieldA2(
              //                           controller: passwordController),
              //                       message: '',
              //                       color: primaryColor,
              //                       button1Text: 'Cancel',
              //                       onPressed1: () {
              //                         Navigator.of(context).pop();
              //                       },
              //                       button2Text: 'Confirm',
              //                       onPressed2: () async {
              //                         if (passwordController.text
              //                                 .trim()
              //                                 .toLowerCase() ==
              //                             db.CurrentLoggedInUserPassword) {
              //                           print('can update inventory now');
              //                           showDialog(
              //                               barrierDismissible: false,
              //                               context: context,
              //                               builder: (context) {
              //                                 return Center(
              //                                     child:
              //                                         CircularProgressIndicator());
              //                               });
              //                           // Work on this function, as it is not optimal for a large cartalog with different quantities of products bought.
              //                           for (var data in tempCartalog) {
              //                             for (var data2 in templiveData1b) {
              //                               if (data2.contains(
              //                                   data[0].toLowerCase())) {
              //                                 num newQtyInStock =
              //                                     int.parse(data2[2]) -
              //                                         int.parse(data[1]);
              //                                 await db.updateProduct(
              //                                     data2[0],
              //                                     data2[1],
              //                                     newQtyInStock.toString(),
              //                                     data2[3],
              //                                     data2[4],
              //                                     data2[5],
              //                                     data2[6],
              //                                     data2[7],
              //                                     data2[8]);
              //                               }
              //                             }
              //                           }
              //                           Navigator.of(context).pop();
              //                           Navigator.of(context).pop();
              //                           setState(() {
              //                             tempCartalog.clear();
              //                           });
              //                           await getUserData2('regular');
              //                         } else {
              //                           Navigator.of(context).pop();
              //                           ScaffoldMessenger.of(context)
              //                               .showSnackBar(SnackBar(
              //                                   backgroundColor: errorColor,
              //                                   content:
              //                                       Text("Invalid password!")));
              //                         }
              //                       }));
              //             });
              //       } else {
              //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //             backgroundColor: errorColor,
              //             content: Text("Cartalog is empty!")));
              //       }
              //     }),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildInventory(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.5,
      width: size.width * 0.35,
      child: FutureBuilder(
        future: isSearchInventory2 == null ? getUserData1() : getUserData1b(),
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
                      minWidth: size.width * 0.2,
                      dataRowColor: MaterialStateColor.resolveWith(
                          (Set<MaterialState> states) =>
                              states.contains(MaterialState.selected)
                                  ? primaryColor
                                  : customBackgroundColor),
                      showCheckboxColumn: false,
                      columns: <DataColumn>[
                        // DataColumn(label: Text("Product ID")),
                        DataColumn(label: Text("Product ID")),
                        DataColumn(label: Text("Product Name")),
                        DataColumn(label: Text("Price")),
                        DataColumn(label: Text("Lounge")),
                      ],
                      rows: isSearchInventory2 == false
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
                                if (item[1]
                                    .startsWith(productController.text.trim()))
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
                                      ]),
                            ]),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget buildCartalog(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.5,
      width: size.width * 0.35,
      child: FutureBuilder(
        future: isCartalog == null ? getUserData1c() : null,
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
                      minWidth: size.width * 0.2,
                      dataRowColor: MaterialStateColor.resolveWith(
                          (Set<MaterialState> states) =>
                              states.contains(MaterialState.selected)
                                  ? primaryColor
                                  : customBackgroundColor),
                      showCheckboxColumn: false,
                      columns: <DataColumn>[
                        DataColumn(label: Text("Item")),
                        DataColumn(label: Text("Qty")),
                        DataColumn(label: Text("Price")),
                      ],
                      rows: isCartalog == false
                          ? <DataRow>[
                              for (var item in cartalog)
                                DataRow(
                                    selected: selectedData2.contains(item),
                                    onSelectChanged: (isSelected) {
                                      setState(() {
                                        final isAdding =
                                            isSelected != null && isSelected;
                                        if (isAdding == true) {
                                          selectedData2.add(item);
                                        } else {
                                          selectedData2.remove(item);
                                          quantity = 0;
                                        }
                                      });
                                    },
                                    cells: <DataCell>[
                                      for (var item2 in item.sublist(0))
                                        DataCell(Text(item2)),
                                    ])
                            ]
                          : <DataRow>[
                              for (var item in cartalog)
                                if (item[1]
                                    .startsWith(productController.text.trim()))
                                  DataRow(
                                      selected: selectedData2.contains(item),
                                      onSelectChanged: (isSelected) {
                                        setState(() {
                                          final isAdding =
                                              isSelected != null && isSelected;
                                          isAdding
                                              ? selectedData2.add(item)
                                              : selectedData2.remove(item);
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
    );
  }
}
