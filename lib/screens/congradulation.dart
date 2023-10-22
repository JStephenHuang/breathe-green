import 'package:breathe_green_final/widgets/arrow_left.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class CongradulationScreen extends StatelessWidget {
  const CongradulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isSmallPhone = size.width <= 320;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Expanded(
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [ArrowLeft()],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Column(
                      children: [
                        Text(
                          "🎉",
                          style: TextStyle(fontSize: 75),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Congradulations!",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Your tree location successfully pinned, it will be eligible for review. We will notify you if ever you're pin is approuved or rejected.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(), //<-- SEE HERE
                                  padding:
                                      EdgeInsets.all(isSmallPhone ? 15 : 20),
                                  backgroundColor: Colors.green[800],
                                ),
                                child: Icon(
                                  IconlyBold.home,
                                  size: isSmallPhone ? 15 : 30,
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Go back home",
                              style:
                                  TextStyle(fontSize: isSmallPhone ? 14 : 18),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                                onPressed: () => Navigator.pushReplacementNamed(
                                    context, "/pin-a-tree"),
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(), //<-- SEE HERE
                                  padding:
                                      EdgeInsets.all(isSmallPhone ? 15 : 20),
                                  backgroundColor: Colors.green[800],
                                ),
                                child: Icon(
                                  IconlyBold.location,
                                  size: isSmallPhone ? 15 : 30,
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Pin another tree",
                              style:
                                  TextStyle(fontSize: isSmallPhone ? 14 : 18),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
