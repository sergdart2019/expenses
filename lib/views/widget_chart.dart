import 'package:expenses/models/model_transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class WidgetChart extends StatefulWidget {
  @override
  _WidgetChartState createState() => _WidgetChartState();
}

class _WidgetChartState extends State<WidgetChart> {
  /// You can also use FractionallySizedBox(heightFactor: , child: Container()...)
  /// for the ChartBars, inside the Stack widget...
  /// FittedBox() shrinks the Text...
  int maxValue = 1000;

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return NumberPickerDialog.integer(
            minValue: 10,
            maxValue: 10000,
            step: 10,
            title: Text("Pick a new price"),
            initialIntegerValue: maxValue,
          );
        }).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        maxValue = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Transactions transactions = Provider.of<Transactions>(context);
    Orientation orientation = MediaQuery.of(context).orientation;
    List<Map<String, dynamic>> groupedTransactions = List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        double totalSum = 0.0;
        transactions.transactions.forEach((value) {
          if (value.date.day == weekDay.day &&
              value.date.month == weekDay.month &&
              value.date.year == weekDay.year) {
            totalSum += value.amount;
          }
        });
        return {
          'day': DateFormat('E').format(weekDay),
          'amount': totalSum,
        };
      },
    ).reversed.toList();
    // print(groupedTransactions);
    /*
    [
      {day: Wed, amount: 14.0},
      {day: Thu, amount: 720.0},
      {day: Fri, amount: 900.0},
      {day: Sat, amount: 1100.0},
      {day: Sun, amount: 50.17},
      {day: Mon, amount: 150.22},
      {day: Tue, amount: 245.66000000000003}
    ]
     */
    return orientation == Orientation.portrait
        // Vertical orientation
        ? Container(
            height: 180,
            child: Card(
              child: Container(
                padding: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Chart
                    chart(groupedTransactions),
                    // Button maxValue adjustment
                    buttonAdjustment(orientation)
                  ],
                ),
              ),
            ),
          )
        // Horizontal orientation
        : Container(
            height: 130,
            child: Card(
              child: Container(
                padding: EdgeInsets.only(top: 10, left: 20, right: 5, bottom: 10),
                child: Row(
                  children: <Widget>[
                    // Chart
                    Expanded(
                      child: chart(groupedTransactions),
                    ),
                    // Button maxValue adjustment
                    buttonAdjustment(orientation),
                  ],
                ),
              ),
            ),
          );
  }

  Widget chart(List<Map<String, dynamic>> groupedTransactions) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: groupedTransactions
          .map(
            (transaction) => Container(
              width: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  /// Can use FittedBox here, to shrink the text
                  Text(
                    '\$${transaction['amount'].toStringAsFixed(0)}',
                    overflow: TextOverflow.ellipsis, // instead of FittedBox
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  Container(
                    height: 70,
                    width: 15,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.grey[700]),
                        color: transaction['amount'] > maxValue
                            ? Colors.redAccent[400]
                            : null,
                        gradient: transaction['amount'] > maxValue
                            ? null
                            : LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                    Colors.lightGreenAccent,
                                    Colors.lightGreenAccent,
                                    Colors.transparent,
                                    Colors.grey[700],
                                    Colors.grey[700],
                                  ],
                                stops: [
                                    0.0,
                                    transaction['amount'] / maxValue - 0.001,
                                    transaction['amount'] / maxValue,
                                    transaction['amount'] / maxValue + 0.001,
                                    1.0,
                                  ]),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  Text(
                    transaction['day'],
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget buttonAdjustment(Orientation orientation) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 30, right: 10),
      child: orientation == Orientation.landscape
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Text(
                    'Maximum value:\n\$$maxValue',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  height: 40,
                  onPressed: () => _showDialog(context),
                  color: Theme.of(context).accentColor,
                  child: Icon(Icons.edit, size: 20),
                  shape: CircleBorder(),
                ),
              ],
            )
          // Vertical orientation
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    'Maximum value:\$$maxValue',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  height: 40,
                  onPressed: () => _showDialog(context),
                  color: Theme.of(context).accentColor,
                  child: Icon(Icons.edit, size: 20),
                  shape: CircleBorder(),
                )
              ],
            ),
    );
  }
}
