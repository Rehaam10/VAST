import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/snackbar.dart';

class AuthRepo {
///////////////////////////////////////
///////////////////////////////////////

///////////////////////////////////////
///////////////////////////////////////
  static Future<void> signUpWithEmailAndPassword(email, password) async {
    final auth = FirebaseAuth.instance;
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

///////////////////////////////////////
///////////////////////////////////////
  static Future<void> signInWithEmailAndPassword(email, password) async {
    final auth = FirebaseAuth.instance;
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

///////////////////////////////////////
///////////////////////////////////////
  static Future<void> sendEmailVerification() async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

//////////////////////////////////////
//////////////////////////////////////
  static get uid {
    User user = FirebaseAuth.instance.currentUser!;
    return user.uid;
  }

//////////////////////////////////////
//////////////////////////////////////
  static Future<void> reloadUserData() async {
    await FirebaseAuth.instance.currentUser!.reload();
  }

//////////////////////////////////////
//////////////////////////////////////
  static Future<void> updateUserName(displayName) async {
    User user = FirebaseAuth.instance.currentUser!;
    await user.updateDisplayName(displayName);
  }

  static Future<void> updateProfileImage(profileImage) async {
    User user = FirebaseAuth.instance.currentUser!;
    await user.updatePhotoURL(profileImage);
  }

  static Future<bool> checkEmailVerification() async {
    try {
      bool emailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      return emailVerified == true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  static Future<void> logOut() async {
    final auth = FirebaseAuth.instance;
    await auth.signOut();
  }

  static Future<void> sendPasswordResetEmail(email) async {
    final GlobalKey<ScaffoldMessengerState> scaffoldKey =
        GlobalKey<ScaffoldMessengerState>();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      MyMessageHandler.showSnackBar(scaffoldKey, e.message.toString());
    }
  }

  static Future<bool> checkOldPassword(email, password) async {
    AuthCredential authCredential =
        EmailAuthProvider.credential(email: email, password: password);

    try {
      var credentialResult = await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(authCredential);
      return credentialResult.user != null;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  static Future<void> updateUserPassword(newPassword) async {
    User user = FirebaseAuth.instance.currentUser!;
    try {
      await user.updatePassword(newPassword);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
