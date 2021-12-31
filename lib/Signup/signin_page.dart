import 'dart:async';
import 'package:bit254/Signup/widgets/FormInputField.dart';
import 'package:bit254/Utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'widgets/bezier.dart';

class AuthScreen1 extends StatefulWidget {
  @override
  _AuthScreen1State createState() => _AuthScreen1State();
}

class _AuthScreen1State extends State<AuthScreen1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _username = new TextEditingController();
  final TextEditingController _phonenumber = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _username.dispose();
    _phonenumber.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  final _auth = FirebaseAuth.instance;

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
    String _email,
    String _password,
    String _username,
    String _phone,
    bool _isLogin,
    BuildContext _ctx,
  ) async {
    UserCredential userCredential;

    GetStorage _prefs = GetStorage();

    try {
      setState(() {
        _isLoading = true;
      });
      if (_isLogin) {
        userCredential = await _auth
            .signInWithEmailAndPassword(email: _email, password: _password)
            .catchError((onError) => _showErrorDialog(onError.toString()));
      } else {
        userCredential = await _auth
            .createUserWithEmailAndPassword(
              email: _email,
              password: _password,
            )
            .catchError((onError) => _showErrorDialog(onError.toString()));

        var uid = userCredential.user!.uid;
        await _prefs.write('phone$uid', _phone);
        await _prefs.write('username$uid', _username);
        await _prefs.write('email$uid', _email);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'username': _username,
          'email': _email,
          'phone': _phone,
        });
      }
    } on PlatformException catch (errr) {
      setState(() {
        _isLoading = false;
        print(errr.toString());
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
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
                      _formKey,
                      _email,
                      _password,
                      _username,
                      _phonenumber,
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
    this._formKey,
    this.email,
    this.password,
    this.username,
    this.phonenumber,
  );

  final bool isLoading;
  final GlobalKey<FormState> _formKey;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController username;
  final TextEditingController phonenumber;
  final void Function(
    String email,
    String password,
    String userName,
    String userPhone,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _isLogin = true;

  void _trySubmit() {
    final isValid = widget._formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      widget._formKey.currentState!.save();
      widget.submitFn(
        widget.email.text.trim(),
        widget.phonenumber.text.trim(),
        widget.password.text.trim(),
        widget.username.text.trim(),
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
        margin: EdgeInsets.symmetric(vertical: 20),
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
            key: widget._formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FormInputFieldWithIcon(
                  labelText: 'Email',
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address.';
                    }
                    return '';
                  },
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => widget.email.text = value!,
                ),
                SizedBox(height: 7),
                FormInputFieldWithIcon(
                  labelText: 'Password',
                  validator: (value) {
                    if (value!.isEmpty || value.length < 8) {
                      return 'Password must be at least 8 characters long.';
                    }
                    return null;
                  },
                  obscureText: true,
                  onSaved: (value) => widget.phonenumber.text = value!,
                ),
                SizedBox(height: 7),
                if (!_isLogin)
                  FormInputFieldWithIcon(
                    labelText: 'Confirm Password',
                    validator: (value) {
                      if (value!.isEmpty || value.length < 8) {
                        return 'Password must be at least 8 characters long.';
                      }
                      return null;
                    },
                    obscureText: true,
                    onSaved: (value) => widget.password.text = value!,
                  ),
                SizedBox(height: 7),
                if (!_isLogin)
                  FormInputFieldWithIcon(
                    labelText: 'Username',
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return 'Please enter at least 4 characters';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) => widget.phonenumber.text = value!,
                  ),
                SizedBox(height: 7),
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
                    onSaved: (value) => widget.phonenumber.text = value!,
                  ),
                SizedBox(height: 7),
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
