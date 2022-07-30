import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskmaster/core/colors.dart';
import 'package:taskmaster/core/scroll_behaviour.dart';
import 'package:taskmaster/features/tasks/presentation/widgets/calendar_card.dart';
import 'package:taskmaster/features/tasks/presentation/widgets/create_task_modal.dart';
import 'package:taskmaster/features/tasks/presentation/widgets/tasks_header.dart';
import 'package:taskmaster/features/tasks/presentation/widgets/tasks_list.dart';

class TasksHome extends StatefulWidget {
  const TasksHome({Key? key}) : super(key: key);

  @override
  State<TasksHome> createState() => TasksHomeState();
}

class TasksHomeState extends State<TasksHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: TMColors.canvasWhite,
      body: SafeArea(child: body()),
    );
  }

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  Widget floatingActionButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 80,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          // boxShadow: [
          // BoxShadow(
          //     color: Colors.white.withOpacity(0.21),
          //     offset: const Offset(0, 0),
          //     spreadRadius: 3,
          //     blurRadius: 6),
          // BoxShadow(
          //     color: TMColors.teal.withOpacity(1),
          //     offset: const Offset(0, 0),
          //     spreadRadius: -1,
          //     blurRadius: 8),
          // ],
        ),
        child: Builder(
          builder: (BuildContext newcontext) => FloatingActionButton(
            elevation: 0,
            backgroundColor: TMColors.teal,
            onPressed: () {
              openCreateTaskModal(newcontext);
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget body() {
    return Stack(
      children: [
        scrollView(),
        floatingActionButton(),
      ],
    );
  }

  Widget scrollView() {
    return ScrollConfiguration(
      behavior: NoOverScrollGlowBehavior(),
      child: CustomScrollView(
        slivers: [
          sliverAppBar(),
          calendar(),
          tasksHeader(),
          tasksWidget(),
          // image(),
        ],
      ),
    );
  }

  SliverAppBar sliverAppBar() {
    return SliverAppBar(
      elevation: 0,
      toolbarHeight: 140,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: title(),
    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Wrap(
        children: const [
          Center(
            child: Text(
              'A clean slate! Let’s find something to do...',
              style: TextStyle(
                  fontSize: 15, height: 1.5, color: TMColors.textMedium),
            ),
          )
        ],
      ),
    );
  }

  Widget calendar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 100),
        child: Column(
          children: [
            label(),
            const CalendarRow(),
          ],
        ),
      ),
    );
  }

  Widget label() {
    return Row(
      children: const [
        Padding(
          padding: EdgeInsets.only(bottom: 11.0),
          child: Text(
            'Calendar',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 12, height: 1.5, color: TMColors.textMedium),
          ),
        ),
      ],
    );
  }

  Widget tasksHeader() {
    return const SliverToBoxAdapter(
      child: TasksHeader(),
    );
  }

  Widget tasksWidget() {
    return const TasksList();
  }

  // Widget image() {
  //   return SliverToBoxAdapter(
  //     child: Column(
  //       children: [
  //         const SizedBox(
  //           height: 250,
  //           width: 240,
  //           child: Placeholder(),
  //         ),
  //         const SizedBox(height: 28),
  //         text()
  //       ],
  //     ),
  //   );
  // }

  // Widget text() {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 12.0),
  //     child: Text(
  //       'Click to add tasks'.toUpperCase(),
  //       textAlign: TextAlign.left,
  //       style: const TextStyle(height: 1.5, color: TMColors.textLight),
  //     ),
  //   );
  // }
}
