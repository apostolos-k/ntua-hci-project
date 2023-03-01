import 'package:flutter/material.dart';
import '../db_handler.dart';
import 'package:my_car_wallet/utils.dart';
import 'package:my_car_wallet/models/event.dart';
import 'addevent-screen.dart';
import 'dart:ui' as ui;

class ShowEvent extends StatefulWidget {
  const ShowEvent({super.key});

  @override
  State<ShowEvent> createState() => _ShowEventScreenState();
}

class _ShowEventScreenState extends State<ShowEvent> {
  DBHelper? dbHelper;
  late Future<List<EventModel>> datalistEvent;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    datalistEvent = dbHelper!.getDataListEvent();
  }

  @override
  Widget build(BuildContext context) {
    double heightBase = MediaQuery.of(context).size.height;
    double widthBase = MediaQuery.of(context).size.width;
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
                onPressed: () {
                  Navigator.of(context).pop();
                },
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
        body: Container(
          margin: EdgeInsets.only(
              top: 0.01 * heightBase,
              bottom: 0.1 * heightBase,
              right: 0.05 * widthBase,
              left: 0.05 * widthBase),
          child: Wrap(
              spacing: 0.02 * heightBase,
              direction: Axis.vertical,
              textDirection: ui.TextDirection.ltr,
              children: [
                Padding(
                  padding: EdgeInsets.all(0.005 * heightBase),
                  child: Text(
                    'Lets take a look at your events!',
                    style: SafeGoogleFont(
                      'Sen',
                      fontSize: 2.5 * heightBase * 0.01,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Container(
                  height: 0.6 * heightBase,
                  width: 0.9 * widthBase,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 190, 190, 190),
                      borderRadius: BorderRadius.circular(20)),
                  child: FutureBuilder(
                    future: datalistEvent,
                    builder:
                        (context, AsyncSnapshot<List<EventModel>> snapshot) {
                      if (!snapshot.hasData || snapshot.data == null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.data!.length == 0) {
                        return Center(child: Text('You are all caught up!'));
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            int myeventId = snapshot.data![index].id!.toInt();
                            String myeventName =
                                snapshot.data![index].displayName.toString();
                            String myeventDate =
                                snapshot.data![index].date.toString();
                            String myeventCar =
                                snapshot.data![index].car.toString();
                            String myeventContact =
                                snapshot.data![index].contactInfo.toString();
                            String myeventLocation =
                                snapshot.data![index].location.toString();
                            String myeventDescription =
                                snapshot.data![index].description.toString();
                            return Dismissible(
                              key: ValueKey<int>(myeventId),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Icon(
                                    Icons.delete_forever,
                                    color: Colors.white,
                                  )),
                              onDismissed: (DismissDirection direction) {
                                setState(() {
                                  dbHelper!.deleteEvent(myeventId);
                                  datalistEvent = dbHelper!.getDataListEvent();
                                  snapshot.data!.remove(snapshot.data![index]);
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(children: [
                                  ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddEvent(
                                                  firstDate: DateTime(1990),
                                                  lastDate: DateTime(2050),
                                                  selectedDate: null,
                                                  myeventId: myeventId,
                                                  myeventDate: myeventDate,
                                                  myeventName: myeventName,
                                                  myeventCar: myeventCar,
                                                  myeventContact:
                                                      myeventContact,
                                                  myeventLocation:
                                                      myeventLocation,
                                                  myeventDescription:
                                                      myeventDescription,
                                                  update: true)));
                                      ;
                                    },
                                    contentPadding: EdgeInsets.all(10),
                                    title: Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Text(myeventName,
                                          style: SafeGoogleFont(
                                            'Sen',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          )),
                                    ),
                                    subtitle: Text(
                                        'Date: ${myeventDate}\nCar:${myeventCar}',
                                        style: SafeGoogleFont(
                                          'Sen',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w200,
                                          color: Colors.black,
                                        )),
                                  ),
                                ]),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ]),
        ),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 10,
          icon: const Icon(Icons.add),
          backgroundColor: Color.fromARGB(255, 190, 190, 190),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEvent(
                    firstDate: DateTime(1990),
                    lastDate: DateTime(2050),
                    selectedDate: null,
                  ),
                ));
          },
          label: Text('Add Event'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
