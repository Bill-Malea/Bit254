import 'dart:async';
import 'package:bit254/Signup/widgets/FormInputField.dart';
import 'package:bit254/Utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'widgets/bezier.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _auth = FirebaseAuth.instance;
  GetStorage _prefs = GetStorage();
  var _isLoading = false;

  FutureOr<UserCredential> _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
    // ignore: null_check_always_fails
    return null!;
  }

  void _submitAuthForm(
    String? email,
    String? password,
    String? firstname,
    String? lastname,
    String? phone,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential userCredential;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        userCredential = await _auth
            .signInWithEmailAndPassword(
              email: 'biltriq2@gmail.com',
              password: password!,
            )
            .catchError((onError) => _showErrorDialog(onError.toString()));
      } else {
        userCredential = await _auth
            .createUserWithEmailAndPassword(
              email: email!,
              password: password!,
            )
            .catchError((onError) => _showErrorDialog(onError.toString()));

        var uid = userCredential.user!.uid;
        await _prefs.write('phone$uid', phone);
        await _prefs.write('firstname$uid', firstname);
        await _prefs.write('lastname$uid', lastname);
        await _prefs.write('email$uid', email);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'username': firstname! + " " + lastname!,
          'email': email,
          'phone': phone,
        });
      }
    } on PlatformException catch (errr) {
      setState(() {
        _isLoading = false;
        print(errr.toString());
      });
    } catch (err) {
      print(err);
      // setState(() {
      //   _isLoading = false;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kPrimaryColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 250,
                  ),
                  Expanded(
                    child: AuthForm(
                      _submitAuthForm,
                      _isLoading,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String firstName,
    String lastName,
    String userPhone,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String? _userEmail = '';
  String? _firstName = '';
  String? _lastName = '';
  String? _userPhone = '';
  String? _userPassword = '';
  String? _userConfirmPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail!.trim(),
        _userPhone!.trim(),
        _userPassword!.trim(),
        _firstName!.trim(),
        _lastName!.trim(),
        _isLogin,
        context,
      );
    }
  }

  Widget _createAccountLabel() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();

        setState(() {
          _isLogin = !_isLogin;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: kSuccessColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _signinAccountLabel() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();

        setState(() {
          _isLogin = !_isLogin;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: kSuccessColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w200),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FormInputFieldWithIcon(
                  labelText: 'Email',
                  validator: (value) {
                    // if (value!.isEmpty || value.contains('@')) {
                    //   return 'Please enter a valid email address.';
                    // }
                    // return value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    _userEmail = value!;
                  },
                ),
                if (_isLogin) SizedBox(height: 12),
                if (!_isLogin) SizedBox(height: 7),
                FormInputFieldWithIcon(
                  labelText: 'Password',
                  validator: (value) {
                    if (value!.isEmpty || value.length < 8) {
                      return 'Password must be at least 8 characters long.';
                    }
                    return null;
                  },
                  obscureText: true,
                  onSaved: (value) {
                    _userPassword = value!;
                  },
                ),
                if (!_isLogin) SizedBox(height: 7),
                if (!_isLogin)
                  Row(
                    children: [
                      Container(
                        width: 150,
                        child: FormInputFieldWithIcon(
                          labelText: 'First Name',
                          validator: (value) {
                            if (value!.isEmpty || value.length < 4) {
                              return 'Please enter at least 4 characters';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) {
                            _firstName = value!;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 120,
                        child: FormInputFieldWithIcon(
                          labelText: 'Last Name',
                          validator: (value) {
                            if (value!.isEmpty || value.length < 4) {
                              return 'Please enter at least 4 characters';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) {
                            _lastName = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                if (!_isLogin) SizedBox(height: 7),
                if (!_isLogin)
                  FormInputFieldWithIcon(
                    labelText: 'Phonenumber',
                    validator: (value) {
                      if (value!.isEmpty || value.length < 8) {
                        return 'Phone  must be at least 10 digits.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      _userPhone = value!;
                    },
                  ),
                if (!_isLogin) SizedBox(height: 7),
                // if (!_isLogin)
                //   FormInputFieldWithIcon(
                //     labelText: 'Confirm Password',
                //     validator: (value) {
                //       if (_userPassword.trim().toLowerCase() !=
                //           value!.trim().toLowerCase()) {
                //         return 'Passwords Do not Match.';
                //       }
                //       return null;
                //     },
                //     obscureText: true,
                //     onChanged: (value) => null,
                //     onSaved: (value) {
                //       _userConfirmPassword = value!;
                //     },
                //   ),
                SizedBox(height: 8),
                if (widget.isLoading)
                  CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    strokeWidth: 2.0,
                    color: kSuccessColor,
                  ),
                if (!widget.isLoading)
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(
                      left: 5,
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 3),
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () => _trySubmit(),
                      child: Text(
                        _isLogin ? 'Login' : 'Create Account',
                        style: TextStyle(
                          fontSize: 15,
                          color: kSuccessColor,
                        ),
                      ),
                    ),
                  ),
                if (!widget.isLoading)
                  _isLogin ? _createAccountLabel() : _signinAccountLabel(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
