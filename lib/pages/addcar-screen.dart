import 'package:flutter/material.dart';
import 'app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:my_car_wallet/utils.dart';
import 'package:my_car_wallet/pages/app.dart';
import 'package:my_car_wallet/db_handler.dart';

import '../models/car.dart';

class AddCarScreen extends StatefulWidget {
  int? mycarId;
  String? mycarName;
  String? mycarBrand;
  String? mycarModel;
  String? mycarType;
  String? mycarMiles;
  String? mycarPlate;
  bool? update;

  AddCarScreen(
      {this.mycarId,
      this.mycarName,
      this.mycarBrand,
      this.mycarModel,
      this.mycarType,
      this.mycarMiles,
      this.mycarPlate,
      this.update});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  DBHelper? dbHelper;
  late Future<List<CarModel>> datalist;

  final _fromKey = GlobalKey<FormState>();

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
    final nameController = TextEditingController(text: widget.mycarName);
    final brandController = TextEditingController(text: widget.mycarBrand);
    final modelController = TextEditingController(text: widget.mycarModel);
    final typeController = TextEditingController(text: widget.mycarType);
    final milesController = TextEditingController(text: widget.mycarMiles);
    final plateController = TextEditingController(text: widget.mycarPlate);
    String appTitle;
    if (widget.update == true) {
      appTitle = "Update your Vehicle";
    } else {
      appTitle = "Add your Vehicle";
    }

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
                  Navigator.pop(context);
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
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(
                left: 0.05 * widthBase, right: 0.05 * widthBase),
            child: SingleChildScrollView(
              reverse: true,
              child: Wrap(
                spacing: 0.025 * heightBase,
                direction: Axis.vertical,
                textDirection: TextDirection.ltr,
                children: [
                  Text(appTitle,
                      style: SafeGoogleFont('Sen',
                          fontSize: 2.5 * heightBase * 0.01,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff000000))),
                  Container(
                    padding: EdgeInsets.all(0.02 * heightBase),
                    height: 0.7 * heightBase,
                    width: 0.9 * widthBase,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 190, 190, 190),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Form(
                          key: _fromKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  controller: nameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Required!';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Display Name',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2),
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(20.0))),
                                  ),
                                ),
                              ),
                              SizedBox(height: heightBase * 0.025),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  controller: brandController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Required!';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Brand',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2),
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(20.0))),
                                  ),
                                ),
                              ),
                              SizedBox(height: heightBase * 0.025),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  controller: modelController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Required!';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Model',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2),
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(20.0))),
                                  ),
                                ),
                              ),
                              SizedBox(height: heightBase * 0.025),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  controller: typeController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Type',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2),
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(20.0))),
                                  ),
                                ),
                              ),
                              SizedBox(height: heightBase * 0.025),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  controller: milesController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Mileage',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2),
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(20.0))),
                                  ),
                                ),
                              ),
                              SizedBox(height: heightBase * 0.025),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  controller: plateController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Required!';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Plate Number',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2),
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(20.0))),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              if (_fromKey.currentState!.validate()) {
                if (widget.update == true) {
                  dbHelper!.update(CarModel(
                      id: widget.mycarId,
                      displayname: nameController.text,
                      brand: brandController.text,
                      model: modelController.text,
                      type: typeController.text,
                      mileage: milesController.text,
                      plate: plateController.text));
                } else {
                  dbHelper!.insert(CarModel(
                      displayname: nameController.text,
                      brand: brandController.text,
                      model: modelController.text,
                      type: typeController.text,
                      mileage: milesController.text,
                      plate: plateController.text));
                }

                // Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPageState()));

                nameController.clear();
                brandController.clear();
                modelController.clear();
                typeController.clear();
                milesController.clear();
                plateController.clear();

                print("Car Added!");
              }
            });
          },
          elevation: 10,
          label: const Text('Save'),
          icon: const Icon(Icons.save),
          backgroundColor: Color.fromARGB(255, 190, 190, 190),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
