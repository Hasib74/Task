import 'package:flutter/material.dart';
import 'package:taskapp/src/MainActivity.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/src/Provider/MainActivityProvider.dart';

void main() {
  runApp(ChangeNotifierProvider<MainActivityProvider>(

     create: (_) => MainActivityProvider(),
      child: MaterialApp(home : MainActivity())));
}

