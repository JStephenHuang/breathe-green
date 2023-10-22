import 'package:breathe_green_final/services/models.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import '../../services/air_quality.dart';
import 'air_quality_bubble.dart';

class InfoCard extends StatefulWidget {
  final double infoCardPosition;
  final Future<InfoCardMap> infoCardMapFuture;

  const InfoCard(
      {required this.infoCardPosition,
      required this.infoCardMapFuture,
      super.key});

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  final PageController pageController = PageController(initialPage: 0);
  int activePage = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool smallPhone = size.width <= 320;

    return AnimatedPositioned(
        bottom: (smallPhone && widget.infoCardPosition != 0)
            ? widget.infoCardPosition + 30
            : widget.infoCardPosition,
        right: 0,
        left: 0,
        duration: const Duration(milliseconds: 200),
        child: Container(
            margin: const EdgeInsets.all(8),
            height: smallPhone ? 150 : 200,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      blurRadius: 20,
                      offset: Offset.zero,
                      color: Colors.grey.withOpacity(0.5))
                ]),
            child: FutureBuilder<InfoCardMap>(
                future: widget.infoCardMapFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.connectionState == ConnectionState.none) {
                    return Center(
                        child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color?>(Colors.green[800]),
                    ));
                  } else if (!snapshot.hasData) {
                    return const Center(
                        child: Text("No data for this location."));
                  } else if (snapshot.hasData) {
                    AirQuality airQuality = snapshot.data!.airQuality;
                    Placemark markedLocation = snapshot.data!.markedLocation;
                    int aqi = airQuality.list[0].main.aqi;
                    Color color =
                        AirQualityService().airQualityInfoMap[aqi]!.color;

                    Components components = airQuality.list[0].components;
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: smallPhone ? 150 : 200,
                                    child: Text(
                                      markedLocation.street! == ""
                                          ? "No street name"
                                          : markedLocation.street!,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: smallPhone ? 150 : 200,
                                    child: Text(
                                      markedLocation.subLocality! == ""
                                          ? "No sublocality"
                                          : markedLocation.subLocality!,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[500]),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.2),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Text(
                                    AirQualityService()
                                        .airQualityInfoMap[aqi]!
                                        .rating
                                        .toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                      color: color,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: PageView(
                              controller: pageController,
                              onPageChanged: (int page) {
                                setState(() {
                                  activePage = page;
                                });
                              },
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      AirQualityBubble(
                                        gasComponent: components.no2,
                                        title: "NO2",
                                      ),
                                      AirQualityBubble(
                                        gasComponent: components.pm2_5,
                                        title: "PM2.5",
                                      ),
                                      AirQualityBubble(
                                        gasComponent: components.nh3,
                                        title: "NH3",
                                      ),
                                    ]),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    AirQualityBubble(
                                      gasComponent: components.co,
                                      title: "CO",
                                    ),
                                    AirQualityBubble(
                                      gasComponent: components.o3,
                                      title: "O3",
                                    ),
                                    AirQualityBubble(
                                      gasComponent: components.no,
                                      title: "NO",
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List<Widget>.generate(
                                  2,
                                  (index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: InkWell(
                                          onTap: () {
                                            pageController.animateToPage(index,
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                curve: Curves.easeInOut);
                                          },
                                          child: CircleAvatar(
                                            radius: 4,
                                            backgroundColor: activePage == index
                                                ? Colors.green
                                                : Colors.grey,
                                          ),
                                        ),
                                      )))
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                })));
  }
}
