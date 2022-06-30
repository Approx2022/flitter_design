import 'package:flitter_design/database/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'pages/BookList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: BookList(),
        );
      },
    );
  }
}
