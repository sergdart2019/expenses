import 'package:expenses/widget_chart.dart';

import 'widget_transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model_transaction.dart';
import 'widget_new_transaction.dart';

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool textFields = false;

  @override
  Widget build(BuildContext context) {
    final Transactions transactions = Provider.of<Transactions>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Expenses'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 0),
            child: MaterialButton(
              color: Theme.of(context).accentColor,
              onPressed: () => setState(() {
                textFields = !textFields;
              }),
              child: textFields
                  ? Icon(Icons.close)
                  : Icon(Icons.table_chart),
              minWidth: 50,
              height: 50,
              shape: CircleBorder(),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 80,
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (anotherContext) {
                return WidgetNewTransaction(_scaffoldKey);
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
