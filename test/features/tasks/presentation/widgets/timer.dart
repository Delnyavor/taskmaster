import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taskmaster/core/duration_converter.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Duration duration = Duration(seconds: const Duration(hours: 3).inSeconds);
  late Timer timer;

  String text = "00:00";

  @override
  void initState() {
    super.initState();
    text = DurationConverter(duration).convertToHHMMSS();

    // WidgetsBinding.instance.addPostFrameCallback((_) => startTimer());
    startTimer();
  }

  void startTimer() {
    timer =
        Timer.periodic(const Duration(milliseconds: 1000), (_) => countDown());
  }

  void countDown() {
    final timeLeft = duration.inSeconds - 1;

    setState(() {
      if (timeLeft > 0) {
        duration = Duration(seconds: timeLeft);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -30),
      child: Text(
        DurationConverter(duration).convertToHHMMSS(),
        style: const TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w500,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
