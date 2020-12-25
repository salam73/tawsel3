import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:firetodowithauth/controllers/authController.dart';
import 'package:firetodowithauth/controllers/userController.dart';
import 'package:firetodowithauth/models/user.dart';
import 'package:firetodowithauth/services/fireDb.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

// ignore: must_be_immutable
class OrderInput extends StatelessWidget {
  final AuthController _authController = Get.find();

  UserController _userController = Get.find();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var orderNumber = TextEditingController();
  var customerName = TextEditingController();
  var customerAddress = TextEditingController();
  var customerPhone = TextEditingController();

  var amountAfterDelivery = TextEditingController();
  var cityName = TextEditingController();
  var orderType = TextEditingController();
  var commit = TextEditingController();

  //var passwordController = TextEditingController();

  // var firebaseDB = FirebaseFirestore.instance.collection('users').snapshots();
  // final firestoreInstance = FirebaseFirestore.instance;

  Future<UserModel> myUser =
      FireDb().getUser(uid: Get.find<AuthController>().user.uid);

  String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(farsi[i], english[i]);
    }

    return input;
  }

  getUserName() {
    return GetX<UserController>(
      init: Get.put(UserController()),
      initState: (_) async {
        Get.find<UserController>().user =
            await FireDb().getUser(uid: Get.find<AuthController>().user.uid);
      },
      builder: (_userController) {
        return _userController.user == null
            ? Container()
            : Column(
                children: [
                  Text(_userController.user.shopName.toString()),
                  Text(_userController.user.name.toString()),
                  Text(_userController.user.phoneNumber.toString()),
                ],
              );
      },
    );
  }

  void _addOrder() {
    FireDb().addOrder(
      // content:_textEditingController.text,
      uid: _userController.user.id,
      orderNumber: orderNumber.text,
      deliveryToCity: cityName.text,
      customerName: customerName.text,
      customerAddress: customerAddress.text,
      customerPhone: customerPhone.text,
      amountAfterDelivery:
          int.parse(replaceFarsiNumber(amountAfterDelivery.text)),
      orderType: orderType.text ?? '',

      commit: commit.text ?? '',
      // content: orderType.text ?? ''
    );
    // shopName.clear();
    _getSnackBar();
  }

  _getSnackBar() {
    Get.snackbar('إضافة', 'لقد قمت بإظافة طلب بنجاح',
        snackPosition: SnackPosition.BOTTOM);
  }

  _errorSnackBack({String title}) {
    Get.snackbar('خطا', 'الرجاء اضافة $title',
        backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
  }

/*  void _onPressed2() {
    firestoreInstance.collection("users").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
      });
    });
  }*/

  List<String> country = [
    'الرمادي',
    'الحلة‎',
    'بغداد',
    'البصرة',
    'الناصرية',
    'بعقوبة‎',
    'دهوك',
    'أربيل',
    'كربلاء',
    'كركوك',
    'العمارة',
    'السماوة',
    'النجف',
    'الموصل',
    'الديوانية',
    'تكريت',
    'السليمانية',
    'الكوت',
    // "كربلاء",
    // "بغداد",
    // "النجف",
    // "ديوانية",
    // "البصرة",
    // "ميسان",
    // "الشمال",
    // "بابل",
    // "اربيل"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('أضف طلب'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _authController.logOut();
            },
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                getUserName(),
                /* TextField(
                    controller: shopName,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'إسم المتجر',
                      labelStyle: TextStyle(fontSize: 14),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 10,
                  ),
 */
                DropDownField(
                  controller: cityName,
                  onValueChanged: (dynamic value) {
                    cityName.text = value;

                    // print(value);
                  },
                  //  icon: Icon(Icons.ac_unit),
                  value: cityName.text,
                  required: true,
                  hintText: 'أختر مدينة',
                  labelText: 'المدن',
                  items: country,
                ),

                SizedBox(
                  height: 10,
                ),
                //phone
                TextField(
                  controller: orderNumber,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'رقم الفاتورة',
                    labelStyle: TextStyle(fontSize: 14),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: customerName,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'إسم الزبون',
                    labelStyle: TextStyle(fontSize: 14),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: customerAddress,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'عنوان الزبون',
                    labelStyle: TextStyle(fontSize: 14),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: customerPhone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'رقم هاتف الزبون',
                    labelStyle: TextStyle(fontSize: 14),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: amountAfterDelivery,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'المبلغ مع التوصيل',
                    labelStyle: TextStyle(fontSize: 14),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: orderType,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'نوع المنتج',
                    labelStyle: TextStyle(fontSize: 14),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 10,
                ),

                TextField(
                  controller: commit,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'ملاحظات',
                    labelStyle: TextStyle(fontSize: 14),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 10,
                ),

                RaisedButton(
                    onPressed: () {
                      print(cityName);
                      if (cityName.text == null || cityName.text == '')
                        _errorSnackBack(title: 'إسم المدينة');
                      else if (orderNumber.text == '')
                        _errorSnackBack(title: 'رقم الفاتورة');
                      else if (customerName.text == '')
                        _errorSnackBack(title: 'إسم الزبون');
                      else if (customerAddress.text == '')
                        _errorSnackBack(title: 'عنوان الزبون');
                      else if (customerPhone.text == '')
                        _errorSnackBack(title: 'رقم هاتف الزبون');
                      else if (amountAfterDelivery.text == '')
                        _errorSnackBack(title: 'المبلغ الواصل');
                      else if (orderType.text == '')
                        _errorSnackBack(title: 'المحتوى');
                      else {
                        _addOrder();
                        cityName.clear();

                        customerName.clear();
                        customerAddress.clear();
                        customerPhone.clear();
                        amountAfterDelivery.clear();

                        orderNumber.clear();
                        orderType.clear();
                        commit.clear();
                      }
                    },
                    child: Text('اضف')),
              ],
            ),
          ),
        ),
      ),
    );

    /*StreamBuilder(
        stream: firebaseDB,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return ListView.builder(
              itemCount: 2,
              itemBuilder: (context, int index) {
                return (Text(snapshot.data.documents[index]['name']));
              });
        },
      ),*/
  }
}
