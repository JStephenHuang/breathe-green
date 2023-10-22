import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../services/firebase_storage.dart';
import '../../services/firestore.dart';

class Uploader extends StatefulWidget {
  final File file;

  const Uploader({required this.file, super.key});

  @override
  State<Uploader> createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  UploadTask? _uploadTask;
  bool uploadComplete = false;
  String? path;

  void _startUpload() {
    String filePath = "images/${const Uuid().v4()}.png";

    setState(() {
      _uploadTask = FirebaseStorageService().startUpload(filePath, widget.file);
      path = filePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isSmallPhone = size.width <= 320;
    if (_uploadTask == null) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: ElevatedButton(
          onPressed: _startUpload,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: EdgeInsets.all(
              isSmallPhone ? 15 : 20,
            ),
            backgroundColor: Colors.green[800],
          ),
          child: Icon(
            FontAwesomeIcons.locationDot,
            color: Colors.white,
            size: isSmallPhone ? 20 : 30,
          ),
        ),
      );
    }

    return StreamBuilder<TaskSnapshot>(
        stream: _uploadTask!.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              )),
            );
          } else if (snapshot.hasData) {
            TaskSnapshot? event = snapshot.data;
            double progressPercent =
                event != null ? event.bytesTransferred / event.totalBytes : 0;

            if (event != null && event.state == TaskState.success) {
              return FutureBuilder(
                  future:
                      FirestoreService().pinTree(path, _uploadTask, context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                            child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                        )),
                      );
                    } else if (snapshot.hasData) {
                      if (snapshot.data == null) {
                        return const Text("Something went wrong");
                      } else if (snapshot.data == "Success") {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                              child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.green),
                          )),
                        );
                      } else {
                        return const Text("Something went wrong");
                      }
                    } else {
                      return const Text("Something went wrong");
                    }
                  });
            } else {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Transform.scale(
                      scale: isSmallPhone ? 1.5 : 2.5,
                      child: CircularProgressIndicator(
                        value: progressPercent,
                        color: Colors.green[400],
                      )),
                  if (event != null && event.state == TaskState.paused)
                    ElevatedButton(
                      onPressed: _uploadTask!.resume,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(), //<-- SEE HERE
                        padding: EdgeInsets.all(
                          isSmallPhone ? 15 : 20,
                        ),
                        backgroundColor: Colors.green[800],
                      ),
                      child: Icon(
                        FontAwesomeIcons.play,
                        color: Colors.white,
                        size: isSmallPhone ? 20 : 30,
                      ),
                    ),
                  if (event != null && event.state == TaskState.running)
                    ElevatedButton(
                      onPressed: _uploadTask!.pause,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(), //<-- SEE HERE
                        padding: EdgeInsets.all(
                          isSmallPhone ? 15 : 20,
                        ),
                        backgroundColor: Colors.green[800],
                      ),
                      child: Icon(
                        FontAwesomeIcons.pause,
                        color: Colors.white,
                        size: isSmallPhone ? 20 : 30,
                      ),
                    ),
                ],
              );
            }
          } else {
            return Container();
          }
        });
  }
}
