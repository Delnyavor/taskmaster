class DurationConverter {
  final Duration duration;
  DurationConverter(this.duration);

  String convertToHHMM() {
    String minutes = _prepend(duration.inMinutes.remainder(60).toString());
    String hours = _prepend((duration.inHours.remainder(60)).toString());

    return "$hours:$minutes";
  }

  String convertToHHMMSS() {
    String seconds = _prepend(duration.inSeconds.remainder(60).toString());
    String minutes = _prepend(duration.inMinutes.remainder(60).toString());
    String hours = _prepend((duration.inHours.remainder(24)).toString());

    return "$hours:$minutes:$seconds";
  }

  String _prepend(String data) {
    data.padLeft(3, '0');
    return data;
  }
}
