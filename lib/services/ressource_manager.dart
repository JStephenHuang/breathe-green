import 'package:flutter/material.dart';

class AvatarObject {
  AssetImage avatar;
  String lvl;
  int requiredPoints;

  AvatarObject(
      {required this.avatar, required this.lvl, required this.requiredPoints});
}

class RessourceManager {
  AssetImage getUserAvatar(String avatar) {
    return AssetImage("assets/tree_$avatar.png");
  }

  List<AvatarObject> getAvatars() {
    String path = "assets/tree_";
    return [
      AvatarObject(
        avatar: AssetImage("${path}lvl1.png"),
        lvl: "lvl1",
        requiredPoints: 0,
      ),
      AvatarObject(
        avatar: AssetImage("${path}lvl2.png"),
        lvl: "lvl2",
        requiredPoints: 100,
      ),
      AvatarObject(
        avatar: AssetImage("${path}lvl3.png"),
        lvl: "lvl3",
        requiredPoints: 200,
      ),
      AvatarObject(
        avatar: AssetImage("${path}lvl4.png"),
        lvl: "lvl4",
        requiredPoints: 500,
      ),
      AvatarObject(
        avatar: AssetImage("${path}lvl5.png"),
        lvl: "lvl5",
        requiredPoints: 700,
      ),
      AvatarObject(
        avatar: AssetImage("${path}lvl6.png"),
        lvl: "lvl6",
        requiredPoints: 1000,
      )
    ];
  }
}
