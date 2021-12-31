import 'package:flutter/material.dart';
import 'package:bit254/Utilities/colors.dart';

class Notifications extends StatefulWidget {
  Notifications({
    Key? key,
  }) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Notifications',
        ),
      ),
      body: Center(
        child: Text(
          'Your Notifications will appear here',
          style: TextStyle(
            color: kCaptionColor,
          ),
        ),
      ),
    );
  }
}
