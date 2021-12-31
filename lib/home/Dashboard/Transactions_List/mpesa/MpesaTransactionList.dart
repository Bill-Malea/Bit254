import 'package:bit254/Utilities/colors.dart';
import 'package:bit254/home/Dashboard/Transactions_List/mpesa/provider_mpesatransactionlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MpesaTransactionList extends StatefulWidget {
  @override
  _MpesaTransactionListState createState() => _MpesaTransactionListState();
}

class _MpesaTransactionListState extends State<MpesaTransactionList> {
  @override
  Widget build(BuildContext context) {
    List<MpesaTransaction> _transactions = Provider.of<Mpesatransactionlist>(
      context,
    ).mpestransactionlist;
 print(_transactions);
    return ListView.builder(
        itemCount: _transactions.length,
        itemBuilder: (ctx, index) {
          final _day = _transactions[index].date.substring(6, 8);
          String _getmonth() {
            final month = _transactions[index].date.substring(4, 6);
            if (month == '01') {
              return 'Jan';
            } else if (month == '02') {
              return 'Feb';
            } else if (month == '03') {
              return 'Mar';
            } else if (month == '04') {
              return 'Apr';
            } else if (month == '05') {
              return 'May';
            } else if (month == '06') {
              return 'Jun';
            } else if (month == '07') {
              return 'Jul';
            } else if (month == '08') {
              return 'Aug';
            } else if (month == '09') {
              return 'Sep';
            } else if (month == '10') {
              return 'Oct';
            } else if (month == '11') {
              return 'Nov';
            } else
              return 'Dec';
          }

          final _year = _transactions[index].date.substring(0, 4);
          final _time = _transactions[index].date.substring(8, 10) +
              ':' +
              _transactions[index].date.substring(10, 12); 
          return Container(
            padding: EdgeInsets.only(left: 10, top: 20, right: 10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.arrow_downward_outlined,
                      size: 10,
                    ),
                    Text(
                      ' Deposit :  ',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Text(
                      _transactions[index].amount,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                    'Deposit :'
                          +
                              '$_day ${_getmonth()},' +
                              '$_year ' +
                              '|' +
                              '$_time',
                      style: TextStyle(
                        color: kCaptionColor,
                        fontSize: 12,
                      ),
                    ),
                    _transactions[index].statuscode == '0'
                        ? Row(
                            children: <Widget>[
                              Icon(
                                Icons.check,
                                size: 12,
                                color: Colors.green,
                              ),
                              Text(
                                ' Completed',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: <Widget>[
                              Icon(
                                Icons.close,
                                size: 12,
                                color: Colors.red,
                              ),
                              Text(
                                ' Failed',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
                Divider(
                  color: Color.fromRGBO(97, 99, 119, 1),
                ),
              ],
            ),
          );
        });
  }
}
