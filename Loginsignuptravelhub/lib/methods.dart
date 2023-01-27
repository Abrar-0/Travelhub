import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Screens/Login/login_screen.dart';

Future<User> createAccount(String name, String address, String phone, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    User user = (await _auth.createUserWithEmailAndPassword(
        email: email, password: password)).user;
    if (user != null) {
      print("Account created successfully");
      await  _firestore.collection('users').doc(_auth.currentUser.uid).set({
        "name": name,
        "address": address,
        "phone": phone,
        "email": email,
      });
      return user;
    }
    else {
      print("Account creation failed");
      return user;
    }
  }
  catch (e) {
    print(e);
    return null;
  }
}

class User {
}

Future<User> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try{
    User user = (await _auth.signInWithEmailAndPassword(
        email: email, password: password)).user;
    if (user != null) {
      print("Login successful");
      return user;
    }
    else {
      print("Login failed");
      return user;
    }
  }
  catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value){
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  } catch (e) {
    print("error");
  }
}