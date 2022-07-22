class DurationConverter {
  final Duration duration;
  DurationConverter(this.duration) {}

  List<int> convertToHHMM() {
    int time = duration.inMinutes;
    int minutes = time.remainder(60);
    int hours = time ~/ 60;
    return [hours, minutes];
  }

  String convertToHHMMString() {
    int time = duration.inMinutes;
    String minutes = _prepend(time.remainder(60).toString());
    String hours = _prepend((time ~/ 60).toString());

    return "$hours:$minutes";
  }

  String _prepend(String data) {
    if (data.length < 2) {
      data = "0$data";
    }
    return data;
  }
}
