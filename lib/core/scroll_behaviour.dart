import 'package:flutter/cupertino.dart';

class NoOverScrollGlowBehavior extends ScrollBehavior {
  @override
  // ignore: override_on_non_overriding_member
  Widget buildOverscrollBehavior(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
