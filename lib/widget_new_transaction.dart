import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'model_transaction.dart';

class WidgetNewTransaction extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  WidgetNewTransaction(this.scaffoldKey);

  @override
  _WidgetNewTransactionState createState() => _WidgetNewTransactionState();
}

class _WidgetNewTransactionState extends State<WidgetNewTransaction> {
  String _title, _amount;
  DateTime _dateTime;

  _showDatePicker() async {
    _dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime.now(),
    );
    if (_dateTime == null) {
      return;
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final Transactions transactions = Provider.of<Transactions>(context);
    return Container(
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                onChanged: (value) {
                  _title = value;
                },
                decoration: InputDecoration(labelText: 'Title', isDense: true),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) {
                    _amount = value;
                  },
                  decoration: InputDecoration(labelText: 'Amount', isDense: true),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _dateTime == null
                        ? 'day-month-year'
                        : '${DateFormat('d-MMM-yyyy').format(_dateTime)}',
                    style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).primaryColor),
                  ),
                  Container(
                    child: FlatButton(
                      child: Text(
                        'Choose Date',
                      ),
                      onPressed: () => _showDatePicker(),
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  Container(
                    child: Builder(
                      builder: (context) => RaisedButton(
                          child: Text('Submit', textAlign: TextAlign.end),
                          onPressed: () {
                            Navigator.pop(context);
                            bool isSubmitted = false;
                            isSubmitted = transactions.addTransaction(
                              title: _title,
                              amount: _amount,
                              date: _dateTime,
                            );
                            if (!isSubmitted) {
                              widget.scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Please submit all the data'),
                                duration: Duration(seconds: 1),
                              ));
                              return;
                            }
                          },
                          color: Theme.of(context).primaryColor,
                          textColor: Theme.of(context).buttonColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
