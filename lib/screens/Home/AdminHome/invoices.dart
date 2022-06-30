// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
import 'package:JoGenics/components/dialog.dart' as dialog;
import 'package:JoGenics/db.dart' as db;
import 'package:JoGenics/components/app_bar.dart';
import 'package:JoGenics/components/rounded_button.dart';
import 'package:JoGenics/components/rounded_input_field.dart';
import 'package:JoGenics/constants.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Invoices extends StatefulWidget {
  const Invoices({Key? key}) : super(key: key);

  @override
  State<Invoices> createState() => _InvoicesState();
}

class _InvoicesState extends State<Invoices> {
  final _formKey = GlobalKey<FormState>();
  final invoiceNumberController = TextEditingController();

  late DateTime dateOfInvoice = DateTime.now();
  late String dateOfInvoice1 = '';
  late String dateOfInvoice2 = '';

  late List liveData = [];
  late List liveData2 = [];
  late List liveData3 = [];
  List selectedData = [];

  String convertDateTimeDisplay1(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    dateOfInvoice1 = formatted;
    return dateOfInvoice1;
  }

  String convertDateTimeDisplay1b(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    dateOfInvoice2 = formatted;
    return dateOfInvoice2;
  }

  changeIsSearchInvoiceToByDate() {
    setState(() {
      isSearchCustomers = 'searchByNumber';
    });
  }

  changeIsSearchInvoiceTofalse() {
    setState(() {
      isSearchInvoice = 'false';
    });
  }

  getUserData1() async {
    changeIsSearchInvoiceTofalse();
    return db.InvoicesRecord;
  }

  getUserData1b() async {
    changeIsSearchInvoiceToByDate();
    return db.InvoicesRecord;
  }

  getUserData1c() async {
    return db.InvoicesRecord;
  }

  getUserData2() async {
    await db.fetchInvoicesRecord();
    liveData = [];
    liveData2 = [];
    int len = db.InvoicesRecord.length + 1;
    for (var data in db.InvoicesRecord) {
      liveData.add(data['invoicenumber']);
      liveData.add(data['date']);
      liveData.add(data['bartender']);
      liveData.add(data['waiter']);
      liveData.add(data['modeofpayment']);
      liveData.add(data['posreforconfirmation']);
      liveData.add(data['totalcost']);
      // liveData.add(data['cartalog']);
    }
    late var x = 0;
    late var y = 7;
    for (var i = 1; i < len; i += 1) {
      if (i == 1) {
        liveData2.add(liveData.sublist(x, y));
      } else if (i > 1) {
        x += 7;
        y += 7;
        liveData2.add(liveData.sublist(x, y));
      }
    }
    print('Invoice data = $liveData2');
    return liveData2;
  }

  viewOrders(invoicenumber) {
    liveData3 = [];
    for (var data in db.InvoicesRecord) {
      if (invoicenumber == data["invoicenumber"]) {
        for (var data2 in data["cartalog"]) {
          liveData3.add(data2);
        }
      }
    }
    return liveData3;
  }

  @override
  void initState() {
    getUserData1();
    getUserData2();
    convertDateTimeDisplay1(dateOfInvoice.toString());
    convertDateTimeDisplay1b(dateOfInvoice.toString());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: customBackgroundColor,
      appBar: buildAppBar(context, "Invoice", blackColor, true),
      body: Column(
        children: [
          SizedBox(height: size.height * 0.02),
          buildSearchArea(context),
          SizedBox(height: size.height * 0.01),
          buildTable(context),
          SizedBox(height: size.height * 0.015),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(Icons.info, size: size.width * 0.015),
                  SizedBox(width: size.width * 0.004),
                  Text(
                      "Select any invoice and click on 'View orders' to view orders for that invoice.",
                      style: TextStyle(
                          color: navyBlueColor, fontSize: size.width * 0.013)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildSearchArea(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.22,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: RoundedInputFieldMain(
                      controller: invoiceNumberController,
                      width: size.width * 0.17,
                      horizontalGap: size.width * 0.01,
                      verticalGap: size.height * 0.001,
                      radius: size.width * 0.005,
                      mainText: '',
                      labelText: 'Search by invoice number',
                      icon: Icons.shopping_bag_rounded,
                      isEnabled: true,
                      onChanged: (value) {
                        value = invoiceNumberController.text.trim();
                      })),
              SizedBox(width: size.width * 0.05),
              Container(
                width: size.width * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * 0.005),
                  border: Border.all(color: transparentColor, width: 2),
                  color: whiteColor,
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.edit_location_rounded,
                          color: primaryColor),
                      title: Text(
                          dateOfInvoice1 == dateOfInvoice2
                              ? 'Search by date ($dateOfInvoice2)'
                              : dateOfInvoice1,
                          style: TextStyle(color: Colors.black54)),
                      trailing: IconButton(
                        icon: Icon(Icons.calendar_month_rounded,
                            color: primaryColor),
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: dateOfInvoice,
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(2100))
                              .then((date) => setState(() {
                                    dateOfInvoice = date!;
                                    convertDateTimeDisplay1(
                                        dateOfInvoice.toString());
                                    isSearchInvoice = 'true';
                                  }));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.015),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedButtonMain(
                  text1: 'Search',
                  text2: 'Searching...',
                  fontSize1: size.width * 0.01,
                  fontSize2: size.width * 0.008,
                  width: size.width * 0.1,
                  horizontalGap: size.width * 0.01,
                  verticalGap: size.height * 0.02,
                  radius: size.width * 0.02,
                  isLoading: false,
                  function: () {
                    final form = _formKey.currentState!;
                    if (form.validate()) {
                      setState(() {
                        invoiceNumberController.text = '';
                        isSearchInvoice = 'searchByNumber';
                      });
                    }
                  }),
              SizedBox(width: size.width * 0.1),
              RoundedButtonRefresh(
                  color: primaryColor,
                  size: size.width * 0.02,
                  onPressed: () {
                    setState(() {
                      isSearchInvoice = null;
                    });
                  }),
              SizedBox(width: size.width * 0.1),
              RoundedButtonMain(
                  text1: 'View Orders',
                  text2: 'Opening...',
                  fontSize1: size.width * 0.01,
                  fontSize2: size.width * 0.008,
                  width: size.width * 0.1,
                  horizontalGap: size.width * 0.01,
                  verticalGap: size.height * 0.02,
                  radius: size.width * 0.02,
                  isLoading: false,
                  function: () async {
                    if (selectedData.length == 1) {
                      await viewOrders(selectedData[0][0]);
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return dialog.ReturnDialog1(
                              title: SizedBox(
                                width: size.width * 0.7,
                                height: size.height * 0.5,
                                child: FutureBuilder(
                                  future: getUserData1c(),
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
                                                minWidth: size.width * 0.6,
                                                dataRowColor: MaterialStateColor
                                                    .resolveWith((Set<
                                                                MaterialState>
                                                            states) =>
                                                        states.contains(
                                                                MaterialState
                                                                    .selected)
                                                            ? primaryColor
                                                            : whiteColor),
                                                showCheckboxColumn: false,
                                                columns: <DataColumn>[
                                                  DataColumn(
                                                      label:
                                                          Text('Description')),
                                                  DataColumn(
                                                      label: Text('Quantity')),
                                                  DataColumn(
                                                      label: Text('Price')),
                                                ],
                                                rows: <DataRow>[
                                                  for (var item in liveData3)
                                                    DataRow(
                                                        selected: selectedData
                                                            .contains(item),
                                                        cells: <DataCell>[
                                                          for (var item2 in item
                                                              .sublist(0))
                                                            DataCell(
                                                                Text(item2)),
                                                        ]),
                                                ]),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ),
                              message: '',
                              color: navyBlueColor,
                              buttonText: 'Close',
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  selectedData.clear();
                                });
                              },
                            );
                          });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: errorColor,
                          content: Text("Invalid selection!")));
                    }
                  }),
              // RoundedButtonMain(
              //     text1: 'Delete',
              //     text2: 'Deleting...',
              //     fontSize1: size.width * 0.01,
              //     fontSize2: size.width * 0.008,
              //     width: size.width * 0.1,
              //     horizontalGap: size.width * 0.01,
              //     verticalGap: size.height * 0.02,
              //     radius: size.width * 0.02,
              //     isLoading: false,
              //     function: () async {
              //       await deleteRecord();
              //     }),
            ],
          ),
          SizedBox(width: size.width * 0.12),
        ],
      ),
    );
  }

  Widget buildTable(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.55,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: FutureBuilder(
          future: isSearchInvoice == null
              ? getUserData1()
              : isSearchCustomers == 'searchByDate'
                  ? getUserData1b()
                  : getUserData1c(),
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
                        minWidth: size.width * 0.94,
                        dataRowColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) =>
                                states.contains(MaterialState.selected)
                                    ? primaryColor
                                    : customBackgroundColor),
                        showCheckboxColumn: false,
                        columns: <DataColumn>[
                          DataColumn(label: Text('Invoice No')),
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Bartender')),
                          DataColumn(label: Text('Waiter/Waitress')),
                          DataColumn(label: Text('Mode of Payment')),
                          DataColumn(label: Text('POS Ref/Confirmation')),
                          DataColumn(label: Text('Total')),
                          // DataColumn(label: Text('Orders')),
                        ],
                        rows: isSearchInvoice == 'false'
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
                            : isSearchInvoice == 'searchByNumber'
                                ? <DataRow>[
                                    for (var item in liveData2)
                                      if (item[0] ==
                                          invoiceNumberController.text.trim())
                                        DataRow(
                                            selected:
                                                selectedData.contains(item),
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
                                  ]
                                : <DataRow>[
                                    for (var item in liveData2)
                                      if (item[1] == dateOfInvoice1)
                                        DataRow(
                                            selected:
                                                selectedData.contains(item),
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
