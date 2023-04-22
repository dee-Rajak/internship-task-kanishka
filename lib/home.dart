import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internship_task_kanishka/main.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // File? imageFile;
  LocationData? _currentPosition;
  Location location = new Location();

  fetchLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentPosition = currentLocation;
      });
    });
  }

  String imagePath = '';
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🙏 _welcome 🙏'),
        centerTitle: true,
        actions: [
          Switch(
              value: _value,
              onChanged: (value) {
                setState(() {
                  _value = value;
                  if (_value)
                    MyApp.of(context)!.changeTheme(ThemeMode.dark);
                  else
                    MyApp.of(context)!.changeTheme(ThemeMode.light);
                });
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  imagePath = await captureImage();
                  print('ImagePath:~$imagePath');
                  if (imagePath != '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Damn 😘 You look GOOD !'),
                      ),
                    );
                    setState(() {
                      fetchLocation();
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('No Image Captured !'),
                      ),
                    );
                  }
                },
                child: const Chip(
                  label: Text("Take Selfie"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (imagePath == '')
                Container(
                  child: Image.asset(
                    'assets/images/selfie.png',
                  ),
                )
              else
                Container(
                  height: 400,
                  width: 300,
                  child: Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: (_currentPosition == null) ? false : true,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Location:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // if (_currentPosition != null)
                        Text('Latitude: ${_currentPosition?.latitude}'),
                        // if (_currentPosition != null)
                        Text('Longitude: ${_currentPosition?.longitude}'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  captureImage() async {
    XFile? file = await ImagePicker().pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }
}
