import 'package:flutter/material.dart';
import 'package:taskmaster/core/colors.dart';
import 'package:taskmaster/core/duration_converter.dart';
import 'package:taskmaster/features/tasks/presentation/widgets/custom_timer_picker.dart';
import 'package:taskmaster/features/tasks/presentation/widgets/task_details_input.dart';

void openCreateTaskModal(BuildContext context) {
  Scaffold.of(context).showBottomSheet(
    elevation: 50,
    (context) => const CreateTaskWidget(),
    backgroundColor: TMColors.teal,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
    ),
  );
}

class CreateTaskWidget extends StatefulWidget {
  const CreateTaskWidget({Key? key}) : super(key: key);

  @override
  State<CreateTaskWidget> createState() => _CreateTaskWidgetState();
}

class _CreateTaskWidgetState extends State<CreateTaskWidget> {
  final TextEditingController controller = TextEditingController();

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
        inputForm(context),
        controls(),
      ],
    );
  }

  Widget inputForm(context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          label(),
          const TaskInputForm(),
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
            'create task'.toUpperCase(),
            textAlign: TextAlign.left,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                height: 1.5,
                color: TMColors.teal),
          ),
        ),
      ],
    );
  }

  Widget titleField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Title',
        hintStyle: labelStyle,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        fillColor: const Color(0xfff2f2f2).withOpacity(0.5),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color(0xfff2f2f2).withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: TMColors.teal,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  Widget controls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 15),
      child: Row(
        children: [
          // Expanded(
          //   child: TextButton(
          //     onPressed: () {},
          //     style: TextButton.styleFrom(
          //       padding: const EdgeInsets.symmetric(vertical: 14),
          //     ),
          //     child: Text(
          //       'Cancel'.toUpperCase(),
          //       textAlign: TextAlign.left,
          //       style: const TextStyle(
          //         fontWeight: FontWeight.w500,
          //         fontSize: 14,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  // backgroundColor: Colors.white,
                  // padding: const EdgeInsets.symmetric(vertical: 14),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(50),
                  // ),
                  ),
              child: Text(
                'Add task'.toUpperCase(),
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: TMColors.canvasWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget durationWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showPicker();
      },
      child: Container(
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
      ),
    );
  }

  void showPicker() async {
    Duration? data = await showDialog<Duration>(
      context: context,
      builder: (context) {
        return const CustomTimerPicker();
      },
    );

    if (time == Duration.zero) {
      setState(() {
        time = data ?? Duration.zero;
      });
    }
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
