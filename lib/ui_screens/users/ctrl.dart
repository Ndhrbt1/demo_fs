import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_fs/models/user.dart';
import 'package:demo_fs/ui_screens/users/data.dart';
import 'package:flutter/material.dart';

Future createDoc(UserX data) async {
  final map = data.toMap();
  final docId = data.id;
  final nama = data.nama;
  final createdAt = data.createdAt;
  await FirebaseFirestore.instance.collection('username').doc(docId).set({
    'nama': nama,
    'id': docId,
    'created_at': createdAt,
  });
  await FirebaseFirestore.instance.collection('userDetail').doc(docId).set(map);
  userList.insert(0, data);
}

Future updateDoc(UserX data) async {
  final map = data.toMap();
  final docId = data.id;
  final nama = data.nama;
  final createdAt = data.createdAt;
  await FirebaseFirestore.instance.collection('username').doc(docId).set({
    'nama': nama,
    'id': docId,
    'created_at': createdAt,
  });
  await FirebaseFirestore.instance.collection('userDetail').doc(docId).set(map);

  final index = userList.indexWhere((element) => element.id == docId);
  debugPrint(userList[index].toString());
  userList[index] = data;
  debugPrint(userList[index].toString());
}

// Future createDoc(Map<String, dynamic> data) async {
//   final docId = UniqueKey().toString();
//   debugPrint(docId);
//   final nama = data['nama'];
//   await FirebaseFirestore.instance.collection('username').doc(docId).set({'nama': nama});
//   await FirebaseFirestore.instance.collection('userDetail').doc(docId).set(data);
// }

Future<List<UserX>> getColl() async {
  List<UserX> users = [];
  // final result = await FirebaseFirestore.instance.collection('username').get();
  // final result = await FirebaseFirestore.instance.collection('username').orderBy('created_at', descending: true).get();
  final result =
      // await FirebaseFirestore.instance.collection('username').orderBy('created_at', descending: true).limit(3).get();
      await FirebaseFirestore.instance
          .collection('username')
          .orderBy('created_at', descending: true)
          .limit(3)
          .startAfter([userList.isEmpty ? '9999-99-99' : userList.last.createdAt]).get();
  for (var element in result.docs) {
    users.add(UserX.fromMap(element.data()));
  }
  return users;
}

addColToUserList() async {
  final dataCol = await getColl();
  userList.addAll(dataCol);
  isShowEnd(dataCol);
}

// loadmore() async {
//   final dataCol = await getColl();
//   userList.addAll(dataCol);
//   isShowEnd(dataCol);
// }

isShowEnd(List<UserX> dataCol) {
  if (dataCol.length < 3) {
    isEnd = true;
  }
}

// Future<QuerySnapshot<Map<String, dynamic>>> getColl() async {
//   final result = await FirebaseFirestore.instance.collection('username').get();
//   return result;
// }

Future<UserX> getDoc(String id) async {
  final result = await FirebaseFirestore.instance.collection('userDetail').doc(id).get();
  final user = UserX.fromMap(result.data() ?? {});
  return user;
}
// Future<DocumentSnapshot<Map<String, dynamic>>> getDoc(String id) async {
//   final result = await FirebaseFirestore.instance.collection('userDetail').doc(id).get();
//   return result;
// }

Future<void> deleteDoc(String docId) async {
  await FirebaseFirestore.instance.collection('username').doc(docId).delete();
  await FirebaseFirestore.instance.collection('userDetail').doc(docId).delete();

  final index = userList.indexWhere((element) => element.id == docId);
  userList.removeAt(index);
}
