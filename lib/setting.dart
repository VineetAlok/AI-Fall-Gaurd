import 'package:fall_detection/emergency.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensors Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class setting extends StatefulWidget {
  const setting({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  final int _duration = 10;
  final CountDownController _controller = CountDownController();

  double _acceleration = 0;
  double _gyroscope = 0;
  static const int _snakeRows = 20;
  static const int _snakeColumns = 20;
  static const double _snakeCellSize = 10.0;

  List<double>? _accelerometerValues;
  List<double>? _userAccelerometerValues;
  List<double>? _gyroscopeValues;
  List<double>? _magnetometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  @override
  Widget build(BuildContext context) {
    final accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    final gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(1)).toList();
    final userAccelerometer = _userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        .toList();
    final magnetometer =
        _magnetometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor Readings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Accelerometer: $accelerometer'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('UserAccelerometer: $userAccelerometer'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Gyroscope: $gyroscope'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      accelerometerEvents.listen(
        (AccelerometerEvent event) {
          setState(() {
            _accelerometerValues = <double>[event.x, event.y, event.z];
            _acceleration =
                sqrt(pow(event.x, 2) + pow(event.y, 2) + pow(event.z, 2));
            if (_acceleration > 30) {
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Press if you are ok'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => emergency()));
                    },
                  ));
              showDialog(
                context: context,
                builder: (BuildContext context) => _buildPopupDialog(context),
              );
            }
          });
        },
      ),
    );
    _streamSubscriptions.add(
      gyroscopeEvents.listen(
        (GyroscopeEvent event) {
          setState(() {
            _gyroscopeValues = <double>[event.x, event.y, event.z];
            _gyroscope =
                sqrt(pow(event.x, 2) + pow(event.y, 2) + pow(event.z, 2));

            // if (_gyroscope > 30) {
            // Container(
            //     height: 50,
            //     padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            //     child: ElevatedButton(
            //       child: const Text('Press if you are ok'),
            //       onPressed: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) => emergency()));
            //       },
            //     ));
            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) => _buildPopupDialog(context),
            // );
            // }
          });
        },
      ),
    );
    _streamSubscriptions.add(
      userAccelerometerEvents.listen(
        (UserAccelerometerEvent event) {
          setState(() {
            _userAccelerometerValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
  }
}

final int _duration = 60;
final CountDownController _controller = CountDownController();
Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text('Fall Detected'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //Text("If you fine press OK"),

        Center(
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
            fillColor: Color.fromARGB(255, 128, 184, 252)!,

            // Filling Gradient for Countdown Widget.
            fillGradient: null,

            // Background Color for Countdown Widget.
            backgroundColor: Color.fromARGB(255, 122, 193, 227),

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
        Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(50, 0, 10, 0),
            child: ElevatedButton(
              child: const Text('Press if you are ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )),
        SizedBox(
          height: 20,
        ),
        Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(50, 0, 10, 10),
            child: ElevatedButton(
              child: const Text('SOS'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => emergency()));
              },
            )),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColorLight,
        child: const Text(''),
        minWidth: 30,
      ),
    ],
  );
}
