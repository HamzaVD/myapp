import 'package:flutter/material.dart';
import 'package:myapp/auth_screen.dart';
import 'package:myapp/home_screen.dart';

import 'util/global.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corontine Diary',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // fontFamily: 'Montserrat',
        accentColor: ThemeConstants.primaryColor,
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'My Qurantine Diary'),
    );
  }
}
