import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_car_wallet/db_handler.dart';
import 'package:my_car_wallet/pages/addcar-screen.dart';
import 'package:my_car_wallet/utils.dart';
import '../models/car.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DBHelper? dbHelper;
  late Future<List<CarModel>> datalist;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    datalist = dbHelper!.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    double heightBase = MediaQuery.of(context).size.height;
    double widthBase = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(
                left: 0.05 * widthBase, right: 0.05 * widthBase),
            child: Wrap(
              spacing: 0.01 * heightBase,
              direction: Axis.vertical,
              textDirection: TextDirection.ltr,
              children: [
                Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
                  Text('Welcome!',
                      style: SafeGoogleFont('Sen',
                          fontSize: 3 * heightBase * 0.01,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff000000))),
                ]),
                SizedBox(
                  height: 0.01 * heightBase,
                ),
                Wrap(
                    spacing: 0.005 * heightBase,
                    direction: Axis.vertical,
                    children: [
                      Text('Cars List',
                          style: SafeGoogleFont(
                            'Sen',
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff0084ff),
                          )),
                      Container(
                        height: 0.6 * heightBase,
                        width: 0.9 * widthBase,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 190, 190, 190),
                            borderRadius: BorderRadius.circular(20)),
                        alignment: Alignment.center,
                        child: FutureBuilder(
                          future: datalist,
                          builder: (context,
                              AsyncSnapshot<List<CarModel>> snapshot) {
                            if (!snapshot.hasData || snapshot.data == null) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.data!.length == 0) {
                              return Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: -10,
                                children: [
                                  Text('Press'),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddCarScreen()),
                                      );
                                    },
                                    icon: Icon(Icons.add),
                                    iconSize: 15,
                                  ),
                                  Text('to add your first car!'),
                                ],
                              );
                            } else {
                              return ListView.builder(
                                shrinkWrap: false,
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  int mycarId =
                                      snapshot.data![index].id!.toInt();
                                  String mycarName = snapshot
                                      .data![index].displayname
                                      .toString();
                                  String mycarBrand =
                                      snapshot.data![index].brand.toString();
                                  String mycarModel =
                                      snapshot.data![index].model.toString();
                                  String mycarType =
                                      snapshot.data![index].type.toString();
                                  String mycarMiles =
                                      snapshot.data![index].mileage.toString();
                                  String mycarPlate =
                                      snapshot.data![index].plate.toString();
                                  return Dismissible(
                                    key: ValueKey<int>(mycarId),
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                        margin: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Icon(
                                          Icons.delete_forever,
                                          color: Colors.white,
                                        )),
                                    onDismissed: (DismissDirection direction) {
                                      setState(() {
                                        dbHelper!.delete(mycarId);
                                        datalist = dbHelper!.getDataList();
                                        snapshot.data!
                                            .remove(snapshot.data![index]);
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(children: [
                                        ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddCarScreen(
                                                            mycarId: mycarId,
                                                            mycarName:
                                                                mycarName,
                                                            mycarBrand:
                                                                mycarBrand,
                                                            mycarModel:
                                                                mycarModel,
                                                            mycarType:
                                                                mycarType,
                                                            mycarMiles:
                                                                mycarMiles,
                                                            mycarPlate:
                                                                mycarPlate,
                                                            update: true)));
                                          },
                                          contentPadding: EdgeInsets.all(10),
                                          title: Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Text(mycarName,
                                                style: SafeGoogleFont(
                                                  'Sen',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                )),
                                          ),
                                          subtitle: Text(
                                              'Brand: ${mycarBrand} Model: ${mycarModel}\nPlate: ${mycarPlate}',
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
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 10,
          icon: const Icon(Icons.add),
          backgroundColor: Color.fromARGB(255, 190, 190, 190),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCarScreen(),
                ));
          },
          label: Text('Add Car'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
