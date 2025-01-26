import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum UserState {
  signedIn,
  signedOut,
  logging,
  noVerification,
  unauthorized,
}

class AuthService with ChangeNotifier {
  AuthService._privateConstructor();

  static final AuthService _instance = AuthService._privateConstructor();

  factory AuthService() {
    return _instance;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserState _userState = UserState.signedOut;
  String? _userRole;

  UserState get userState => _userState;
  String? get userRole => _userRole;

  User? get currentUser {
    return _auth.currentUser;
  }

  set userState(UserState value) {
    _userState = value;
    notifyListeners();
  }

  void initialize() {
    _auth.authStateChanges().listen(authStateChange);
  }

  void authStateChange(User? user) {
    if (user == null) {
      userState = UserState.signedOut;
    } else {
      userState = UserState.signedIn;
    }
  }

  Future<void> _checkUserRole(User user) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        _userRole = userDoc['role'];
        userState = UserState.signedIn;
      } else {
        userState = UserState.unauthorized;
      }
    } catch (e) {
      debugPrint("Error checking user role: $e");
      userState = UserState.unauthorized;
    }
  }

  Future<String?> getUserRole(User? user) async {
    if (user == null) return null;
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();

      return userDoc.data()?['role'] as String?;
    } catch (e) {
      debugPrint("getUserRole error: $e");
      return null;
    }
  }

  Future<User?> createUserWithEmail(String email, String pass) async {
    try {
      userState = UserState.logging;
      UserCredential _credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      User? _newUser = _credential.user;

      if (_newUser != null) {
        await _firestore.collection('users').doc(_newUser.uid).set({
          'email': email,
          'role': "role",
        });

        await _newUser.sendEmailVerification();
        signOut();
        userState = UserState.noVerification;
      }
      return _newUser;
    } catch (e) {
      userState = UserState.signedOut;
      debugPrint("createUserWithEmail" + e.toString());
      return null;
    }
  }

  Future<User?> signInUserWithEmail(String email, String pass) async {
    try {
      userState = UserState.logging;
      UserCredential _credential =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      User? _signInUser = _credential.user;

      if (_signInUser?.emailVerified == false) {
        signOut();
        userState = UserState.noVerification;
        return null;
      } else {
        await _checkUserRole(_signInUser!);

        if (userState == UserState.signedIn) {
          return _auth.currentUser;
        } else {
          signOut();
          return null;
        }
      }
    } catch (e) {
      userState = UserState.signedOut;
      debugPrint("signInUserWithEmail" + e.toString());
      return null;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      userState = UserState.signedOut;
      return true;
    } catch (e) {
      debugPrint("signOutUserWithEmail" + e.toString());
      return false;
    }
  }
}
