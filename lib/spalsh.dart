import 'package:dummy_6/home.dart';
import 'package:dummy_6/login.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Spalsh extends StatefulWidget {
  const Spalsh({super.key});

  @override
  State<Spalsh> createState() => _SpalshState();
}

class _SpalshState extends State<Spalsh> {
  @override
  initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async {
      tap();
    });
  }

  Future<void> tap() async {
    final save = await SharedPreferences.getInstance();

    String? username = save.getString("username");
    final loggined = save.getBool("login") ?? false;
    if (!mounted) return;
    if (loggined) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home(username: username ?? "")),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text(
          "SPLASH",
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
      ),
    );
  }
}
