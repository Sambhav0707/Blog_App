int calculateTime(String content) {
  final words = content.split(RegExp(r'\s+')).length;

  final calculatedTime = words / 225;

  return calculatedTime.ceil();
}
