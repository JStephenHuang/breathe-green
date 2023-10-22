import "package:breathe_green_final/services/auth.dart";
import 'package:breathe_green_final/services/date_time.dart';
import "package:breathe_green_final/services/firebase_storage.dart";
import "package:breathe_green_final/services/location.dart";
import "package:breathe_green_final/services/models.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/cupertino.dart";
import "package:geolocator/geolocator.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import 'package:rxdart/rxdart.dart';
import "package:uuid/uuid.dart";

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ! Tree

  Future<List<Tree>> getTreesFromCurrentUser() async {
    User? user = AuthService().user;
    if (user == null) return [];
    var ref = _db.collection("trees");

    var snapshot = await ref
        .where("treeOwner", isEqualTo: user.uid)
        .orderBy("date", descending: true)
        .get();

    var data = snapshot.docs.map((d) => Tree.fromJson(d.data()));

    return data.toList();
  }

  Future<String?> pinTree(String? path, UploadTask? uploadTask, context) async {
    User? user = AuthService().user;

    if (user == null) return null;

    if (path == null) return null;

    if (uploadTask == null) return null;

    Position? position = await LocationService().determinePosition();

    if (position == null) return null;

    var v4 = const Uuid().v4();
    String id = "tree_$v4";

    var ref = _db.collection("trees").doc(id);

    String url = await FirebaseStorageService().getUrl(path);

    Tree tree = Tree(
      id: id,
      coord: Coord(lat: position.latitude, lon: position.longitude),
      imageObject: ImageObject(path: path, url: url),
      status: "Under review",
      treeOwner: user.uid,
      // date: DateFormat.yMMMEd().format(DateTime.now()),
      date: DateTime.now().toString(),
    );

    await ref.set(tree.toMap());

    await updatePerson(user.uid);

    await Navigator.pushReplacementNamed(context, "/congradulation");
    return "Success";
  }

  Future<Map<MarkerId, Marker>?> getPinnedTreesMarkersFromCurrentUser() async {
    User? user = AuthService().user;
    if (user == null) return null;
    Map<MarkerId, Marker> markers = {};

    List<Tree> pinnedTrees = await getTreesFromCurrentUser();

    for (Tree tree in pinnedTrees) {
      MarkerId markerId = MarkerId(tree.id);
      final Marker marker = Marker(
          markerId: markerId,
          position: LatLng(tree.coord.lat, tree.coord.lon),
          infoWindow: InfoWindow(
              title: tree.status,
              snippet: "Check your pinned trees for more info."));
      markers[markerId] = marker;
    }

    return markers;
  }

  // ! Person

  Future<Person?> getPerson(String uid) async {
    var ref = _db.collection("person").doc(uid);
    var snapshot = await ref.get();

    if (!snapshot.exists || snapshot.data() == null) return null;

    return Person.fromJson(snapshot.data() ?? {});
  }

  Future updateAvatar(String lvl) async {
    User? user = AuthService().user;
    if (user == null) return;

    var ref = _db.collection("person").doc(user.uid);

    ref.update({"avatar": lvl});
  }

  Future updatePerson(String uid) async {
    User? user = AuthService().user;
    if (user == null) return;

    var ref = _db.collection("person").doc(user.uid);

    Person? person = await getPerson(uid);

    if (person == null) return;

    person.dailyPinnedTreeCount += 1;

    await ref.update(person.toMap());
  }

  Future<void> verifyAndResetDailyLimit() async {
    User? user = AuthService().user;
    if (user == null) return;

    var ref = _db.collection("person").doc(user.uid);

    List<Tree> trees = await getTreesFromCurrentUser();

    Person? person = await getPerson(user.uid);

    if (person == null) return;

    if (trees.isEmpty) {
      person.dailyPinnedTreeCount = 0;

      return await ref.update(person.toMap());
    }

    final differenceInHours = DateTimeService().daysBetween(
        DateTime.parse(trees[trees.length - 1].date), DateTime.now());
    print(differenceInHours);
    if (differenceInHours >= 24) person.dailyPinnedTreeCount = 0;

    await ref.update(person.toMap());
  }

  Stream<Person> streamPerson() {
    return AuthService().userStream.switchMap((user) {
      if (user == null) {
        return Stream.fromIterable([
          Person(
            uid: "n/a",
            name: "n/a",
            email: "n/a",
          )
        ]);
      }
      var ref = _db.collection("person").doc(user.uid);
      return ref.snapshots().map((doc) => Person.fromJson(doc.data()!));
    });
  }

  Future<List<Person>> getLeaderboard() async {
    User? user = AuthService().user;
    if (user == null) return [];
    var ref = _db.collection("person").orderBy("points", descending: true);

    var snapshot = await ref.get();

    var data = snapshot.docs.map((s) => s.data());

    var persons = data.map((d) => Person.fromJson(d));

    return persons.toList();
  }

  Future<void> addGoogleSignedPerson() async {
    var user = AuthService().user;
    if (user == null) return;

    var ref = _db.collection('person').doc(user.uid);

    if ((await ref.get()).exists) {
      return await FirestoreService().verifyAndResetDailyLimit();
    }

    Person person = Person(
      name: user.displayName!,
      uid: user.uid,
      email: user.email!,
    );

    await ref.set(person.toMap());
  }

  Future<void> addEmailAndPasswordPerson(
      String name, String emailAddress) async {
    User? user = AuthService().user;
    if (user == null) return;

    var ref = _db.collection('person').doc(user.uid);

    if ((await ref.get()).exists) {
      return await FirestoreService().verifyAndResetDailyLimit();
    }

    Person person = Person(
      name: name,
      uid: user.uid,
      email: emailAddress,
    );

    await ref.set(person.toMap());

    await user.reload();
  }
}
