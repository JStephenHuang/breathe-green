import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final IconData icon;
  final Widget page;

  const CircularButton({required this.icon, required this.page, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool smallPhone = size.width <= 320;
    return ElevatedButton(
      onPressed: () => showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10.0),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).copyWith().size.height * 0.75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: page,
                )
              ],
            ),
          );
        },
      ),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(), //<-- SEE HERE
        padding: EdgeInsets.all(smallPhone ? 15 : 20),
        backgroundColor: Colors.green[700],
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: smallPhone ? 20 : 30,
      ),
    );
  }
}
