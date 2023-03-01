import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_car_wallet/utils.dart';
import 'package:my_car_wallet/pages/home-screen.dart';
import 'package:my_car_wallet/pages/documents-screen.dart';
import 'package:my_car_wallet/pages/calendar-screen.dart';
import 'package:my_car_wallet/pages/maps-screen.dart';

class MainPageState extends StatefulWidget {
  const MainPageState({super.key});

  @override
  State<MainPageState> createState() => _MainPageStateState();
}

class _MainPageStateState extends State<MainPageState> {
  int currentIndex = 0;
  final screens = [
    HomeScreen(),
    CalendarScreen(),
    DocumentsScreen(),
    MapScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Color(0xfffafafa),
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          'my',
                          style: SafeGoogleFont(
                            'Sen',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff0084ff),
                          ),
                        ),
                      ),
                      Text(
                        // car1oF (203:45)
                        'Car',
                        style: SafeGoogleFont(
                          'Sen',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff0084ff),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset('assets/wallet.png',
                    fit: BoxFit.contain, height: 32)
              ]),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back),
            )
          ]),
      drawer: Drawer(
        child: Container(
            color: Colors.grey[200],
            child: ListView(
              children: [
                DrawerHeader(
                    child: Column(
                  children: const [
                    CircleAvatar(
                      radius: 50,
                    ),
                    SizedBox(height: 12),
                    Text('User'),
                  ],
                )),
                ListTile(
                    onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('About'),
                            content: const Text(
                                'This app has been developed by Team 70, for the HCI course at Ece Ntua.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        ),
                    leading: Icon(Icons.info),
                    iconColor: Color(0xff0084ff),
                    title: Text('About')),
                const Divider(color: Color.fromARGB(255, 195, 195, 195)),
                ListTile(
                    title: Text('version 1.0',
                        style: TextStyle(fontSize: 10, color: Colors.grey))),
              ],
            )),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: GNav(
        activeColor: Color(0xff0084ff),
        gap: 8,
        selectedIndex: currentIndex,
        onTabChange: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        tabs: [
          GButton(icon: Icons.car_rental, text: 'Garage'),
          GButton(icon: Icons.calendar_today, text: 'Calendar'),
          GButton(icon: Icons.file_copy_outlined, text: 'Documents'),
          GButton(icon: Icons.map, text: 'Maps')
        ],
      ),
    );
  }
}
