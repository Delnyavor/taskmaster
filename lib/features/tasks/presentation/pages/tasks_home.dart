import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskmaster/core/colors.dart';
import 'package:taskmaster/core/scroll_behaviour.dart';
import 'package:taskmaster/features/tasks/presentation/widgets/create_task_modal.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(child: body()),
      bottomNavigationBar: const BottomAppBar(
        notchMargin: 5,
      ),
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
        background(),
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
          tasksWidget(),
          // image(),
        ],
      ),
    );
  }

  Widget background() {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            TMColors.canvasWhite,
            Color(0xFF000000),
          ],
        ),
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
            calendarRow(),
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

  Widget tasksWidget() {
    return TasksList();
  }

  Widget image() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(
            height: 250,
            width: 240,
            child: Placeholder(),
          ),
          const SizedBox(height: 28),
          text()
        ],
      ),
    );
  }

  Widget text() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        'Click to add tasks'.toUpperCase(),
        textAlign: TextAlign.left,
        style: const TextStyle(height: 1.5, color: TMColors.textLight),
      ),
    );
  }

  Widget calendarRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        calendarCard(),
        const SizedBox(width: 8),
        calendarCard(selected: true),
        const SizedBox(width: 8),
        calendarCard(),
        const SizedBox(width: 8),
        calendarCard(),
      ],
    );
  }

  Widget calendarCard({bool selected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      decoration: cardDecoration(selected),
      child: cardContent(selected),
    );
  }

  Widget cardContent(bool selected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('13',
            style: TextStyle(
                fontSize: 20,
                color: selected ? Colors.white : TMColors.textMedium)),
        const SizedBox(height: 3),
        Text("APR\n|\nTUE",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color: selected ? Colors.white : TMColors.textMedium)),
      ],
    );
  }

  Decoration cardDecoration(bool selected) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      color: selected
          ? TMColors.teal.withOpacity(0.62)
          : TMColors.lavender.withOpacity(0.5),
      border: Border.fromBorderSide(
        BorderSide(
            color: selected
                ? TMColors.teal.withOpacity(0)
                : TMColors.violet.withOpacity(0.23),
            width: 2.6),
      ),
    );
  }
}
