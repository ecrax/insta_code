import 'dart:math';

dynamic randomElementFromMap(Map map) {
  final _random = Random();
  final values = map.values.toList();
  final element = values[_random.nextInt(values.length)];
  return element;
}
