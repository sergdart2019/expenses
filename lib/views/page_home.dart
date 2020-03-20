import 'dart:io';

import 'package:expenses/views/widget_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/model_transactions.dart';
import 'widget_bottom_sheet_add_new_transaction.dart';
import 'widget_transaction_list_item.dart';

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool textFields = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final Transactions transactions = Provider.of<Transactions>(context);
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: null,
            navigationBar: CupertinoNavigationBar(),
//      child: chlid, need to implement the same body as below...
          )
        : Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text('Expenses'),
              actions: <Widget>[
                // On IOS, render Add Button here instead of FAB
                Platform.isIOS
                    ? Container(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                        child: MaterialButton(
                          color: Theme.of(context).accentColor,
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (anotherContext) {
                                  return WidgetNewTransaction(_scaffoldKey);
                                });
                          },
                          child: Icon(Icons.add),
                          minWidth: 50,
                          height: 50,
                          shape: CircleBorder(),
                        ),
                      )
                    : Container(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  child: MaterialButton(
                    color: Theme.of(context).accentColor,
                    onPressed: () => setState(() {
                      textFields = !textFields;
                    }),
                    child: textFields ? Icon(Icons.close) : Icon(Icons.table_chart),
                    minWidth: 50,
                    height: 50,
                    shape: CircleBorder(),
                  ),
                )
              ],
            ),
            body: Container(
              /// This sets the fixed height of the body
              height: mediaQuery.size.height - 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Graph
                  if (textFields)
                    WidgetChart(),
                  // List of Transactions
                  transactions.transactions.isEmpty
                      ? Flexible(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.speaker_notes_off,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                                Text(
                                  'No Data',
                                  style: TextStyle(color: Colors.grey, fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        )
                      : Flexible(
                          child: ListView.builder(
                            itemCount: transactions.transactions.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return WidgetTransactionItem(
                                transaction: transactions.transactions[index],
                                index: index,
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (anotherContext) {
                            return WidgetNewTransaction(_scaffoldKey);
                          });
                    },
                    child: Icon(Icons.add),
                  ),
          );
  }
}

/*
showModalBottomSheet(
 isScrollControlled: true,
 builder: (BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
          child: Form(...)) // Form with TFFs


});
 */
