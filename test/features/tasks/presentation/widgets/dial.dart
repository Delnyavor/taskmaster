// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taskmaster/core/colors.dart';
import 'package:taskmaster/features/tasks/presentation/widgets/timer.dart';
import 'package:vector_math/vector_math.dart' as vc;

class Dial extends StatefulWidget {
  const Dial({Key? key}) : super(key: key);

  @override
  State<Dial> createState() => _DialState();
}

class _DialState extends State<Dial> {
  late List<Widget> children;
  Duration duration = const Duration(seconds: 6);
  final int count = 15;
  final int angle = 225;
  late double angleFraction;
  final double markerWidth = 2;
  final double markerHeight = 20;

  @override
  void initState() {
    super.initState();

    children = List.generate(
      count,
      (index) => Point(
        index: index,
        duration: duration,
        width: markerWidth,
        height: markerHeight,
        count: count,
      ),
    );

    angleFraction = angle / (count - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      // height: 300,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: AspectRatio(
          aspectRatio: 1.6,
          child: Transform.translate(
              offset: Offset(0, 55), child: positionPoints()),
        ),
      ),
    );
  }

  Widget positionPoints() {
    return Stack(
      alignment: Alignment.center,
      children: [
        for (Widget child in children)
          buildPoint(
            child,
            children.indexOf(child),
          ),
        const TimerWidget(),
      ],
      // children.map((e) => buildPoint(e, children.indexOf(e))).toList(),
    );
  }

  Widget buildPoint(Widget child, int index) {
    double thisAngle = 180 + (angleFraction * index);
    final double rad = vc.radians(thisAngle);

    return Transform.rotate(
      angle: vc.radians((angle - 180) / -2),
      child: Transform(
        origin: Offset(markerWidth / 2, 0),
        transform: Matrix4.identity()
          ..translate(
            (165) * cos(rad),
            (165) * sin(rad),
          )
          ..rotateZ(vc.radians(thisAngle + 90)),
        child: child,
      ),
    );
  }
}

class Point extends StatefulWidget {
  final int index;
  final Duration duration;
  final double height;
  final double width;
  final int count;
  const Point(
      {Key? key,
      required this.index,
      required this.duration,
      required this.height,
      required this.width,
      required this.count})
      : super(key: key);

  @override
  State<Point> createState() => _PointState();
}

class _PointState extends State<Point> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late double division;
  late double start;
  late double end;

  @override
  void initState() {
    super.initState();

    division = widget.duration.inSeconds / widget.count;

    ///tweaking the divisor changes the delay between the start times of each
    ///interval, increasing the aparent speed of the animation
    start = (division * widget.index / 2.8);

    ///tweaking the divisor changes how long each animation interval lasts
    end = start + (widget.duration.inSeconds / 1.5);

    // print('$start $end');

    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    animation = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(
            begin: 0.0,
            end: 1,
          ),
          weight: 0.2),
      TweenSequenceItem(
        tween: ConstantTween<double>(1.0),
        weight: 0.7,
      ),
      TweenSequenceItem(
          tween: Tween<double>(
            begin: 1.0,
            end: 0.0,
          ),
          weight: 0.2),
    ]).animate(
      CurvedAnimation(
        parent: controller,
        curve:
            //  Curves.linear
            Interval((start / widget.duration.inSeconds),
                end / widget.duration.inSeconds,
                curve: Curves.easeInOut),
      ),
    );

    controller.addListener(() {
      if (controller.isCompleted) {
        controller.reset();
        controller.forward();
      }
    });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return FadeTransition(
          opacity: animation,
          child: Container(
            height: widget.height,
            width: widget.width,
            color: TMColors.violet,
          ),
        );
      },
    );
  }
}
