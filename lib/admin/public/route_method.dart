import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/admin/public/variables.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void check(BuildContext context, var func1, var func2) async {
  final getstorage = GetStorage();

  var id = getstorage.read('mobile').toString();
  final DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('user').doc(id).get();

  if (snapshot['business name'] != null) {
    b_name = snapshot['business name'];

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => func1,
      ),
    );
  } else if (snapshot['business name'] == null) {
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => func2,
      ),
    );
  }
}
