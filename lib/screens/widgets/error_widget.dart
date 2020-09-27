import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildErrorWidget(Object error) {
  return Container(
      width: double.infinity,
      child: Text('$error', style: TextStyle(fontSize: 20, color: Colors.white),));
}