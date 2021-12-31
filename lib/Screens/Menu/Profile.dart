import 'package:bit254/Utilities/colors.dart';
import 'package:bit254/Utilities/adaptive_size.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String name;
  final String number;
  final String email;
  final String pin;
  Profile(this.name, this.number, this.email, this.pin);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40.0.h,
          ),
          Center(
            child: Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                border: Border.all(
                  color: kSuccessColor,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.person_pin,
                size: 80,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: Color.fromRGBO(55, 66, 92, 0.4),
              child: Container(
                padding: EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Name(name: name),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Divider(
                        color: Color.fromRGBO(97, 99, 119, 1),
                      ),
                    ),
                    Name(
                      name: email,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Divider(
                        color: Color.fromRGBO(97, 99, 119, 1),
                      ),
                    ),
                    Name(
                      name: number,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Divider(
                        color: Color.fromRGBO(97, 99, 119, 1),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Update Details',
                              style: TextStyle(
                                color: kSuccessColor,
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Name extends StatelessWidget {
  const Name({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, top: 10.0),
      child: Text(
        name,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }
}
