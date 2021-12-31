import 'package:bit254/Utilities/colors.dart';
import 'package:flutter/material.dart';

class Navbutton extends StatelessWidget {
  final bool ispayment;
  final String header;
  final IconData icon;
  final Widget nav;
  Navbutton(
    this.header,
    this.icon,
    this.nav,
    this.ispayment,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => nav,
            ));
      },
      child: Card(
        color: Color.fromRGBO(55, 66, 92, 0.4),
        child: GridTile(
          footer: Container(
            margin: EdgeInsets.only(bottom: 7),
            child: Text(
              header,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: kSuccessColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
