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

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Circular Countdown Timer Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const sensors(title: 'Circular Countdown Timer'),
    );
  }
}

class sensors extends StatefulWidget {
  const sensors({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<sensors> createState() => _sensors();
}

class _sensors extends State<sensors> {
  final int _duration = 10;
  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: CircularCountDownTimer(
          // Countdown duration in Seconds.
          duration: _duration,

          // Countdown initial elapsed Duration in Seconds.
          initialDuration: 0,

          // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
          controller: _controller,

          // Width of the Countdown Widget.
          width: MediaQuery.of(context).size.width / 2,

          // Height of the Countdown Widget.
          height: MediaQuery.of(context).size.height / 2,

          // Ring Color for Countdown Widget.
          ringColor: Colors.grey[300]!,

          // Ring Gradient for Countdown Widget.
          ringGradient: null,

          // Filling Color for Countdown Widget.
          fillColor: Colors.purpleAccent[100]!,

          // Filling Gradient for Countdown Widget.
          fillGradient: null,

          // Background Color for Countdown Widget.
          backgroundColor: Colors.purple[500],

          // Background Gradient for Countdown Widget.
          backgroundGradient: null,

          // Border Thickness of the Countdown Ring.
          strokeWidth: 20.0,

          // Begin and end contours with a flat edge and no extension.
          strokeCap: StrokeCap.round,

          // Text Style for Countdown Text.
          textStyle: const TextStyle(
            fontSize: 33.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),

          // Format for the Countdown Text.
          textFormat: CountdownTextFormat.S,

          // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
          isReverse: true,

          // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
          isReverseAnimation: true,

          // Handles visibility of the Countdown Text.
          isTimerTextShown: true,

          // Handles the timer start.
          autoStart: true,

          // This Callback will execute when the Countdown Starts.
          onStart: () {
            // Here, do whatever you want
            debugPrint('Countdown Started');
          },

          // This Callback will execute when the Countdown Ends.
          onComplete: () {
            // Here, do whatever you want
            debugPrint('Countdown Ended');
          },

          // This Callback will execute when the Countdown Changes.
          onChange: (String timeStamp) {
            // Here, do whatever you want
            debugPrint('Countdown Changed $timeStamp');
          },

          /* 
            * Function to format the text.
            * Allows you to format the current duration to any String.
            * It also provides the default function in case you want to format specific moments
              as in reverse when reaching '0' show 'GO', and for the rest of the instances follow 
              the default behavior.
          */
          // timeFormatterFunction: (defaultFormatterFunction, duration) {
          //   if (duration.inSeconds == 0) {
          //     // only format for '0'
          //     return "Start";
          //   } else {
          //     // other durations by it's default format
          //     return Function.apply(defaultFormatterFunction, [duration]);
          //   }
          // },
        ),
      ),
    );
  }
}
