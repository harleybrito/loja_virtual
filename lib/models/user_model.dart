import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User firebaseUser;
  Map<String, dynamic> userData = Map();
  bool isLoading = false;

  @override
  void addListener(listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  void signUp({@required Map<String, dynamic> userData, @required String pass, @required VoidCallback onSuccess, @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(email: userData['email'], password: pass).then((user) async {
      firebaseUser = user.user;
      await _saveUserData(userData);
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  bool isLoggedIn() => firebaseUser != null;

  void signIn({@required String email, @required String pass, @required VoidCallback onSuccess, @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: pass).then((user) async {
      firebaseUser = user.user;
      await _loadCurrentUser();
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signOut() async {
    await _auth.signOut();
    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  Future _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid).set(userData);
  }

  Future _loadCurrentUser() async {
    if (firebaseUser == null) {
      firebaseUser = _auth.currentUser;
    } else if (userData['name'] == null) {
      DocumentSnapshot docUser = await FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid).get();
      userData = docUser.data();
    }
    notifyListeners();
  }
}
