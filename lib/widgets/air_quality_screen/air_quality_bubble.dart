import 'package:flutter/material.dart';

class AirQualityBubble extends StatelessWidget {
  const AirQualityBubble({
    required this.gasComponent,
    required this.title,
    super.key,
  });

  final double gasComponent;
  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool smallPhone = size.width <= 320;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: smallPhone ? 20 : 28,
          backgroundColor: Colors.grey[100],
          child: Center(
              child: Text(
            "$gasComponent",
            style:
                TextStyle(color: Colors.black, fontSize: smallPhone ? 10 : 14),
          )),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: TextStyle(fontSize: smallPhone ? 10 : 14),
        )
      ],
    );
  }
}
