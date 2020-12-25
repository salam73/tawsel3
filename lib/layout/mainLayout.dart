import 'package:firetodowithauth/layout/usersLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('شركة'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Get.to(UsersLayout());
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.3,
                  color: Colors.deepOrangeAccent,
                  child: Text(
                    'عملاء',
                    style: TextStyle(
                        fontSize: (MediaQuery.of(context).size.width * 0.3) / 4,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.3,
                  color: Colors.lightBlueAccent,
                  child: Text(
                    'محافظات',
                    style: TextStyle(
                        fontSize: (MediaQuery.of(context).size.width * 0.3) / 5,
                        color: Colors.white),
                  )),
              /* RaisedButton(
                onPressed: () {
                  Get.to(UserList());
                },
                child: Text('المحلات'),
              ),
              RaisedButton(
                onPressed: () {
                  Get.to(SortOrdersByDate());
                },
                child: Text('التاريخ'),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
