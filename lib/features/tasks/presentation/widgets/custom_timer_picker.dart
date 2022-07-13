import 'package:flutter/material.dart';
import 'package:taskmaster/core/colors.dart';
import 'package:taskmaster/core/scroll_behaviour.dart';

class CustomTimerPicker extends StatefulWidget {
  const CustomTimerPicker({Key? key}) : super(key: key);

  @override
  State<CustomTimerPicker> createState() => _CustomTimerPickerState();
}

class _CustomTimerPickerState extends State<CustomTimerPicker> {
  int selectedindex = 0;
  int selectedindex2 = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 0.6,
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: contents(),
        ),
      ),
    );
  }

  Widget contents() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        title(),
        timeSelector(),
        setDurationButton(),
      ],
    );
  }

  Widget title() {
    return Row(children: [
      Text(
        'create task'.toUpperCase(),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: TMColors.teal,
        ),
      ),
      SizedBox(
        width: 14,
        child: separator(size: 3),
      ),
      Text(
        'select duration'.toUpperCase(),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: TMColors.textLight,
        ),
      )
    ]);
  }

  Widget timeSelector() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 160,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [headertext('hh'), headertext('mm')],
          ),
        ),
        Flexible(
          child: SizedBox(
            height: 400,
            child: Stack(
              children: [
                centerWidget(),
                timeScroll(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget headertext(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      margin: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      width: 68,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: TMColors.textMedium, width: 0.5),
        ),
      ),
      child: Text(
        text.toUpperCase(),
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 12,
            color: Colors.black26,
            height: 0,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget setDurationButton() {
    return TextButton(
      onPressed: () {},
      child: Text(
        'set duration'.toUpperCase(),
        style: const TextStyle(
          fontSize: 14,
          color: TMColors.teal,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget timeScroll() {
    return Container(
      padding: const EdgeInsets.only(left: 40, right: 40),
      height: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TimeList(
            isMinute: false,
            onChanged: (index) {
              selectedindex = index;
              setState(() {});
            },
          ),
          TimeList(
              isMinute: true,
              onChanged: (index) {
                selectedindex2 = index;
                setState(() {});
              }),
        ],
      ),
    );
  }

  Widget centerWidget() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 60,
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(color: TMColors.textLight),
          borderRadius: BorderRadius.circular(20),
          color: TMColors.canvasWhite,
        ),
        child: separator(),
      ),
    );
  }

  Widget separator({double size = 6}) {
    return Center(
      child: Container(
        height: size,
        width: size,
        decoration: const BoxDecoration(
          color: TMColors.textLight,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class TimeList extends StatefulWidget {
  final Function(int) onChanged;
  final bool isMinute;
  const TimeList({Key? key, required this.onChanged, required this.isMinute})
      : super(key: key);

  @override
  State<TimeList> createState() => TimeListState();
}

class TimeListState extends State<TimeList> {
  final FixedExtentScrollController controller =
      FixedExtentScrollController(initialItem: 0);
  bool scrolling = false;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: 68,
        child: NotificationListener(
          onNotification: handleScrollNotification,
          child: scrollView(),
        ),
      ),
    );
  }

  Widget scrollView() {
    return ListWheelScrollView(
      scrollBehavior: NoOverScrollGlowBehavior(),
      controller: controller,
      itemExtent: 55,
      diameterRatio: 10000,
      children: widget.isMinute ? buildMinutes() : buildHours(),
      onSelectedItemChanged: (index) {
        setState(() {
          selectedIndex = index;
          widget.onChanged(index);
        });
      },
    );
  }

  List<Widget> buildMinutes() {
    return List.generate(4, (index) => index)
        .map((index) => timeText(index, textFormat(index * 15)))
        .toList();
  }

  List<Widget> buildHours() {
    return List.generate(7, (index) => index)
        .map((index) => timeText(index, textFormat(index)))
        .toList();
  }

  Widget timeText(int index, String text) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 5000),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: index == selectedIndex ? 32 : 24,
            color: TMColors.textLight,
            height: 0,
            letterSpacing: -0.5,
          ),
        ),
      ),
    );
  }

  String textFormat(int index) {
    if (index < 10) {
      return "0${index.toString()}";
    }
    return index.toString();
  }

  bool handleScrollNotification(Notification notification) {
    if (notification is ScrollStartNotification) {
      setScrollState(true);
    }
    if (notification is ScrollUpdateNotification) {
      if (scrolling == false) {
        setScrollState(true);
      }
    }
    if (notification is ScrollEndNotification) {
      setScrollState(false);
      snap();
    }
    return true;
  }

  void snap() {
    Future.delayed(const Duration(milliseconds: 0), () async {
      double currentPosition = (selectedIndex) * 55;

      if (!scrolling) {
        controller.animateTo(
          currentPosition,
          duration: const Duration(milliseconds: 200),
          curve: Curves.linear,
        );
      }
    });
  }

  void setScrollState(bool isScrolling) {
    setState(() {
      scrolling = isScrolling;
    });
  }
}
