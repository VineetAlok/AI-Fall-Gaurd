import 'package:flutter/material.dart';
import 'dart:developer';

import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:fall_detection/setting.dart';
import 'dart:developer';

import 'package:fall_detection/emergency.dart';
import 'package:flutter/material.dart';
import 'package:fall_detection/setting.dart';
import 'package:fall_detection/main.dart';
import 'package:fall_detection/emergency.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class emergency extends StatefulWidget {
  const emergency({Key? key}) : super(key: key);

  @override
  State<emergency> createState() => _emergencyState();
}

class _emergencyState extends State<emergency> {
  final TextEditingController _numberCtrl = TextEditingController();
  @override
  void initState() {
    super.initState();
    _numberCtrl.text = "8826260344";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Emergency Contact'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _numberCtrl,
                decoration: const InputDecoration(labelText: "Contact"),
                keyboardType: TextInputType.number,
              ),
            ),
            ElevatedButton(
              child: const Text("Call"),
              onPressed: () async {
                FlutterPhoneDirectCaller.callNumber(_numberCtrl.text);
              },
            )
          ],
        ),
      ),
    );
  }
}
