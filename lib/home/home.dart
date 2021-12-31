import 'package:bit254/home/widgets/UserBalance.dart';
import 'package:flutter/material.dart';
import 'Dashboard/Dashboard.dart';
import 'widgets/Balance.dart';
import 'widgets/notification.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            NotificationBell(),
          ],
          leading: Container(),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(2),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 17.0,
                  ),
                  AccountBalance(),
                  SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(
                      color: Color.fromRGBO(97, 99, 119, 1),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  UserBalance(),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.amber,
                          size: 12,
                        ),
                        Text(
                          'Add Coins',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Dashboard(),
                ],
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
