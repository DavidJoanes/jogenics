// ignore_for_file: unnecessary_late, non_constant_identifier_names, prefer_const_declarations, avoid_print, unused_local_variable, unused_catch_clause

// import 'dart:convert';
import 'package:JoGenics/constants.dart' as constants;
import 'package:mongo_dart/mongo_dart.dart' show Db;
// import 'package:http/http.dart' as http;

//// NodeJS
final db_url =
    "mongodb+srv://kemd:iF46zht08UvgWhex@cluster0.t5pgh.mongodb.net/hotels_database?retryWrites=true&w=majority";
final db_collection_main = "main";
final db_collection_administrators = "${HotelCollectionName}_administrators";
final db_collection_employees = "${HotelCollectionName}_employees";
final db_collection_customers = "${HotelCollectionName}_customers";
final db_collection_inventory = "${HotelCollectionName}_inventory";
final db_collection_invoices = "${HotelCollectionName}_invoices";
final db_collection_timestamp_checkin_checkout =
    "${HotelCollectionName}_timestamp_checkin_checkout";
final db_collection_timestamp_update =
    "${HotelCollectionName}_timestamp_update";

// JoGenics HMS App and Bank Details
late bool registeredJoGenics = false;
late String AccountName = "David Joanes Kemdirim";
late String AccountNumber = "0164970385";
late String Bank = "Guaranty Trust Bank";
late double LatestAppVersion = 0.0;
late String LatestAppVersionDescription = '';

// SignUp, SignIn and Subscription section
late String CompanyEmailAddress = 'jogenics@gmail.com';
late var HotelsMain = [];
late var Hotels = {''};
late int BasicPackagePrice = 12000;
late int StandardPackagePrice = 20000;

// AdminHome and UserHome section
late String CurrentLoggedInUserProfilePicture = '';
late String CurrentLoggedInUserFirstname = '';
late String CurrentLoggedInUserLastname = '';
late String CurrentLoggedInUserGender = '';
late String CurrentLoggedInUserEmail = '';
late String CurrentLoggedInUserNationality = '';
late String CurrentLoggedInUserStateOfOrigin = '';
late String CurrentLoggedInUserPhone = '';
late String CurrentLoggedInUserHomeAddress = '';
late String CurrentLoggedInUserDateOfEmployment = '';
late String CurrentLoggedInUserDesignation = 'bartender';
late int CurrentLoggedInUserAuthorizationCode = 0;
late String CurrentLoggedInUserAuthorizationCodeHashed = 'xxxxxxxxxx';
late String CurrentLoggedInUserSecurityQuestion = '';
late String CurrentLoggedInUserSecurityQuestionHashed = 'xxxxxxxxxx';
late String CurrentLoggedInUserSecurityAnswer = '';
late String CurrentLoggedInUserSecurityAnswerHashed = 'xxxxxxxxxx';
late String CurrentLoggedInUserPassword = '';
late String CurrentLoggedInUserPasswordHashed = 'xxxxxxxxxx';

// Hotel details
late String HotelCollectionName = '';
late String HotelName = '';
late String HotelEmailAddress = '';
late String HotelPhone = '';
late String HotelAddress = '';
late String HotelProvince = '';
late String HotelCountry = '';
late String HotelCurrency = '';
late String HotelPrinterIP = '';
late int StandardRoomRate = 0;
late int ExecutiveRoomRate = 0;
late int PresidentialRoomRate = 0;
late int CustomerDatabaseSize = 100;
late bool SubscriptionCheck = true;
late String SubscriptionPackage = '';
late String SubscriptionDate = '';
late String SubscriptionExpiryDate = '';
late String SubscriptionType = '';
late int AuthorizationCodeForOwner = 0;
late int AuthorizationCodeForManager = 0;

// Administrators section
late var Administrators = [];
late var Employees = [];
late var CustomersRecord = [];
late var ProductsRecord = [];
late var InvoicesRecord = [];
late var CustomerRecordForUpdate = [];
late var EmployeetimeStampCheckin_out = [];
late var EmployeetimeStampUpdate = [];

late List MonthlyBestSellers = [];

start() async {
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_main);

  final check = await dbClient.find().toList();
  print(check);

  try {
    for (var hotelData in check) {
      Hotels.add(hotelData['hotelname'].toUpperCase());
      HotelsMain.add(hotelData);
    }
  } on Exception catch (error) {
    return 'No internet';
  }

  // db.close();
}

fetchHotelDetails() {
  for (var hotelData in HotelsMain) {
    if (hotelData['hotelname'] == constants.hotel!.toLowerCase()) {
      registeredJoGenics = hotelData['registered'];
      AccountName = hotelData['accountname'];
      AccountNumber = hotelData['accountnumber'];
      Bank = hotelData['bank'];
      AuthorizationCodeForOwner = hotelData['authorizationowner'];
      AuthorizationCodeForManager = hotelData['authorizationmanager'];
      HotelName = hotelData['hotelname'];
      HotelCollectionName = hotelData['hotelcollectionname'];
      HotelEmailAddress = hotelData['hotelemail'];
      HotelPhone = hotelData['hotelphone'];
      HotelAddress = hotelData['hoteladdress'];
      HotelProvince = hotelData['hotelprovince'];
      HotelCountry = hotelData['hotelcountry'];
      HotelCurrency = hotelData['hotelcurrency'];
      StandardRoomRate = hotelData['standardroomrate'];
      ExecutiveRoomRate = hotelData['executiveroomrate'];
      PresidentialRoomRate = hotelData['presidentialroomrate'];
      BasicPackagePrice = hotelData['basicpackageprice'];
      StandardPackagePrice = hotelData['standardpackageprice'];
      SubscriptionCheck = hotelData['subscriptioncheck'];
      SubscriptionPackage = hotelData['subscriptionpackage'];
      SubscriptionDate = hotelData['subscriptiondate'];
      SubscriptionExpiryDate = hotelData['subscriptionexpirydate'];
      SubscriptionType = hotelData['subscriptiontype'];
      LatestAppVersion = hotelData['appversion'];
    }
  }
}

configureSubscription(
    subscriptionPackage, subscriptionDate, subscriptionExpiryDate) async {
  subscriptionPackage = subscriptionPackage.toLowerCase();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_main);
  final check = await dbClient.find({'hotelname': HotelName}).toList();

  try {
    if (check.isNotEmpty) {
      print('found');
      final insert = await dbClient.update({
        'hotelname': HotelName
      }, {
        'registered': registeredJoGenics,
        'accountname': AccountName,
        'accountnumber': AccountNumber,
        'bank': Bank,
        'authorizationowner': AuthorizationCodeForOwner,
        'authorizationmanager': AuthorizationCodeForManager,
        'hotelname': HotelName,
        'hotelcollectionname': HotelCollectionName,
        'hotelemail': HotelEmailAddress,
        'hotelphone': HotelPhone,
        'hoteladdress': HotelAddress,
        'hotelprovince': HotelProvince,
        'hotelcountry': HotelCountry,
        'hotelcurrency': HotelCurrency,
        'standardroomrate': StandardRoomRate,
        'executiveroomrate': ExecutiveRoomRate,
        'presidentialroomrate': PresidentialRoomRate,
        'basicpackageprice': BasicPackagePrice,
        'standardpackageprice': StandardPackagePrice,
        'subscriptioncheck': true,
        'subscriptionpackage': subscriptionPackage,
        'subscriptiondate': subscriptionDate,
        'subscriptionexpirydate': subscriptionExpiryDate,
        'subscriptiontype': SubscriptionType,
        'appversion': LatestAppVersion,
      });
      await fetchHotelData();
      print('updated');
      return true;
    } else {
      print('empty');
      return false;
    }
  } on Exception catch (error) {
    return 'No internet connection';
  }
}

// Administrators Sign Up
adminSignUp(hotel, firstname, lastname, gender, emailaddress, securityquestion,
    securityanswer, designation, authorizationcode, password) async {
  hotel = hotel.toLowerCase();
  firstname = firstname.toLowerCase();
  lastname = lastname.toLowerCase();
  gender = gender.toLowerCase();
  emailaddress = emailaddress.toLowerCase();
  securityquestion = securityquestion.toLowerCase().hashCode.toString();
  securityanswer = securityanswer.toLowerCase().hashCode.toString();
  designation = designation.toLowerCase();
  authorizationcode = authorizationcode.hashCode;
  password = password.toLowerCase().hashCode.toString();

  fetchHotelDetails();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_administrators);
  final check = await dbClient.find({'emailaddress': emailaddress}).toList();

  try {
    if (check.isEmpty) {
      if (designation == 'owner' &&
          authorizationcode == AuthorizationCodeForOwner) {
        final insert = await dbClient.insert(<String, dynamic>{
          'profilepicture': '',
          'firstname': firstname,
          'lastname': lastname,
          'gender': gender,
          'emailaddress': emailaddress,
          'securityquestion': securityquestion,
          'securityanswer': securityanswer,
          'designation': designation,
          'authorizationcode': authorizationcode,
          'password': password,
        });
        await addDemoRoomNumber();
        print('sign up success');
        return true;
      } else if (designation == 'manager' &&
          authorizationcode == AuthorizationCodeForManager) {
        final insert = await dbClient.insert(<String, dynamic>{
          'profilepicture': '',
          'firstname': firstname,
          'lastname': lastname,
          'gender': gender,
          'emailaddress': emailaddress,
          'securityquestion': securityquestion,
          'securityanswer': securityanswer,
          'designation': designation,
          'authorizationcode': authorizationcode,
          'password': password,
        });
        print('sign up success');
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet connection';
  }
}

adminSignIn(hotel, emailaddress, password) async {
  hotel = hotel.toLowerCase();
  emailaddress = emailaddress.toLowerCase();
  password = password.toLowerCase().hashCode.toString();

  fetchHotelDetails();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_administrators);
  final check = await dbClient.find({'emailaddress': emailaddress}).toList();

  try {
    if (check.isNotEmpty) {
      if (hotel == HotelName &&
          emailaddress == check[0]['emailaddress'] &&
          password == check[0]['password']) {
        print('login success');
        await fetchLoggedInAdminData(emailaddress);
        return true;
      } else {
        return false;
      }
    }
  } on Exception catch (error) {
    return 'No internet connection';
  }
}

fetchLoggedInAdminData(emailaddress) async {
  emailaddress = emailaddress.toLowerCase();

  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_administrators);
  final check = await dbClient.find({'emailaddress': emailaddress}).toList();

  try {
    if (check.isNotEmpty) {
      CurrentLoggedInUserProfilePicture = check[0]['profilepicture'];
      CurrentLoggedInUserFirstname = check[0]['firstname'];
      CurrentLoggedInUserLastname = check[0]['lastname'];
      CurrentLoggedInUserGender = check[0]['gender'];
      CurrentLoggedInUserEmail = check[0]['emailaddress'];
      CurrentLoggedInUserDesignation = check[0]['designation'];
      CurrentLoggedInUserAuthorizationCode = check[0]['authorizationcode'];
      CurrentLoggedInUserSecurityQuestion = check[0]['securityquestion'];
      CurrentLoggedInUserSecurityAnswer = check[0]['securityanswer'];
      CurrentLoggedInUserPassword = check[0]['password'];
      print(CurrentLoggedInUserDesignation);
    }
  } on Exception catch (error) {
    return 'No internet connection';
  }
}

// Reset Password
resetPassword(
    emailaddress, securityquestion, securityanswer, newpassword) async {
  emailaddress = emailaddress.toLowerCase();
  securityquestion = securityquestion.toLowerCase().hashCode.toString();
  securityanswer = securityanswer.toLowerCase().hashCode.toString();
  newpassword = newpassword.toLowerCase().hashCode.toString();

  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_administrators);
  final check = await dbClient.find({'emailaddress': emailaddress}).toList();

  try {
    if (check.isNotEmpty) {
      for (var data in check) {
        if (securityquestion == data['securityquestion'] &&
            securityanswer == data['securityanswer']) {
          print('login success. updating..');
          await fetchLoggedInAdminData(emailaddress);
          if (newpassword != CurrentLoggedInUserPassword) {
            final insert = await dbClient.update({
              'emailaddress': emailaddress
            }, {
              'profilepicture': CurrentLoggedInUserProfilePicture,
              'firstname': CurrentLoggedInUserFirstname,
              'lastname': CurrentLoggedInUserLastname,
              'gender': CurrentLoggedInUserGender,
              'emailaddress': emailaddress,
              'securityquestion': securityquestion,
              'securityanswer': securityanswer,
              'designation': CurrentLoggedInUserDesignation,
              'authorizationcode': CurrentLoggedInUserAuthorizationCode,
              'password': newpassword,
            });
            print('updated');
            await fetchLoggedInAdminData(emailaddress);
            return true;
          }
        }
      }
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

// Add Employee
employeeSignIn(hotel, emailaddress, password) async {
  hotel = hotel.toLowerCase();
  emailaddress = emailaddress.toLowerCase();
  password = password.toLowerCase();

  fetchHotelDetails();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_employees);
  final check = await dbClient.find({'emailaddress': emailaddress}).toList();

  try {
    if (check.isNotEmpty) {
      if (hotel == check[0]['hotel'] &&
          emailaddress == check[0]['emailaddress'] &&
          password == check[0]['password']) {
        if (check[0]['designation'] == 'receptionist' ||
            check[0]['designation'] == 'bartender') {
          await fetchLoggedInEmployeeData(emailaddress);
          print('success sign in');
          return true;
        } else {
          return 'Restricted';
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet connection';
  }
}

employeeSignUp(
    firstname,
    lastname,
    gender,
    emailaddress,
    nationality,
    stateoforigin,
    phonenumber,
    homeaddress,
    dateofemployment,
    designation,
    password) async {
  firstname = firstname.toLowerCase();
  lastname = lastname.toLowerCase();
  gender = gender.toLowerCase();
  emailaddress = emailaddress.toLowerCase();
  nationality = nationality.toLowerCase();
  stateoforigin = stateoforigin.toLowerCase();
  homeaddress = homeaddress.toLowerCase();
  designation = designation.toLowerCase();
  password = password.toLowerCase();

  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_employees);
  final check = await dbClient.find({'emailaddress': emailaddress}).toList();

  try {
    if (check.isEmpty) {
      final insert = await dbClient.insert(<String, dynamic>{
        'hotel': HotelName,
        'firstname': firstname,
        'lastname': lastname,
        'gender': gender,
        'emailaddress': emailaddress,
        'nationality': nationality,
        'stateoforigin': stateoforigin,
        'phonenumber': phonenumber,
        'homeaddress': homeaddress,
        'dateofemployment': dateofemployment,
        'designation': designation,
        'password': password,
      });
      print('success sign up');
      return true;
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet connection';
  }
}

fetchLoggedInEmployeeData(emailaddress) async {
  emailaddress = emailaddress.toLowerCase();

  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_employees);
  final check = await dbClient.find({'emailaddress': emailaddress}).toList();

  try {
    if (check.isNotEmpty) {
      CurrentLoggedInUserFirstname = check[0]['firstname'];
      CurrentLoggedInUserLastname = check[0]['lastname'];
      CurrentLoggedInUserGender = check[0]['gender'];
      CurrentLoggedInUserEmail = check[0]['emailaddress'];
      CurrentLoggedInUserNationality = check[0]['nationality'];
      CurrentLoggedInUserStateOfOrigin = check[0]['stateoforigin'];
      CurrentLoggedInUserPhone = check[0]['phonenumber'];
      CurrentLoggedInUserHomeAddress = check[0]['homeaddress'];
      CurrentLoggedInUserDateOfEmployment = check[0]['dateofemployment'];
      CurrentLoggedInUserDesignation = check[0]['designation'];
      CurrentLoggedInUserPassword = check[0]['password'];
    }
  } on Exception catch (error) {
    return 'No internet connection';
  }
}

// Profile Tab
uploadAdminProfilePicture(profilepicture) async {
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_administrators);
  final check =
      await dbClient.find({'emailaddress': CurrentLoggedInUserEmail}).toList();

  try {
    if (check.isNotEmpty) {
      final insert = await dbClient.update({
        'emailaddress': CurrentLoggedInUserEmail
      }, {
        'profilepicture': profilepicture,
        'firstname': CurrentLoggedInUserFirstname,
        'lastname': CurrentLoggedInUserLastname,
        'gender': CurrentLoggedInUserGender,
        'emailaddress': CurrentLoggedInUserEmail,
        'securityquestion': CurrentLoggedInUserSecurityQuestion,
        'securityanswer': CurrentLoggedInUserSecurityAnswer,
        'designation': CurrentLoggedInUserDesignation,
        'authorizationcode': CurrentLoggedInUserAuthorizationCode,
        'password': CurrentLoggedInUserPassword,
      });
      print('uploaded');
      await fetchLoggedInAdminData(CurrentLoggedInUserEmail);
      return true;
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet connection';
  }
}

updateHotelData(
    hoteladdress,
    hotelcountry,
    hotelcurrency,
    hotelprovince,
    hotelphone,
    standardroomrate,
    executiveroomrate,
    presidentialroomrate) async {
  hoteladdress = hoteladdress.toLowerCase();
  hotelcountry = hotelcountry.toLowerCase();
  hotelcurrency = hotelcurrency.toLowerCase();
  hotelprovince = hotelprovince.toLowerCase();
  standardroomrate = int.parse(standardroomrate);
  executiveroomrate = int.parse(executiveroomrate);
  presidentialroomrate = int.parse(presidentialroomrate);

  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_main);
  final check = await dbClient.find({'hotelname': HotelName}).toList();

  try {
    if (check.isNotEmpty) {
      final insert = await dbClient.update({
        'hotelname': HotelName
      }, {
        'registered': registeredJoGenics,
        'accountname': AccountName,
        'accountnumber': AccountNumber,
        'bank': Bank,
        'authorizationowner': AuthorizationCodeForOwner,
        'authorizationmanager': AuthorizationCodeForManager,
        'hotelname': HotelName,
        'hotelcollectionname': HotelCollectionName,
        'hotelemail': HotelEmailAddress,
        'hotelphone': hotelphone,
        'hoteladdress': hoteladdress,
        'hotelprovince': hotelprovince,
        'hotelcountry': hotelcountry,
        'hotelcurrency': hotelcurrency,
        'standardroomrate': standardroomrate,
        'executiveroomrate': executiveroomrate,
        'presidentialroomrate': presidentialroomrate,
        'basicpackageprice': BasicPackagePrice,
        'standardpackageprice': StandardPackagePrice,
        'subscriptioncheck': SubscriptionCheck,
        'subscriptionpackage': SubscriptionPackage,
        'subscriptiondate': SubscriptionDate,
        'subscriptionexpirydate': SubscriptionExpiryDate,
        'subscriptiontype': SubscriptionType,
        'appversion': LatestAppVersion,
      });
      await fetchHotelData();
      print('updated');
      return true;
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet connection';
  }
}

fetchHotelData() async {
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_main);
  final check = await dbClient.find({'hotelname': HotelName}).toList();

  try {
    if (check.isNotEmpty) {
      registeredJoGenics = check[0]['registered'];
      AccountName = check[0]['accountname'];
      AccountNumber = check[0]['accountnumber'];
      Bank = check[0]['bank'];
      AuthorizationCodeForOwner = check[0]['authorizationowner'];
      AuthorizationCodeForManager = check[0]['authorizationmanager'];
      HotelName = check[0]['hotelname'];
      HotelCollectionName = check[0]['hotelcollectionname'];
      HotelEmailAddress = check[0]['hotelemail'];
      HotelPhone = check[0]['hotelphone'];
      HotelAddress = check[0]['hoteladdress'];
      HotelProvince = check[0]['hotelprovince'];
      HotelCountry = check[0]['hotelcountry'];
      HotelCurrency = check[0]['hotelcurrency'];
      StandardRoomRate = check[0]['standardroomrate'];
      ExecutiveRoomRate = check[0]['executiveroomrate'];
      PresidentialRoomRate = check[0]['presidentialroomrate'];
      BasicPackagePrice = check[0]['basicpackageprice'];
      StandardPackagePrice = check[0]['standardpackageprice'];
      SubscriptionCheck = check[0]['subscriptioncheck'];
      SubscriptionPackage = check[0]['subscriptionpackage'];
      SubscriptionDate = check[0]['subscriptiondate'];
      SubscriptionExpiryDate = check[0]['subscriptionexpirydate'];
      SubscriptionType = check[0]['subscriptiontype'];
      LatestAppVersion = check[0]['appversion'];
      LatestAppVersionDescription = check[0]['updatedescription'];
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet connection';
  }
}

// Administrators Tab
fetchAdministrators() async {
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_administrators);

  final check = await dbClient.find().toList();

  try {
    if (check.isNotEmpty) {
      Administrators = check;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

deleteAdminRecord(emailaddress) async {
  emailaddress = emailaddress.toLowerCase();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_administrators);

  final check = await dbClient.find({'emailaddress': emailaddress}).toList();

  try {
    if (check.isNotEmpty) {
      dbClient.deleteOne({'emailaddress': emailaddress});
      print('delete success');
      return true;
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

findAdmin(emailaddress) async {
  emailaddress = emailaddress.toLowerCase();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_administrators);

  final check = await dbClient.find({'emailaddress': emailaddress}).toList();

  try {
    if (check.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

// Employees Tab
fetchEmployees() async {
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_employees);

  final check = await dbClient.find().toList();

  try {
    if (check.isNotEmpty) {
      Employees = check;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

deleteEmployeeRecord(emailaddress) async {
  emailaddress = emailaddress.toLowerCase();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_employees);

  final check = await dbClient.find({'emailaddress': emailaddress}).toList();

  try {
    if (check.isNotEmpty) {
      dbClient.deleteOne({'emailaddress': emailaddress});
      print('delete success');
      return true;
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

findEmployee(emailaddress) async {
  emailaddress = emailaddress.toLowerCase();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_employees);

  final check = await dbClient.find({'emailaddress': emailaddress}).toList();

  try {
    if (check.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

updateEmployee(
    firstname,
    lastname,
    gender,
    emailaddress,
    nationality,
    stateoforigin,
    phonenumber,
    homeaddress,
    dateofemployment,
    designation,
    password) async {
  firstname = firstname.toLowerCase();
  lastname = lastname.toLowerCase();
  gender = gender.toLowerCase();
  emailaddress = emailaddress.toLowerCase();
  nationality = nationality.toLowerCase();
  stateoforigin = stateoforigin.toLowerCase();
  phonenumber = phonenumber.toLowerCase();
  homeaddress = homeaddress.toLowerCase();
  dateofemployment = dateofemployment.toLowerCase();
  password = password.toLowerCase();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_employees);

  final check = await dbClient.find({'emailaddress': emailaddress}).toList();

  try {
    if (check.isNotEmpty) {
      final insert = await dbClient.update({
        'emailaddress': emailaddress
      }, {
        'hotel': HotelName,
        'firstname': firstname,
        'lastname': lastname,
        'gender': gender,
        'emailaddress': emailaddress,
        'nationality': nationality,
        'stateoforigin': stateoforigin,
        'phonenumber': phonenumber,
        'homeaddress': homeaddress,
        'dateofemployment': dateofemployment,
        'designation': designation,
        'password': password,
      });
      return true;
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

// Inventory tab
addProduct(productid, productname, costprice, mrp, lounge, category,
    subcategory, vendorphone) async {
  productid = productid.toLowerCase();
  productname = productname.toLowerCase();
  // quantity = quantity.toLowerCase();
  costprice = costprice.toLowerCase();
  mrp = mrp.toLowerCase();
  lounge = lounge.toLowerCase();
  category = category.toLowerCase();
  subcategory = subcategory.toLowerCase();
  vendorphone = vendorphone.toLowerCase();

  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_inventory);
  final check = await dbClient.find({'productid': productid}).toList();

  try {
    if (check.isEmpty) {
      final insert = await dbClient.insert(<String, dynamic>{
        'productid': productid,
        'productname': productname,
        // 'quantity': quantity,
        'costprice': costprice,
        'mrp': mrp,
        'lounge': lounge,
        'category': category,
        'subcategory': subcategory,
        'vendorphone': vendorphone,
      });
      print('success product added');
      return true;
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet connection';
  }
}

updateProduct(productid, productname, costprice, mrp, lounge, category,
    subcategory, vendorphone) async {
  // productid = productid.toLowerCase();
  productname = productname.toLowerCase();
  // quantity = quantity.toLowerCase();
  costprice = costprice.toLowerCase();
  mrp = mrp.toLowerCase();
  lounge = lounge.toLowerCase();
  category = category.toLowerCase();
  subcategory = subcategory.toLowerCase();
  vendorphone = vendorphone.toLowerCase();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_inventory);

  final check = await dbClient.find({'productid': productid}).toList();

  try {
    if (check.isNotEmpty) {
      final insert = await dbClient.update({
        'productid': productid
      }, {
        'productid': productid,
        'productname': productname,
        // 'quantity': quantity,
        'costprice': costprice,
        'mrp': mrp,
        'lounge': lounge,
        'category': category,
        'subcategory': subcategory,
        'vendorphone': vendorphone,
      });
      return true;
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

checkForValidProductId(productid) async {
  productid = productid.toLowerCase();

  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_inventory);

  final check = await dbClient.find({'productid': productid}).toList();

  if (check.isEmpty) {
    return true;
  } else {
    return false;
  }
}

fetchInventroy() async {
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_inventory);

  final check = await dbClient.find().toList();

  try {
    if (check.isNotEmpty) {
      ProductsRecord = check;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

findProduct(productid) async {
  productid = productid.toString();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_inventory);

  final check = await dbClient.find({'productid': productid}).toList();

  try {
    if (check.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

deleteProduct(productid) async {
  productid = productid.toLowerCase();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_inventory);

  final check = await dbClient.find({'productid': productid}).toList();

  try {
    if (check.isNotEmpty) {
      dbClient.deleteOne({'productid': productid});
      print('delete success');
      return true;
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

// Invoices Tab
fetchInvoicesRecord() async {
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_invoices);

  final check = await dbClient.find().toList();

  try {
    if (check.isNotEmpty) {
      InvoicesRecord = check;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

// Sales Tab
updateProductQuantity(productid, productname, quantity, costprice, mrp, lounge,
    category, subcategory, vendorphone) async {
  productid = productid.toLowerCase();
  productname = productname.toLowerCase();
  quantity = quantity.toLowerCase();
  costprice = costprice.toLowerCase();
  mrp = mrp.toLowerCase();
  lounge = lounge.toLowerCase();
  category = category.toLowerCase();
  subcategory = subcategory.toLowerCase();
  vendorphone = vendorphone.toLowerCase();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_inventory);

  final check = await dbClient.find({'productid': productid}).toList();

  try {} on Exception catch (error) {
    return 'No internet';
  }
}

sellProducts(invoicenumber, date, lounge, bartender, waiter, modeofpayment,
    posreforconfirmation, totalcost, cartalog) async {
  invoicenumber = invoicenumber.toString();
  lounge = lounge.toLowerCase();
  bartender = bartender.toLowerCase();
  waiter = waiter.toLowerCase();
  modeofpayment = modeofpayment.toLowerCase();
  posreforconfirmation = posreforconfirmation.toLowerCase();
  totalcost = totalcost.toLowerCase();
  // cartalog = cartalog.toLowerCase();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_invoices);

  // final check = await dbClient.find().toList();

  try {
    final insert = await dbClient.insert(<String, dynamic>{
      'invoicenumber': invoicenumber,
      'date': date,
      'lounge': lounge,
      'bartender': bartender,
      'waiter': waiter,
      'modeofpayment': modeofpayment,
      'posreforconfirmation': posreforconfirmation,
      'totalcost': totalcost,
      'cartalog': cartalog
    });
    return true;
  } on Exception catch (error) {
    return 'No internet';
  }
}

checkForValidInvoiceNumber(invoicenumber) async {
  invoicenumber = invoicenumber.toString();

  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_invoices);

  final check = await dbClient.find({'invoicenumber': invoicenumber}).toList();

  if (check.isEmpty) {
    return true;
  } else {
    return false;
  }
}

// Check In Tab
addDemoRoomNumber() async {
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_customers);

  final check = await dbClient.find({'customerid': 'demo1'}).toList();
  print(check);

  try {
    if (check.isEmpty) {
      final insert1 = await dbClient.insert(<String, dynamic>{
        'customerid': 'demo1',
        'firstname': 'demo1',
        'lastname': 'demo1',
        'gender': 'male',
        // 'nationality': 'demo1',
        // 'stateoforigin': 'demo1',
        'emailaddress': 'demo1',
        'phonenumber': '0',
        'modeofidentification': 'international passport',
        'idnumber': 'demo1',
        'roomtype': 'standard',
        'roomnumber': '100',
        'checkindate': '01-01-2000',
        'checkoutdate': '02-01-2000',
        'billtype': 'no discount',
        'discount': 'demo1',
        'modeofpayment': 'cash',
        'posreferenceorconfirmation': 'demo1',
        'duration': '0',
        'totalcost': '0',
      });
      final insert2 = await dbClient.insert(<String, dynamic>{
        'customerid': 'demo2',
        'firstname': 'demo2',
        'lastname': 'demo2',
        'gender': 'female',
        // 'nationality': 'demo2',
        // 'stateoforigin': 'demo2',
        'emailaddress': 'demo2',
        'phonenumber': '0',
        'modeofidentification': 'international passport',
        'idnumber': 'demo2',
        'roomtype': 'executive',
        'roomnumber': '100',
        'checkindate': '02-01-2000',
        'checkoutdate': '03-01-2000',
        'billtype': 'no discount',
        'discount': 'demo2',
        'modeofpayment': 'cash',
        'posreferenceorconfirmation': 'demo2',
        'duration': '0',
        'totalcost': '0',
      });
      final insert3 = await dbClient.insert(<String, dynamic>{
        'customerid': 'demo3',
        'firstname': 'demo3',
        'lastname': 'demo3',
        'gender': 'others',
        // 'nationality': 'demo3',
        // 'stateoforigin': 'demo3',
        'emailaddress': 'demo3',
        'phonenumber': 'demo3',
        'modeofidentification': 'international passport',
        'idnumber': 'demo3',
        'roomtype': 'presidential',
        'roomnumber': '100',
        'checkindate': '03-01-2000',
        'checkoutdate': '04-01-2000',
        'billtype': 'no discount',
        'discount': 'demo3',
        'modeofpayment': 'cash',
        'posreferenceorconfirmation': 'demo3',
        'duration': '0',
        'totalcost': '0',
      });
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

checkForValidCustomerId(customerid) async {
  customerid = customerid.toLowerCase();

  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_customers);

  final check = await dbClient.find({'customerid': customerid}).toList();

  if (check.isEmpty) {
    return true;
  } else {
    return false;
  }
}

checkInCustomer(
    customerid,
    firstname,
    lastname,
    gender,
    // nationality,
    // stateoforigin,
    emailaddress,
    phonenumber,
    modeofidentification,
    idnumber,
    roomtype,
    roomnumber,
    checkindate,
    checkoutdate,
    billtype,
    discount,
    modeofpayment,
    posreferenceorconfirmation,
    duration,
    totalcost) async {
  customerid = customerid.toLowerCase();
  firstname = firstname.toLowerCase();
  lastname = lastname.toLowerCase();
  gender = gender.toLowerCase();
  // nationality = nationality.toLowerCase();
  // stateoforigin = stateoforigin.toLowerCase();
  emailaddress = emailaddress.toLowerCase();
  phonenumber = phonenumber.toLowerCase();
  modeofidentification = modeofidentification.toLowerCase();
  idnumber = idnumber.toLowerCase();
  roomtype = roomtype.toLowerCase();
  roomnumber = roomnumber.toLowerCase();
  checkindate = checkindate.toLowerCase();
  checkoutdate = checkoutdate.toLowerCase();
  billtype = billtype.toLowerCase();
  discount = discount.toLowerCase();
  modeofpayment = modeofpayment.toLowerCase();
  posreferenceorconfirmation = posreferenceorconfirmation.toLowerCase();
  duration = duration.toString();
  totalcost = totalcost.toString();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_customers);

  final check = await dbClient.find({'customerid': customerid}).toList();

  try {
    if (check.isEmpty) {
      final insert = await dbClient.insert(<String, dynamic>{
        'customerid': customerid,
        'firstname': firstname,
        'lastname': lastname,
        'gender': gender,
        // 'nationality': nationality,
        // 'stateoforigin': stateoforigin,
        'emailaddress': emailaddress,
        'phonenumber': phonenumber,
        'modeofidentification': modeofidentification,
        'idnumber': idnumber,
        'roomtype': roomtype,
        'roomnumber': roomnumber,
        'checkindate': checkindate,
        'checkoutdate': checkoutdate,
        'billtype': billtype,
        'discount': discount,
        'modeofpayment': modeofpayment,
        'posreferenceorconfirmation': posreferenceorconfirmation,
        'duration': duration,
        'totalcost': totalcost,
      });
      return true;
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

updateCustomer(
    customerid,
    firstname,
    lastname,
    gender,
    // nationality,
    // stateoforigin,
    emailaddress,
    phonenumber,
    modeofidentification,
    idnumber,
    roomtype,
    roomnumber,
    checkindate,
    checkoutdate,
    billtype,
    discount,
    modeofpayment,
    posreferenceorconfirmation,
    duration,
    totalcost) async {
  customerid = customerid.toLowerCase();
  firstname = firstname.toLowerCase();
  lastname = lastname.toLowerCase();
  gender = gender.toLowerCase();
  // nationality = nationality.toLowerCase();
  // stateoforigin = stateoforigin.toLowerCase();
  emailaddress = emailaddress.toLowerCase();
  phonenumber = phonenumber.toLowerCase();
  modeofidentification = modeofidentification.toLowerCase();
  idnumber = idnumber.toLowerCase();
  roomtype = roomtype.toLowerCase();
  roomnumber = roomnumber.toLowerCase();
  checkindate = checkindate.toLowerCase();
  checkoutdate = checkoutdate.toLowerCase();
  billtype = billtype.toLowerCase();
  discount = discount.toLowerCase();
  modeofpayment = modeofpayment.toLowerCase();
  posreferenceorconfirmation = posreferenceorconfirmation.toLowerCase();
  duration = duration.toString();
  totalcost = totalcost.toString();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_customers);

  final check = await dbClient.find({'customerid': customerid}).toList();

  try {
    if (check.isNotEmpty) {
      final insert = await dbClient.update({
        'customerid': customerid
      }, {
        'customerid': customerid,
        'firstname': firstname,
        'lastname': lastname,
        'gender': gender,
        // 'nationality': nationality,
        // 'stateoforigin': stateoforigin,
        'emailaddress': emailaddress,
        'phonenumber': phonenumber,
        'modeofidentification': modeofidentification,
        'idnumber': idnumber,
        'roomtype': roomtype,
        'roomnumber': roomnumber,
        'checkindate': checkindate,
        'checkoutdate': checkoutdate,
        'billtype': billtype,
        'discount': discount,
        'modeofpayment': modeofpayment,
        'posreferenceorconfirmation': posreferenceorconfirmation,
        'duration': duration,
        'totalcost': totalcost,
      });
      return true;
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

fetchCustomer(customerid) async {
  customerid = customerid.toLowerCase();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_customers);

  final check = await dbClient.find({'customerid': customerid}).toList();

  try {
    if (check.isNotEmpty) {
      CustomerRecordForUpdate = check;
      return true;
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

insertCheckInCheckOutTimeStamp(
    employee,
    message,
    firstname,
    lastname,
    roomtype,
    roomnumber,
    checkindate,
    checkoutdate,
    billtype,
    discount,
    totalcost,
    date,
    time) async {
  employee = employee.toLowerCase();
  message = message.toLowerCase();
  firstname = firstname.toLowerCase();
  lastname = lastname.toLowerCase();
  roomtype = roomtype.toLowerCase();
  roomnumber = roomnumber.toLowerCase();
  checkindate = checkindate.toLowerCase();
  checkoutdate = checkoutdate.toLowerCase();
  billtype = billtype.toLowerCase();
  discount = discount.toLowerCase();
  totalcost = totalcost.toString().toLowerCase();
  date = date.toString().toLowerCase();
  time = time.toString().toLowerCase();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_timestamp_checkin_checkout);

  try {
    final insert = await dbClient.insert(<String, dynamic>{
      'employee': employee,
      'alert': "$message $firstname $lastname.",
      'checkindate': checkindate,
      'checkoutdate': checkoutdate,
      'billtype': billtype,
      'discount': discount,
      'totalcost': totalcost,
      'date': date,
      'time': time,
    });
  } on Exception catch (error) {
    return 'No internet';
  }
}

insertUpdateTimeStamp(
    employee,
    message,
    customerid,
    firstname,
    lastname,
    roomtype,
    roomnumber,
    checkindate,
    checkoutdate,
    billtype,
    discount,
    totalcost,
    date,
    time) async {
  employee = employee.toLowerCase();
  message = message.toLowerCase();
  customerid = customerid.toLowerCase();
  firstname = firstname.toLowerCase();
  lastname = lastname.toLowerCase();
  roomtype = roomtype.toLowerCase();
  roomnumber = roomnumber.toLowerCase();
  checkindate = checkindate.toLowerCase();
  checkoutdate = checkoutdate.toLowerCase();
  billtype = billtype.toLowerCase();
  discount = discount.toLowerCase();
  totalcost = totalcost.toString().toLowerCase();
  date = date.toString().toLowerCase();
  time = time.toString().toLowerCase();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_timestamp_update);

  // final check = await dbClient.find({'customerid': customerid}).toList();

  try {
    final insert = await dbClient.insert(<String, dynamic>{
      'employee': employee,
      'alert': "$message $firstname $lastname (id: $customerid) record.",
      'newroomtype': roomtype,
      'newroomnumber': roomnumber,
      'newcheckindate': checkindate,
      'newcheckoutdate': checkoutdate,
      'newbilltype': billtype,
      'newdiscount': discount,
      'newtotalcost': totalcost,
      'date': date,
      'time': time,
    });
  } on Exception catch (error) {
    return 'No internet';
  }
}

// Customer Records Tab
fetchCustomersRecord() async {
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_customers);

  final check = await dbClient.find().toList();

  try {
    if (check.isNotEmpty) {
      CustomersRecord = check;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

deleteCustomerRecord(customerid) async {
  customerid = customerid.toLowerCase();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_customers);

  final check = await dbClient.find({'customerid': customerid}).toList();

  try {
    if (check.isNotEmpty) {
      dbClient.deleteOne({'customerid': customerid});
      print('delete success');
      return true;
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

findCustomerRecordByLastName(lastname) async {
  lastname = lastname.toLowerCase();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_customers);

  final check = await dbClient.find({'lastname': lastname}).toList();

  try {
    if (check.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

findCustomerRecordById(customerid) async {
  customerid = customerid.toLowerCase();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_customers);

  final check = await dbClient.find({'customerid': customerid}).toList();

  try {
    if (check.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

fetchEmployeeTimeStampCheckin_out() async {
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_timestamp_checkin_checkout);

  final check = await dbClient.find().toList();

  try {
    if (check.isNotEmpty) {
      EmployeetimeStampCheckin_out = check;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

findEmployeeByFullNameTScheckin_out(fullname) async {
  fullname = fullname.toLowerCase();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_timestamp_checkin_checkout);

  final check = await dbClient.find({'employee': fullname}).toList();

  try {
    if (check.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

findEmployeeTimeStampCheckin_outByEmployeeFullName(fullname) async {
  fullname = fullname.toLowerCase();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_timestamp_checkin_checkout);

  final check = await dbClient.find({'employee': fullname}).toList();

  try {
    if (check.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

fetchEmployeeTimeStampUpdate() async {
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_timestamp_update);

  final check = await dbClient.find().toList();

  try {
    if (check.isNotEmpty) {
      EmployeetimeStampUpdate = check;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

findEmployeeByFullNameTSupdate(fullname) async {
  fullname = fullname.toLowerCase();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_timestamp_update);

  final check = await dbClient.find({'employee': fullname}).toList();

  try {
    if (check.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}

findEmployeeTimeStampUpdateByEmployeeFullName(fullname) async {
  fullname = fullname.toLowerCase();
  final db = await Db.create(db_url);
  await db.open();
  final dbClient = db.collection(db_collection_timestamp_update);

  final check = await dbClient.find({'employee': fullname}).toList();

  try {
    if (check.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on Exception catch (error) {
    return 'No internet';
  }
}
