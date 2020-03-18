import 'model_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'page_home.dart';

void main() {
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

// 48