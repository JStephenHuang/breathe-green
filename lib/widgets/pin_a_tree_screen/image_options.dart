import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImageOptions extends StatelessWidget {
  final void Function() cropImage;
  final void Function() clear;
  const ImageOptions({required this.cropImage, required this.clear, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isSmallPhone = size.width <= 320;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            ElevatedButton(
              onPressed: cropImage,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(), //<-- SEE HERE
                padding: EdgeInsets.all(isSmallPhone ? 12 : 20),
                backgroundColor: Colors.blue[700],
              ),
              child: Icon(
                FontAwesomeIcons.cropSimple,
                color: Colors.white,
                size: isSmallPhone ? 12 : 20,
              ),
            ),
            if (!isSmallPhone) ...[
              const SizedBox(
                height: 5,
              ),
              const Text("CROP")
            ],
          ],
        ),
        Column(
          children: [
            ElevatedButton(
              onPressed: clear,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(), //<-- SEE HERE
                padding: EdgeInsets.all(isSmallPhone ? 12 : 20),
                backgroundColor: Colors.red[700],
              ),
              child: Icon(
                FontAwesomeIcons.trash,
                color: Colors.white,
                size: isSmallPhone ? 12 : 20,
              ),
            ),
            if (!isSmallPhone) ...[
              const SizedBox(
                height: 5,
              ),
              const Text("CLEAR")
            ],
          ],
        ),
      ],
    );
  }
}
