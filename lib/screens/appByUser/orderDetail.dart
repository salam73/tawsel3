import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firetodowithauth/controllers/authController.dart';
import 'package:firetodowithauth/models/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetail extends StatelessWidget {
  final AuthController _authController = Get.find();

  //final String orderId;
  final OrderModel order;

  OrderDetail({
    this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('order detail'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'رقم الطلب : ' + order.orderNumber,
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  'حالة الطلب : ' + order.status,
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  'السبب : ' + order.statusTitle,
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  'إسم الزبون : ' + order.customerName,
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  'عنوان المبون :' + order.customerAddress,
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  'هاتف الزبون : ' + order.customerPhone,
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  'المحافظة : ' + order.deliveryToCity,
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  'المبلغ مع التوصيل : ' + order.amountAfterDelivery.toString(),
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  'المحتوى : ' + order.orderType,
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  'ملاحظة : ' + order.commit,
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding orderDetialText(String name, String detailName) {
    return Padding(
      padding: EdgeInsets.only(right: 18.0),
      child: Container(
        alignment: Alignment.centerRight,
        child: Text(
          '$name: $detailName',
          style: TextStyle(fontSize: 27),
        ),
      ),
    );
  }
}
