import 'package:bit254/Signup/signinpage.dart';
import 'package:bit254/Utilities/colors.dart';
import 'package:bit254/home/Dashboard/Transactions_List/mpesa/provider_mpesatransactionlist.dart';
import 'package:bit254/home/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'Screens/Menu/Widgets/Pascode.dart';
import 'home/Dashboard/Provider/Fundwallet_provider.dart';
import 'home/Dashboard/Receive.dart';
import 'home/Dashboard/Transactions_List/BTC/provider_bitcointransactions.dart';
import 'home/Dashboard/Transactions_List/ETHERIUM/Etheriumtransactio_list.dart';
import 'home/Restore_wallet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _prefs = GetStorage();
    final _uid = FirebaseAuth.instance.currentUser!.uid;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => FundwalletProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Mpesatransactionlist(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => BTCProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ETHProvider(),
        ),
      ],
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          //  allowFontScaling: true,
          builder: () {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "BIT 254",
              themeMode: ThemeMode.dark,
              darkTheme: ThemeData(
                visualDensity: VisualDensity.adaptivePlatformDensity,
                textTheme: GoogleFonts.poppinsTextTheme().copyWith(
                  caption: const TextStyle(
                    color: kCaptionColor,
                    fontSize: 16.0,
                  ),
                ),
                iconTheme: const IconThemeData(
                  color: kSuccessColor,
                  size: 20,
                ),
                scaffoldBackgroundColor: kPrimaryColor,
                appBarTheme: AppBarTheme(
                  elevation: 1.0,
                  color: kPrimaryColor,
                ),
              ),
              home: StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (ctx, userSnapshot) {
                    var _wallet = _prefs.read('wallet$_uid');

                    if (userSnapshot.hasData && _wallet == true) {
                      return Passcode();
                    } else if (userSnapshot.hasData && _wallet == null) {
                      return CreateWallet();
                    } else if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return AlertDialog(
                        actions: <Widget>[
                          Container(
                            margin: EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircularProgressIndicator(
                                  backgroundColor: Colors.transparent,
                                  strokeWidth: 2.0,
                                  color: kSuccessColor,
                                ),
                                SizedBox(width: 15),
                                Text('Please wait...'),
                              ],
                            ),
                          ),
                        ],
                      );
                      ;
                    }
                    return AuthScreen();
                  }),
            );
          }),
    );
  }
}
