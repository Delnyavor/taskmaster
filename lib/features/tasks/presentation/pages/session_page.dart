import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:taskmaster/core/colors.dart';
import 'package:taskmaster/core/scroll_behaviour.dart';
import 'package:taskmaster/features/tasks/presentation/widgets/dial.dart';
import 'package:taskmaster/features/tasks/presentation/widgets/secondary_task_widget.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({Key? key}) : super(key: key);

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  late List<String> list;

  @override
  void initState() {
    super.initState();
    generateItems();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) => printdata());
  }

  void generateItems() {
    list = List.generate(15, (index) => index.toString()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: TMColors.canvasWhite,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Column(
        children: [Dial(), label(), tasks()],
      ),
    );
  }

  Widget label() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 45),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            'session in progress'.toUpperCase(),
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              height: 1.5,
              color: TMColors.textLight,
            ),
          ),
        ),
      ],
    );
  }

  Widget tasks() {
    return Flexible(
      child: Hero(
        tag: 'CTR',
        child: Container(
          margin: const EdgeInsets.fromLTRB(30, 15, 30, 30),
          decoration: BoxDecoration(
            color: TMColors.violet.withOpacity(0.95),
            borderRadius: BorderRadius.circular(30),
          ),
          child: ScrollConfiguration(
              behavior: NoOverScrollGlowBehavior(),
              child: Column(
                children: [taskHeader(), taskList()],
              )),
        ),
      ),
    );
  }

  Widget taskHeader() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 21),
      margin: const EdgeInsets.symmetric(horizontal: 21),
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: TMColors.lavender, width: 0.5))),
      child: const Text(
        '15:13 - 18:43',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget taskList() {
    return Flexible(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return SecondaryTaskWidget(
            key: Key('$index'),
            index: index,
            text: list[index],
          );
        },
      ),
    );
  }
}
