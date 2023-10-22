import 'dart:io';

import 'package:breathe_green_final/screens/loading.dart';
import 'package:breathe_green_final/services/camera.dart';
import 'package:breathe_green_final/widgets/arrow_left.dart';
import 'package:breathe_green_final/widgets/pin_a_tree_screen/capture_image_button.dart';
import 'package:breathe_green_final/widgets/pin_a_tree_screen/image_options.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../services/location.dart';
import '../services/models.dart';
import '../widgets/pin_a_tree_screen/uploader.dart';

class PinATreeScreen extends StatefulWidget {
  const PinATreeScreen({super.key});

  @override
  State<PinATreeScreen> createState() => _PinATreeScreenState();
}

class _PinATreeScreenState extends State<PinATreeScreen> {
  File? _imageFile;
  String errorMessage = "";

  void _cropImage() async {
    setState(() {
      errorMessage = "";
    });
    CroppedFile? croppedImage = await CameraService().cropImage(_imageFile);

    if (croppedImage == null) {
      setState(() {
        errorMessage = "Couldn't crop image.";
      });
    }
    if (croppedImage != null) {
      setState(() {
        _imageFile = File(croppedImage.path);
      });
    }
  }

  void _pickImage() async {
    setState(() {
      errorMessage = "";
    });

    XFile? pickedImage = await CameraService().pickImage();

    if (pickedImage == null) {
      setState(() {
        errorMessage = "Couldn't capture image.";
      });
    }
    if (pickedImage != null) {
      print(pickedImage.mimeType);

      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder(
            future: LocationService().requestLocationPermission(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingScreen();
              } else if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text(snapshot.error.toString()),
                  ),
                );
              } else if (!snapshot.hasData) {
                return const Scaffold(
                  body: Center(
                    child: Text("No data."),
                  ),
                );
              } else if (snapshot.hasData) {
                bool locationPermission = snapshot.data!;
                Size size = MediaQuery.of(context).size;
                bool isSmallPhone = size.width <= 320;
                Person person = Provider.of<Person>(context);

                return Column(
                  children: [
                    SizedBox(
                      height: isSmallPhone ? 8 : 16,
                    ),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [ArrowLeft()],
                    ),
                    const Text(
                      "PIN A TREE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 30,
                      ),
                    ),
                    if (!locationPermission) ...[
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "It seems that your location service is turned off. To be able to pin a tree, you need to enable your location services in your settings.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    if (person.dailyPinnedTreeCount >= 3) ...[
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "It appears you've hit your daily limit for pinning trees. Just a friendly reminder: you're limited to pinning a maximum of three trees per day. This limitation is in place to prevent spam and ensure security.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    if (_imageFile != null && locationPermission) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.file(
                            _imageFile!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ImageOptions(cropImage: _cropImage, clear: _clear),
                      Uploader(file: _imageFile!)
                    ],
                    if (_imageFile == null &&
                        locationPermission &&
                        person.dailyPinnedTreeCount < 3) ...[
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Click on the big square to enter your camera roll.",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Make sure to take good and appropriate images. Inappropriate images will result in a loss of points.",
                        textAlign: TextAlign.center,
                      ),
                      CaputreImageButton(pickImage: _pickImage),
                    ]
                  ],
                );
              } else {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
                return const Text('Something went wrong');
              }
            }),
      )),
    );
  }
}
