import 'package:breathe_green_final/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Stream<User?> userStream = FirebaseAuth.instance.userChanges();
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> anonLogin() async {
    try {
      await _auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<int?> googleLogin() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(authCredential);
      await FirestoreService().addGoogleSignedPerson();

      return 200;
    } on FirebaseAuthException catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String emailAddress, String password, String name) async {
    await _auth.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

    await FirestoreService().addEmailAndPasswordPerson(name, emailAddress);
  }

  Future<void> signInWithEmailAndPassword(
      String emailAddress, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    await FirestoreService().verifyAndResetDailyLimit();
  }

  Future<void> verifyEmail() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) return;

      await currentUser.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<bool> checkEmailVerified() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) return false;

    await currentUser.reload();

    return currentUser.emailVerified;
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }
}
