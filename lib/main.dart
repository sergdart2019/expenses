import 'models/model_transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'views/page_home.dart';

void main() {
//  Disable Landscape
//  SystemChrome.setPreferredOrientations([
//    DeviceOrientation.portraitUp,
//    DeviceOrientation.portraitDown,
//  ]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.purple));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<Transactions>(create: (c) => Transactions())],
      child: MaterialApp(
        title: 'Expenses',
        home: PageHome(),
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
