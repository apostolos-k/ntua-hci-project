import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_car_wallet/db_handler.dart';
import '../models/photo.dart';
import 'dart:async';
import '../utils.dart';
import './Utility.dart';

class DriverLisenceScreen extends StatefulWidget {
  const DriverLisenceScreen({super.key});

  @override
  State<DriverLisenceScreen> createState() => _DriverLisenceScreen();
}

class _DriverLisenceScreen extends State<DriverLisenceScreen> {
  Future<File>? imageFile;
  Image? image;
  DBHelper? dbHelper;
  List<Photo>? images;

  @override
  void initState() {
    super.initState();
    images = [];
    dbHelper = DBHelper();
    refreshImages();
  }

  refreshImages() {
    dbHelper?.getPhotosL().then((imgs) {
      setState(() {
        images?.clear();
        images?.addAll(imgs);
      });
    });
  }

  pickImageFromGallery() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((imgFile) async {
      if (imgFile != null) {
        String imgString = Utility.base64String(await imgFile.readAsBytes());
        dbHelper!.saveL(Photo(photoName: imgString));
        refreshImages();
      } else {
        return;
      }
    });
  }

  pickImageFromCamera() {
    ImagePicker().pickImage(source: ImageSource.camera).then((imgFile) async {
      if (imgFile != null) {
        String imgString = Utility.base64String(await imgFile.readAsBytes());
        dbHelper!.saveL(Photo(photoName: imgString));
        refreshImages();
      } else {
        return;
      }
    });
  }

  gridView() {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: images!.map((photo) {
          return Utility.imageFromBase64String(photo.photoName);
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: EdgeInsets.all(32),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Flexible(
            child: gridView(),
          ),
          Align(
            alignment: Alignment.center,
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 15,
              children: [
                ElevatedButton.icon(
                    icon: const Icon(Icons.photo),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(
                          255, 190, 190, 190), // Background color
                    ),
                    onPressed: () {
                      pickImageFromGallery();
                    },
                    label: const Text('Gallery')),
                ElevatedButton.icon(
                    icon: const Icon(Icons.camera),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(
                          255, 190, 190, 190), // Background color
                    ),
                    onPressed: () {
                      pickImageFromCamera();
                    },
                    label: const Text('Camera')),
              ],
            ),
          ),
          ElevatedButton.icon(
              icon: const Icon(Icons.delete_forever),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Background color
              ),
              onPressed: () {
                dbHelper!.deletePhotoL();
                refreshImages();
              },
              label: const Text('Delete All'))
        ]),
      ),
    );
  }
}
