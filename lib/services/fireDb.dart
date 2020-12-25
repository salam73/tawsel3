import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firetodowithauth/models/order.dart';
import 'package:firetodowithauth/models/todo.dart';
import 'package:firetodowithauth/models/user.dart';

// All FireStore Opration in This Class
class FireDb {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("users").doc(user.id).set({
        "name": user.name,
        "email": user.email,
        "password": user.password,
        "phoneNumber": user.phoneNumber,
        "shopAddress": user.shopAddress,
        "shopName": user.shopName,
        "role": user.role,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel> getUser({String uid}) async {
    try {
      DocumentSnapshot _doc =
          await _firestore.collection("users").doc(uid).get();

      return UserModel.fromSnapShot(_doc);
    } catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot> getOrdersList() {
    try {
      return FirebaseFirestore.instance
          .collection('orders')
          .where('type', isEqualTo: 'shop')
          .snapshots();
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<OrderModel>> orderStream(String uid) {
    return _firestore
        .collection("users")
        .doc(uid)
        .collection("orders")
        // .orderBy("dateCreated", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<OrderModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(OrderModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Stream<List<OrderModel>> allOrderStreamByStatus(
      {String status, String sortingName}) {
    return _firestore
        .collection("orders")
        .where('status', isEqualTo: status ?? '')
        .orderBy(sortingName ?? 'dateCreated', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<OrderModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(OrderModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Stream<List<OrderModel>> orderStreamByUserId(String uid) {
    return _firestore
        .collection("users")
        .doc(uid)
        .collection("orders")
        // .where('done', isEqualTo: false)
        .orderBy('deliveryToCity')
        // .orderBy("dateCreated", descending: true)

        //
        .snapshots()
        .map((QuerySnapshot query) {
      List<OrderModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(OrderModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Future<void> updateOrder(OrderModel order, String uid) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection("orders")
          .doc(order.orderId)
          .update(order.toJson());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updateOrder2(OrderModel order, String uid) async {
    try {
      _firestore.collection("orders").doc(uid).update(order.toJson());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteOrder(OrderModel order, String uid) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection("orders")
          .doc(order.orderId)
          .delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addTodo(String content, String uid) async {
    try {
      await _firestore.collection("users").doc(uid).collection("todos").add({
        'dateCreated': Timestamp.now(),
        'content': content,
        'done': false,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<TodoModel>> todoStream(String uid) {
    return _firestore
        .collection("users")
        .doc(uid)
        .collection("todos")
        .orderBy("dateCreated", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<TodoModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(TodoModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Future<void> updateTodo(TodoModel todo, String uid) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .doc(todo.todoId)
          .update(todo.toJson());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteTodo(TodoModel todo, String uid) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .doc(todo.todoId)
          .delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
