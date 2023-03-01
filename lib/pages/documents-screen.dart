import 'package:flutter/material.dart';
import 'package:my_car_wallet/pages/driverlisence-screen.dart';
import 'package:my_car_wallet/pages/carinsurance-screen.dart';
import 'package:my_car_wallet/pages/kteo-screen.dart';
import 'package:my_car_wallet/pages/ecc-screen.dart';
import 'package:my_car_wallet/pages/vehiclefees-screen.dart';
import 'package:my_car_wallet/pages/carregistration-screen.dart';
import 'package:my_car_wallet/utils.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double heightBase = MediaQuery.of(context).size.height;
    double widthBase = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(
            left: 0.05 * widthBase,
            right: 0.05 * widthBase,
            top: 0.01 * heightBase),
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 0.05 * heightBase,
          textDirection: TextDirection.ltr,
          children: [
            Text('Select your document!',
                style: SafeGoogleFont('Sen',
                    fontSize: 2.4 * heightBase * 0.01,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff000000))),
            SizedBox(height: 0.05 * heightBase),
            Align(
              alignment: Alignment.center,
              child: Wrap(
                direction: Axis.vertical,
                spacing: 0.02 * heightBase,
                children: [
                  Wrap(
                    spacing: 0.05 * widthBase,
                    direction: Axis.horizontal,
                    children: [
                      Container(
                        height: 0.2 * heightBase,
                        width: 0.4 * widthBase,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 190, 190, 190),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DriverLisenceScreen()),
                              );
                            },
                            child: Text('Driving\nLicense',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont(
                                  'Sen',
                                  fontSize: 2.5 * heightBase * 0.01,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff000000),
                                )),
                          ),
                        ),
                      ),
                      Container(
                        height: 0.2 * heightBase,
                        width: 0.4 * widthBase,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 190, 190, 190),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => KteoScreen()),
                            );
                          },
                          child: Text('KTEO',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'Sen',
                                fontSize: 2.5 * heightBase * 0.01,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff000000),
                              )),
                        )),
                      )
                    ],
                  ),
                  Wrap(
                    spacing: 0.05 * widthBase,
                    direction: Axis.horizontal,
                    children: [
                      Container(
                          height: 0.2 * heightBase,
                          width: 0.4 * widthBase,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 190, 190, 190),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CarInsuranceScreen()),
                                );
                              },
                              child: Text('Car\nInsurance',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont(
                                    'Sen',
                                    fontSize: 2.5 * heightBase * 0.01,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff000000),
                                  )),
                            ),
                          )),
                      Container(
                          height: 0.2 * heightBase,
                          width: 0.4 * widthBase,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 190, 190, 190),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ECCScreen()),
                                );
                              },
                              child: Text('Exhaust\nControl\nCard',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont(
                                    'Sen',
                                    fontSize: 2.5 * heightBase * 0.01,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff000000),
                                  )),
                            ),
                          ))
                    ],
                  ),
                  Wrap(
                    spacing: 0.05 * widthBase,
                    direction: Axis.horizontal,
                    children: [
                      Container(
                          height: 0.2 * heightBase,
                          width: 0.4 * widthBase,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 190, 190, 190),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          VehicleFeesScreen()),
                                );
                              },
                              child: Text('Vehicle\nFees',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont(
                                    'Sen',
                                    fontSize: 2.5 * heightBase * 0.01,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff000000),
                                  )),
                            ),
                          )),
                      Container(
                          height: 0.2 * heightBase,
                          width: 0.4 * widthBase,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 190, 190, 190),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CarRegistrationScreen()),
                                );
                              },
                              child: Text('Car\nRegistration',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont(
                                    'Sen',
                                    fontSize: 2.5 * heightBase * 0.01,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff000000),
                                  )),
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
