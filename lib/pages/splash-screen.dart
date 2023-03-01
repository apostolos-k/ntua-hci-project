import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:my_car_wallet/utils.dart';
import 'package:my_car_wallet/pages/app.dart';

class SplashScreeen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
        logo: Image.asset('assets/wallet.png'),
        title: Text(
          "my Car",
          style: SafeGoogleFont(
            'Sen',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            //height: 1.2025 * ffem / fem,
            color: Color(0xff1990ff),
          ),
        ),
        backgroundColor: Colors.white,
        showLoader: true,
        loadingText: Text('powered by team 70',
            style: SafeGoogleFont(
              'Shanti',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff929292),
            )),
        navigator: MainPageState(),
        durationInSeconds: 4);
  }
}
