import 'package:flutter/material.dart';
import 'package:my_car_wallet/pages/calendar-screen.dart';
import 'package:my_car_wallet/pages/showevents.dart';
import '../db_handler.dart';
import 'app.dart';
import 'package:my_car_wallet/utils.dart';
import 'package:intl/intl.dart';
import 'package:my_car_wallet/models/event.dart';

class AddEvent extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? selectedDate;
  int? myeventId;
  String? myeventDate;
  String? myeventName;
  String? myeventCar;
  String? myeventContact;
  String? myeventLocation;
  String? myeventDescription;
  bool? update;

  AddEvent(
      {required this.firstDate,
      required this.lastDate,
      this.selectedDate,
      this.myeventId,
      this.myeventDate,
      this.myeventName,
      this.myeventCar,
      this.myeventContact,
      this.myeventLocation,
      this.myeventDescription,
      this.update});

  @override
  State<AddEvent> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEvent> {
  DBHelper? dbHelper;
  late Future<List<EventModel>> datalist;

  late DateTime _selectedDate;
  final _formkey = GlobalKey<FormState>();
  late String SelectedDay;
  late TextEditingController dateInput =
      TextEditingController(text: widget.myeventDate);
  late TextEditingController _displayNameController =
      TextEditingController(text: widget.myeventName);
  late TextEditingController _carController =
      TextEditingController(text: widget.myeventCar);
  late TextEditingController _contactInfoController =
      TextEditingController(text: widget.myeventContact);
  late TextEditingController _locationController =
      TextEditingController(text: widget.myeventLocation);
  late TextEditingController _descriptionController =
      TextEditingController(text: widget.myeventDescription);

  late TimeOfDay? _alarmTime;
  bool _visiblealarmTime = true;

  void _show() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (result != null) {
      setState(() {
        _alarmTime = result;
        _visiblealarmTime = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _alarmTime = TimeOfDay.now();
    _selectedDate = widget.selectedDate ?? DateTime.now();
    SelectedDay = DateFormat('yyyy-MM-dd').format(_selectedDate);
    dateInput.text = SelectedDay;
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    datalist = dbHelper!.getDataListEvent();
  }

  @override
  Widget build(BuildContext context) {
    double heightBase = MediaQuery.of(context).size.height;
    double widthBase = MediaQuery.of(context).size.width;
    String appTitle;
    if (widget.update == true) {
      appTitle = "Update an Event";
    } else {
      appTitle = "Add an Event";
    }

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
        body: Form(
          key: _formkey,
          child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                reverse: true,
                child: Wrap(
                  spacing: 0.01 * heightBase,
                  direction: Axis.vertical,
                  //textDirection: TextDirection.ltr,
                  children: [
                    Text(appTitle,
                        style: SafeGoogleFont('Sen',
                            fontSize: 2.5 * heightBase * 0.01,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff000000))),
                    Container(
                      padding: EdgeInsets.all(0.01 * heightBase),
                      height: 0.7 * heightBase,
                      width: 0.9 * widthBase,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 190, 190, 190),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(1.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                  child: TextField(
                                controller: dateInput,
                                //editing controller of this TextField
                                decoration: InputDecoration(
                                    icon: Icon(Icons
                                        .calendar_today), //icon of text field
                                    labelText:
                                        "Enter Date" //label text of field
                                    ),
                                readOnly: true,
                                //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime(2023),
                                      firstDate: DateTime(2010),
                                      //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2050));

                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                    print(
                                        formattedDate); //formatted date output using intl package =>  2021-03-16
                                    setState(() {
                                      dateInput.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {}
                                },
                              ))),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.all(2.0),
                              child: Row(children: <Widget>[
                                IconButton(
                                  onPressed: _show,
                                  icon: Icon(Icons.notifications),
                                  tooltip: ('Add Reminder'),
                                ),
                                Visibility(
                                    visible: _visiblealarmTime,
                                    child: Text(_alarmTime != null
                                        ? _alarmTime!.format(context)
                                        : "")),
                                Visibility(
                                    visible: _visiblealarmTime,
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _alarmTime = null;
                                            _visiblealarmTime = false;
                                          });
                                        },
                                        icon: Icon(Icons.cancel))),
                              ])),
                          TextFormField(
                              controller: _displayNameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Display Name',
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(20.0))),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Required!";
                                }
                                return null;
                              }),
                          TextFormField(
                              controller: _carController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Car',
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(20.0))),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Required!";
                                }
                                return null;
                              }),
                          TextFormField(
                            controller: _contactInfoController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Contact Info',
                              border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(20.0))),
                            ),
                          ),
                          TextFormField(
                            controller: _locationController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Location',
                              border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(20.0))),
                            ),
                          ),
                          TextFormField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Description',
                              border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(20.0))),
                            ),
                            maxLines: 4,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom))
                  ],
                ),
              )),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (_formkey.currentState!.validate()) {
              if (widget.update == true) {
                dbHelper!.updateEvent(EventModel(
                  id: widget.myeventId,
                  date: dateInput.text,
                  displayName: _displayNameController.text,
                  car: _carController.text,
                  contactInfo: _contactInfoController.text,
                  location: _locationController.text,
                  description: _descriptionController.text,
                  alarmTime: _alarmTime,
                ));
              } else {
                dbHelper!.insertEvent(EventModel(
                  date: dateInput.text,
                  displayName: _displayNameController.text,
                  car: _carController.text,
                  contactInfo: _contactInfoController.text,
                  location: _locationController.text,
                  description: _descriptionController.text,
                  alarmTime: _alarmTime,
                ));
              }
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainPageState()));
            }
            ;
          },
          elevation: 10,
          label: const Text('Save'),
          icon: const Icon(Icons.save),
          backgroundColor: Color.fromARGB(255, 190, 190, 190),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
