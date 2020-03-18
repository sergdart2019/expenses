import 'package:provider/provider.dart';

import 'model_transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WidgetTransactionItem extends StatelessWidget {
  final Transaction transaction;
  final int index;

  WidgetTransactionItem({this.transaction, this.index});

  @override
  Widget build(BuildContext context) {
    final Transactions transactions = Provider.of<Transactions>(context);
    return Card(
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(right: 5),
        child: Row(
          children: <Widget>[
            // Amount
            Container(
              width: 100,
              child: Container(
                height: 40,
                width: 60,
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(60)),
                child: Text(
                  '\$${transaction.amount.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            // Title and Date
            Expanded(
              child: Container(
                height: 50,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transaction.title,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${DateFormat.yMMMd().format(transaction.date)}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
            // Delete Button
            MaterialButton(
              minWidth: 50,
              height: 45,
              padding: EdgeInsets.all(0),
              child: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              shape: CircleBorder(),
              onPressed: () {
                transactions.deleteTransaction(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
