import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_fs/models/user.dart';
import 'package:flutter/material.dart';

final ins = FirebaseFirestore.instance.collection('coba');
final ctrl1 = TextEditingController();
final ctrl2 = TextEditingController();
var isLoading = false;
var isShowClear1 = false;
var isShowClear2 = false;
var selectedId = '';
List<UserX> userList = [];

var isEnd = false;
