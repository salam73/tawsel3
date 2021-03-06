import 'package:firetodowithauth/controllers/authController.dart';
import 'package:firetodowithauth/controllers/userController.dart';
import 'package:firetodowithauth/layout/mainLayout.dart';
import 'package:firetodowithauth/screens/appByUser/home.dart';
import 'package:firetodowithauth/screens/auth/login.dart';
import 'package:firetodowithauth/testing/mainTest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root extends GetWidget<AuthController> {
  //Just For Switching to Home to Login
  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      initState: (_) async {
        Get.put<UserController>(UserController());
      },
      builder: (_) {
        if (Get.find<AuthController>().user != null) {
          //Need to Find Controller for user instance
          //  Home() for userApp
          // return Home();
          return MainLayout();
        } else {
          return Login();
        }
      },
    );
  }
}
