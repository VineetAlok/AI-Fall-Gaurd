import 'dart:developer';

import 'package:fall_detection/emergency.dart';
import 'package:flutter/material.dart';
import 'package:fall_detection/setting.dart';
import 'package:fall_detection/main.dart';
import 'package:fall_detection/emergency.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';

class name extends StatelessWidget {
  const name({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class detecter extends StatefulWidget {
  detecter({Key? key}) : super(key: key);

  @override
  State<detecter> createState() => _detecterState();
}

class _detecterState extends State<detecter> {
  bool light = true;
  bool light1 = true;
  bool light2 = false;

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     centerTitle: true,
    //     title: Text("Detecter"),
    //     actions: [
    //       //list if widget in appbar actions
    //       PopupMenuButton(
    //         icon: Icon(Icons.menu), //don't specify icon if you want 3 dot menu
    //         color: Colors.blue,
    //         itemBuilder: (context) => [
    //           PopupMenuItem<int>(
    //             value: 0,
    //             child: Text(
    //               "Setting",
    //               style: TextStyle(color: Colors.white),
    //             ),
    //           ),

    //           PopupMenuItem<int>(
    //             value: 1,
    //             child: Text(
    //               "Profile",
    //               style: TextStyle(color: Colors.white),
    //             ),
    //           ),
    //         ],
    //         onSelected: (item) => {print(item)},
    //       ),
    //     ],
    //   ), //
    // );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sensors"),
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
                textTheme: TextTheme().apply(bodyColor: Colors.black),
                dividerColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.white)),
            child: PopupMenuButton<int>(
              color: Colors.black,
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                    value: 0,
                    child: Row(
                      children: [
                        Icon(
                          Icons.settings,
                          color: Color.fromARGB(255, 153, 138, 137),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text("Setting")
                      ],
                    )),
                PopupMenuItem<int>(value: 1, child: Text("Profile")),
                PopupMenuDivider(),
                PopupMenuItem<int>(
                    value: 2,
                    child: Row(
                      children: [
                        Icon(
                          Icons.emergency_share_outlined,
                          color: Color.fromARGB(255, 153, 138, 137),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text("Emergency")
                      ],
                    )),
              ],
              onSelected: (item) => SelectedItem(context, item),
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 45, right: 35, top: 20),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Detection Status  :::   ON',
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(255, 0, 0, 70)),
              ),
            ],
          ),
          SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Accelerometer',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
              ),
              // CircleAvatar(
              //   radius: 30,
              //   backgroundColor: Color(0xff4c505b),
              //   child: IconButton(
              //       color: Colors.white,
              //       onPressed: () {
              //         // Navigator.pushNamed(context, 'register');
              //       },
              //       icon: Icon(
              //         Icons.arrow_forward,
              //       )),
              // )
              Switch(
                // This bool value toggles the switch.
                value: light,
                activeColor: Color.fromARGB(255, 54, 165, 244),
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    light = value;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Gyroscope',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
              ),
              Switch(
                // This bool value toggles the switch.
                value: light1,
                activeColor: Color.fromARGB(255, 54, 165, 244),
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    light1 = value;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 300,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Disable Fall Detection ',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              Switch(
                // This bool value toggles the switch.
                value: light2,
                activeColor: Color.fromARGB(255, 54, 165, 244),
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    light2 = value;
                    light = false;
                    light1 = false;
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xff4c505b),
                child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => setting()));
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                    )),
              ),
            ],
          ),
        ]),
      ),
    );
  }

//for dropdown app bar navigation
  void SelectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => setting()));
        break;
      case 1:
        print("Profile");
        break;
      case 2:
        print("Emergency Contacts");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => emergency()));

        break;
    }
  }
}
