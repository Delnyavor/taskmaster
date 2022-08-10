import 'package:flutter/material.dart';
import 'package:taskmaster/core/colors.dart';
import 'package:taskmaster/core/duration_converter.dart';
import 'package:taskmaster/core/scroll_behaviour.dart';
import 'package:taskmaster/features/tasks/presentation/pages/session_page.dart';
import 'package:taskmaster/features/tasks/presentation/widgets/dial.dart';
import 'package:taskmaster/features/tasks/presentation/widgets/secondary_task_widget.dart';
import 'package:taskmaster/features/tasks/presentation/widgets/task_widget.dart';

void openPreviewTaskModal(BuildContext context) {
  Scaffold.of(context).showBottomSheet(
    elevation: 50,
    (context) => const TaskPreviewWidget(),
    backgroundColor: TMColors.teal,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
    ),
  );
}

class TaskPreviewWidget extends StatefulWidget {
  const TaskPreviewWidget({Key? key}) : super(key: key);

  @override
  State<TaskPreviewWidget> createState() => _TaskPreviewWidgetState();
}

class _TaskPreviewWidgetState extends State<TaskPreviewWidget> {
  late List<String> list;

  @override
  void initState() {
    super.initState();
    generateItems();
  }

  void generateItems() {
    list = List.generate(15, (index) => index.toString()).toList();
  }

  final labelStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15,
    height: 1.5,
    color: Colors.black.withOpacity(0.27),
  );

  Duration time = Duration.zero;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: body(context),
        ),
        controls(),
      ],
    );
  }

  Widget body(context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          label(),
          tasksPreviewList(),
          const SizedBox(height: 30),
          durationWidget(context),
        ],
      ),
    );
  }

  Widget label() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text(
            'start session'.toUpperCase(),
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              // fontSize: 14,
              height: 1.5,
              color: TMColors.teal,
            ),
          ),
        ),
      ],
    );
  }

  Widget tasksPreviewList() {
    return Flexible(
      child: Hero(
        tag: 'CTR',
        child: Container(
          decoration: BoxDecoration(
            color: TMColors.violet.withOpacity(0.95),
            borderRadius: BorderRadius.circular(30),
          ),
          child: ScrollConfiguration(
              behavior: NoOverScrollGlowBehavior(),
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return SecondaryTaskWidget(
                    key: Key('$index'),
                    index: index,
                    text: list[index],
                  );
                },
              )),
        ),
      ),
    );
  }

  Widget controls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 35),
            ),
            child: Text(
              'Cancel'.toUpperCase(),
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SessionPage()));
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 35),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Text(
              'start session'.toUpperCase(),
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: TMColors.teal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget durationWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: TMColors.canvasWhite,
        border: Border.all(color: TMColors.textLight, width: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Duration',
            style: labelStyle.copyWith(fontSize: 11),
          ),
          durationText(),
        ],
      ),
    );
  }

  Widget durationText() {
    String d = DurationConverter(time).convertToHHMM();
    return Text(
      d,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 32,
        color: TMColors.textLight,
        height: 0,
        fontWeight: FontWeight.w500,
        letterSpacing: 1,
      ),
    );
  }
}
