import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class CaputreImageButton extends StatelessWidget {
  final void Function() pickImage;

  const CaputreImageButton({required this.pickImage, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickImage,
      child: Container(
        margin:
            const EdgeInsetsDirectional.symmetric(horizontal: 30, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)),
        ),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Icon(
                    IconlyLight.image,
                    size: 150,
                  ),
                ),
                Text(
                  "CLICK TO CAPTURE A TREE",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
